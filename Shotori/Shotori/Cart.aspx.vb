Imports System.Web.Script.Serialization

Public Class Cart
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Function gvProduct_GetData() As IQueryable(Of CartProduct)
        If Request.Cookies("ShotoriCartCookie") Is Nothing OrElse String.IsNullOrEmpty(Request.Cookies("ShotoriCartCookie").Value) Then
            Dim productList = New List(Of CartProduct)
            Return productList.AsQueryable
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


    Public Sub fvProduct_DeleteItem(ByVal ProId As Integer)

        Try
            Dim temp = New JavaScriptSerializer().Deserialize(Of List(Of CartCookies))(Request.Cookies("ShotoriCartCookie").Value)
            Dim deleteItem = temp.Find(Function(g) g.pid = ProId)
            temp.Remove(deleteItem)
            Response.Cookies("ShotoriCartCookie").Value = New JavaScriptSerializer().Serialize(temp)
            Request.Cookies("ShotoriCartCookie").Value = Response.Cookies("ShotoriCartCookie").Value
            errorMessage.Text = "Removed"
            GvProducts.DataBind()
        Catch ex As Exception
            errorMessage.Text = "Unable to remove due to error"
        End Try

    End Sub

    Public Sub fvProduct_UpdateItem(ByVal ProId As Integer)
        Try
            Dim temp = New JavaScriptSerializer().Deserialize(Of List(Of CartCookies))(Request.Cookies("ShotoriCartCookie").Value)
            Dim editItem = temp.Find(Function(g) g.pid = ProId)
            If TryUpdateModel(editItem) Then
                Response.Cookies("ShotoriCartCookie").Value = New JavaScriptSerializer().Serialize(temp)
                Request.Cookies("ShotoriCartCookie").Value = Response.Cookies("ShotoriCartCookie").Value
                errorMessage.Text = "Updated"
                GvProducts.DataBind()
            Else
                errorMessage.Text = "Unable to update due to invalid input"
            End If
        Catch ex As Exception
            errorMessage.Text = "Unable to update due to error"
        End Try
    End Sub

    Protected Function ConvertPath(ByVal filename As String) As String
        If String.IsNullOrEmpty(filename) Then
            Return "images/Product/unknown.jpg"
        End If
        Return "images/Product/" & filename
    End Function

End Class