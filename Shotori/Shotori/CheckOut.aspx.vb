Imports System.Web.Script.Serialization

Public Class CheckOut
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Context.User.Identity.IsAuthenticated Then
            Response.Redirect("~/Login")
        Else
            Dim user = ctx.UserInfo.Where(Function(g) g.Email = Context.User.Identity.Name).SingleOrDefault
            If user IsNot Nothing AndAlso Not String.IsNullOrEmpty(user.Name) Then
                If Request.Cookies("ShotoriCartCookie") Is Nothing OrElse String.IsNullOrEmpty(Request.Cookies("ShotoriCartCookie").Value) Then
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "redirect", "alert('Please add item to cart first.'); window.location='" & Request.ApplicationPath + "Profile';", True)
                    Return
                Else
                    Dim temp = New JavaScriptSerializer().Deserialize(Of List(Of CartCookies))(Request.Cookies("ShotoriCartCookie").Value)
                    If temp.Count = 0 Then
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "redirect", "alert('Please add item to cart first.'); window.location='" & Request.ApplicationPath + "Profile';", True)
                        Return
                    End If
                End If
            ElseIf user IsNot Nothing AndAlso String.IsNullOrEmpty(user.Name) Then
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "redirect", "alert('Please complete your user profile first.'); window.location='" & Request.ApplicationPath + "Profile';", True)
                Return
            Else
                Response.Redirect("~/Login")
                Return
            End If
        End If

        If Not IsPostBack Then
            Dim user = ctx.UserInfo.Where(Function(g) g.Email = Context.User.Identity.Name).SingleOrDefault
            If user IsNot Nothing Then
                Dim state = ctx.CountryState.Where(Function(g) g.StateId = user.State).Single
                usrName.Value = "Name: " & user.Name
                usrEmail.Value = "Email: " & user.Email
                usrPhone.Value = "Mobile: " & user.Phone
                usrPostal.Value = "Postal Code: " & user.PostalCode
                usrState.Value = "State: " & state.Name
                usrAddress.Value = "Address: " & user.Address
                usrCountry.Value = "Country: " & user.Country
            Else
                Response.Redirect("~/Login")
            End If
        End If
    End Sub

    Public Function gvProduct_GetData() As IQueryable(Of CartProduct)
        If Request.Cookies("ShotoriCartCookie") Is Nothing OrElse String.IsNullOrEmpty(Request.Cookies("ShotoriCartCookie").Value) Then
            Return New CartProduct()
        Else
            Dim temp = New JavaScriptSerializer().Deserialize(Of List(Of CartCookies))(Request.Cookies("ShotoriCartCookie").Value)
            Dim productList = New List(Of CartProduct)
            Dim tempProduct = New ProductItem()
            Dim amount As Decimal = 0.00
            For Each item In temp
                tempProduct = ctx.Product.Where(Function(g) g.ProId = item.pid And g.Status = 1).SingleOrDefault
                If tempProduct IsNot Nothing Then
                    Dim productItem = New CartProduct()
                    productItem.ProId = tempProduct.ProId
                    productItem.ImageFile = tempProduct.ImageFile
                    productItem.Name = tempProduct.Name
                    If tempProduct.Promotion = 1 Then
                        productItem.Price = tempProduct.PromoPrice
                    Else
                        productItem.Price = tempProduct.Price
                    End If
                    productItem.Qty = item.qty
                    productItem.Total = productItem.Price * item.qty

                    productList.Add(productItem)
                    amount += productItem.Total
                End If
            Next

            subtotal.InnerText = amount
            totalAmount.InnerText = amount
            Return productList.AsQueryable()
        End If

    End Function


    Private Sub btnBuy_Click(sender As Object, e As EventArgs) Handles btnBuy.Click
        Try
            Dim user = ctx.UserInfo.Where(Function(g) g.Email = Context.User.Identity.Name).SingleOrDefault
            Dim state = ctx.CountryState.Where(Function(g) g.StateId = user.State).Single
            Dim temp = New JavaScriptSerializer().Deserialize(Of List(Of CartCookies))(Request.Cookies("ShotoriCartCookie").Value)
            Dim tempProduct = New ProductItem()
            Dim total As Decimal = 0.00
            For Each item In temp
                tempProduct = ctx.Product.Where(Function(g) g.ProId = item.pid And g.Status = 1).SingleOrDefault
                If tempProduct IsNot Nothing Then
                    Dim customerOrder = New CustomerOrder()

                    customerOrder.ProId = tempProduct.ProId
                    customerOrder.Email = user.Email
                    customerOrder.Qty = item.qty
                    If tempProduct.Promotion = 1 Then
                        customerOrder.Price = tempProduct.PromoPrice
                    Else
                        customerOrder.Price = tempProduct.Price
                    End If
                    customerOrder.BasePrice = tempProduct.BasePrice
                    customerOrder.State = state.Name
                    customerOrder.UpdateDateTime = DateTime.Now
                    customerOrder.CreateDateTime = DateTime.Now
                    customerOrder.Status = 3

                    total += customerOrder.Price * customerOrder.Qty

                    ctx.CustomerOrder.Add(customerOrder)
                Else
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "redirect", "alert('Product Unvaliable Anymore.'); window.location='" & Request.ApplicationPath + "Cart';", True)
                    Return
                End If
            Next
            ctx.SaveChanges()

            Dim mobileNo As String = "+6" & user.Phone.Replace("-", "")
            Dim msg As String = "RM0 You have order total RM " & total & " product from Shotori. Please wait our staff to proceed your order. Normally will take 1 business day. if you have any inquiries please contact +605-468 8888."

            TwilioMobile.sendSMS(mobileNo, msg)

            Response.Cookies("ShotoriCartCookie").Value = New JavaScriptSerializer().Serialize(New List(Of CartCookies))
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "redirect", "alert('Place order confirmed'); window.location='" & Request.ApplicationPath + "Cart';", True)
        Catch ex As Exception
            Response.Write("<script>alert('Unable place order due to error');</script>")
        End Try

    End Sub

    Protected Function ConvertPath(ByVal filename As String) As String
        If String.IsNullOrEmpty(filename) Then
            Return "images/Product/unknown.jpg"
        End If
        Return "images/Product/" & filename
    End Function
End Class