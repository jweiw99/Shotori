Public Class Home
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim todayProfit As Decimal = 0.0
            Dim today = DateTime.Now.Date
            Dim tomorrow = today.AddDays(1)
            Dim tempTodayProfit = ctx.CustomerOrder.Where(Function(g) g.UpdateDateTime >= today And g.UpdateDateTime < tomorrow And g.Status = 1).ToList
            If tempTodayProfit.Count > 0 Then
                For Each item In tempTodayProfit
                    todayProfit += item.Price - item.BasePrice
                Next
            End If
            lbltodayProfit.InnerText = todayProfit

            Dim monthProfit As Decimal = 0.0
            Dim monthRevenue As Decimal = 0.0
            Dim monthCost As Decimal = 0.0
            Dim tempMonthProfit = ctx.CustomerOrder.Where(Function(g) g.UpdateDateTime.Year = today.Year And g.UpdateDateTime.Month = today.Month And g.Status = 1).ToList
            If tempMonthProfit.Count > 0 Then
                For Each item In tempMonthProfit
                    monthRevenue += item.Price
                    monthProfit += item.Price - item.BasePrice
                    monthCost += item.BasePrice
                Next
            End If
            lblmonthProfit.InnerText = monthProfit
            lblmonthRevenue.InnerText = monthRevenue
            lvlmonthCost.InnerText = monthCost

            Dim tempPendingOrder = ctx.CustomerOrder.Where(Function(g) g.Status = 3).ToList
            lblpendingOrder.InnerText = tempPendingOrder.Count

            Dim tempOnDelivery = ctx.CustomerOrder.Where(Function(g) g.Status = 2).ToList
            lblOnDelivery.InnerText = tempOnDelivery.Count

            'customer only
            Dim tempCustomerRegister = ctx.Users.Where(Function(g) g.Roles.Select(Function(u) u.RoleId).Contains("4f624960-b5a2-41b7-8a93-15c81546a5e4")).ToList
            lblcustomerRegister.InnerText = tempCustomerRegister.Count

            Dim tempCancelOrder = ctx.CustomerOrder.Where(Function(g) g.UpdateDateTime.Year = today.Year And g.UpdateDateTime.Month = today.Month And g.Status = 0).ToList
            lblcancelOrder.InnerText = tempCancelOrder.Count

        End If
    End Sub

    Public Function gvOrder_GetData() As IQueryable(Of CustomerOrder)
        Dim orders = ctx.CustomerOrder.Where(Function(g) g.CreateDateTime.Year = Today.Year And g.CreateDateTime.Month = Today.Month And g.Status <> 0).OrderByDescending(Function(g) g.Qty).Take(3).ToList
        Return orders.AsQueryable()
    End Function

    Protected ReadOnly Property dailySales() As String
        Get
            Dim today As Date = Date.Today
            Dim dayIndex As Integer = today.DayOfWeek
            If dayIndex < DayOfWeek.Monday Then
                dayIndex += 7 'Monday is first day of week, no day of week should have a smaller index
            End If
            Dim dayDiff As Integer = dayIndex - DayOfWeek.Monday
            Dim firstDayOfWeek As Date = today.AddDays(-dayDiff)
            Dim dailySalesData = New Decimal() {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}
            For index As Integer = 0 To 6
                Dim tdy = firstDayOfWeek.AddDays(index).Date
                Dim tmr = firstDayOfWeek.AddDays(index + 1).Date
                Dim order = ctx.CustomerOrder.Where(Function(g) g.UpdateDateTime >= tdy And g.UpdateDateTime < tmr And g.Status = 1).ToList
                For Each oItem In order
                    dailySalesData(index) += oItem.Price - oItem.BasePrice
                Next
            Next

            Return String.Join(",", dailySalesData)
        End Get
    End Property

    Protected ReadOnly Property receivedOrders() As String
        Get
            Dim today As Date = Date.Today
            Dim dayIndex As Integer = today.DayOfWeek
            If dayIndex < DayOfWeek.Monday Then
                dayIndex += 7 'Monday is first day of week, no day of week should have a smaller index
            End If
            Dim dayDiff As Integer = dayIndex - DayOfWeek.Monday
            Dim firstDayOfWeek As Date = today.AddDays(-dayDiff)
            Dim dailyOrderData = New Integer() {0, 0, 0, 0, 0, 0, 0}
            For index As Integer = 0 To 6
                Dim tdy = firstDayOfWeek.AddDays(index).Date
                Dim tmr = firstDayOfWeek.AddDays(index + 1).Date
                Dim order = ctx.CustomerOrder.Where(Function(g) g.CreateDateTime >= tdy And g.CreateDateTime < tmr And g.Status = 3).ToList
                dailyOrderData(index) = order.Count
            Next

            Return String.Join(",", dailyOrderData)
        End Get
    End Property

    Protected ReadOnly Property dailySalesPercent() As String
        Get
            Dim todayProfit As Decimal = 0.0
            Dim yesterdayProfit As Decimal = 0.0
            Dim today = DateTime.Now.Date
            Dim yesterday = today.AddDays(-1)
            Dim tomorrow = today.AddDays(1)
            Dim tempTodayProfit = ctx.CustomerOrder.Where(Function(g) g.UpdateDateTime >= today And g.UpdateDateTime < tomorrow And g.Status = 1).ToList
            If tempTodayProfit.Count > 0 Then
                For Each item In tempTodayProfit
                    todayProfit += item.Price - item.BasePrice
                Next
            End If
            Dim tempYesterdayProfit = ctx.CustomerOrder.Where(Function(g) g.UpdateDateTime >= yesterday And g.UpdateDateTime < today And g.Status = 1).ToList
            If tempYesterdayProfit.Count > 0 Then
                For Each item In tempYesterdayProfit
                    yesterdayProfit += item.Price - item.BasePrice
                Next
            End If

            Dim percentage = calcPercentage(todayProfit, yesterdayProfit)

            If todayProfit < yesterdayProfit Then
                Return "<span class='text-danger' ><i class='fa fa-arrow-down'></i> " & percentage & "%</span> decrease in today sales."
            Else
                Return "<span class='text-success' ><i class='fa fa-arrow-up'></i> " & percentage & "%</span> increase in today sales."
            End If

        End Get
    End Property

    Protected ReadOnly Property receivedOrderPercent() As String
        Get
            Dim todayOrder As Integer = 0
            Dim yesterdayOrder As Integer = 0
            Dim today = DateTime.Now.Date
            Dim yesterday = today.AddDays(-1)
            Dim tomorrow = today.AddDays(1)
            Dim tempTodayOrder = ctx.CustomerOrder.Where(Function(g) g.CreateDateTime >= today And g.CreateDateTime < tomorrow And g.Status = 3).ToList
            todayOrder = tempTodayOrder.Count
            Dim tempYesterdayOrder = ctx.CustomerOrder.Where(Function(g) g.CreateDateTime >= yesterday And g.CreateDateTime < today And g.Status = 3).ToList
            yesterdayOrder = tempYesterdayOrder.Count

            Dim percentage = calcPercentage(todayOrder, yesterdayOrder)

            If todayOrder < yesterdayOrder Then
                Return "<span class='text-danger' ><i class='fa fa-arrow-down'></i> " & percentage & "%</span> decrease in today order."
            Else
                Return "<span class='text-success' ><i class='fa fa-arrow-up'></i> " & percentage & "%</span> increase in today order."
            End If

        End Get
    End Property

    Function calcPercentage(a, b) As String
        Dim tempPercent As Decimal = 0.0
        Try
            tempPercent = 100 * Math.Abs((a - b) / ((a + b) / 2))
        Catch ex As Exception
            tempPercent = 0.0
        End Try

        Return FormatNumber(CDbl(tempPercent), 0)
    End Function

    Public Function ConvertProName(ByVal id As Integer) As String
        Dim product = ctx.Product.Where(Function(g) g.ProId = id).SingleOrDefault
        If product IsNot Nothing Then
            Return product.Name
        Else
            Return "Product Removed"
        End If
    End Function

    Public Function ConvertCategory(ByVal id As Integer) As String
        Dim product = ctx.Product.Where(Function(g) g.ProId = id).SingleOrDefault
        If product IsNot Nothing Then
            Dim category = ctx.ProductCategories.Where(Function(g) g.CatId = product.CatId).SingleOrDefault
            If category IsNot Nothing Then
                Return category.Name
            End If
        End If

        Return "Category Removed"
    End Function

End Class