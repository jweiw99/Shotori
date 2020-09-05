Imports System.Data.Entity.Infrastructure
Imports System.Web.ModelBinding

Public Class Order
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Function gvOrder_GetData() As IQueryable(Of CustomerOrder)
        Dim products = ctx.CustomerOrder.ToList()
        If Not String.IsNullOrEmpty(txtSearch.Text.Trim()) Then
            products = ctx.CustomerOrder.Where(Function(g) g.oId = CInt(txtSearch.Text.Trim())).ToList()
        End If
        Return products.AsQueryable()
    End Function

    Public Sub SearchOrder()
        GvOrders.DataBind()
    End Sub

    Private Sub gvOrder_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles GvOrders.RowEditing
        errorMessage.Text = ""
        Dim rawByte = Convert.FromBase64String(CType(GvOrders.Rows(e.NewEditIndex).FindControl("RowVersion"), Label).Text)
        Session("originalRowVersion") = rawByte
    End Sub

    Public Sub gvOrder_UpdateItem(ByVal oId As Integer)
        Dim item As Shotori.CustomerOrder = Nothing
        item = ctx.CustomerOrder.Find(oId)
        If item Is Nothing Then
            errorMessage.Text = "Order not found"
            Return
        End If

        item.UpdateDateTime = DateTime.Now

        If TryUpdateModel(item) Then
            If ModelState.IsValid Then
                Try
                    ctx.Entry(item).OriginalValues("RowVersion") = CType(Session("originalRowVersion"), Byte())
                    If ctx.Entry(item).OriginalValues("Status") = item.Status Then
                        errorMessage.Text = "Same Status. Not updated"
                        Return
                    End If
                    ctx.SaveChanges()
                    errorMessage.Text = "Updated"

                    Dim mobileNo As String = ConvertCusContact(item.Email).Replace("-", "")
                    Dim msg As String = ""
                    If item.Status = 0 Then
                        msg = "RM0 from Shotori, Order No: " & item.oId & " had been cancelled. If you have any inquiries please contact +605-468 8888."
                    ElseIf item.Status = 1 Then
                        msg = "RM0 from Shotori, Order No: " & item.oId & " had been Delivered. If you have any inquiries please contact +605-468 8888."
                    ElseIf item.Status = 2 Then
                        msg = "RM0 from Shotori, Order No: " & item.oId & ", Product: " & ConvertProName(item.ProId) & " had been pick up and on the way to your location. If you have any inquiries please contact +605-468 8888."
                    Else
                        msg = "RM0 from Shotori, Order No: " & item.oId & ", Product: " & ConvertProName(item.ProId) & " status had changed, kindly look for update from the website. If you have any inquiries please contact +605-468 8888."
                    End If

                    TwilioMobile.sendSMS(mobileNo, msg)

                Catch ex As DbUpdateConcurrencyException
                    Dim entry = ex.Entries.Single()
                    Dim clientValues = CType(entry.Entity, CustomerOrder)
                    Dim databaseEntry = entry.GetDatabaseValues()

                    If databaseEntry Is Nothing Then
                        errorMessage.Text = "Unable to save changes. It may deleted by another user."
                    Else
                        Dim databaseValues = CType(databaseEntry.ToObject(), CustomerOrder)
                        errorMessage.Text = "The record you attempted to edit was modified by another user."
                        item.RowVersion = databaseValues.RowVersion
                        Session("originalRowVersion") = item.RowVersion
                    End If
                Catch __unusedRetryLimitExceededException2__ As RetryLimitExceededException
                    errorMessage.Text = "Unable to save changes. Try again later"
                End Try
            Else
                errorMessage.Text = "Input Invalid"
            End If
        Else
            errorMessage.Text = "Input Invalid"
        End If
    End Sub

    Public Function ConvertProName(ByVal id As Integer) As String
        Dim product = ctx.Product.Where(Function(g) g.ProId = id).SingleOrDefault
        If product IsNot Nothing Then
            Return product.Name
        Else
            Return "Product Removed"
        End If
    End Function

    Public Function ConvertCusName(ByVal email As String) As String
        Dim user = ctx.UserInfo.Where(Function(g) g.Email = email).SingleOrDefault
        If user IsNot Nothing Then
            Return user.Name
        Else
            Return "Unknown"
        End If
    End Function

    Public Function ConvertCusContact(ByVal email As String) As String
        Dim user = ctx.UserInfo.Where(Function(g) g.Email = email).SingleOrDefault
        If user IsNot Nothing Then
            Return "+6" & user.Phone
        Else
            Return "Unknown"
        End If
    End Function

    Protected ReadOnly Property StatusList() As ListItem()
        Get
            Dim item = New List(Of ListItem)
            item.Add(New ListItem("Cancelled", 0))
            item.Add(New ListItem("Delivered", 1))
            item.Add(New ListItem("On Delivery", 2))
            item.Add(New ListItem("Processing", 3))
            Return item.ToArray
        End Get
    End Property

    Protected Function ConvertStatusClass(ByVal code As Short) As String
        Dim status = New String() {"text-danger", "text-success", "p-2 bg-success text-white", "p-2 bg-primary text-white"}
        Return status(code)
    End Function

    Protected Function ShowStatus(ByVal status As Short) As String
        Dim templist = StatusList().ToList
        Dim name = templist.Find(Function(g) g.Value = status.ToString).Text
        Return name
    End Function

    Protected Function ConvertByte(ByVal rowVersion As Byte()) As String
        Return Convert.ToBase64String(rowVersion)
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