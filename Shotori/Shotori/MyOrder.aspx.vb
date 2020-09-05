Imports System.Web.Script.Serialization

Public Class MyOrder
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Function gvProduct_GetData() As IQueryable(Of CartOrder)

        Dim temp = ctx.CustomerOrder.Where(Function(g) g.Email = Context.User.Identity.Name).OrderByDescending(Function(g) g.Status).ThenByDescending(Function(g) g.UpdateDateTime).ToList()
        Dim orderList = New List(Of CartOrder)
        For Each item In temp
            Dim productInfo = ctx.Product.Where(Function(g) g.ProId = item.ProId).SingleOrDefault
            Dim productItem = New CartOrder()
            productItem.oId = item.oId
            productItem.ProId = item.ProId
            If productInfo IsNot Nothing Then
                productItem.ImageFile = productInfo.ImageFile
                productItem.Name = productInfo.Name
            Else
                productItem.ImageFile = ""
                productItem.Name = "Product Removed"
            End If
            productItem.Price = item.Price
            productItem.Qty = item.Qty
            productItem.Total = productItem.Price * item.Qty
            productItem.Status = item.Status
            productItem.UpdateDate = item.UpdateDateTime
            productItem.OrderDate = item.CreateDateTime

            orderList.Add(productItem)
        Next

        Return orderList.AsQueryable()

    End Function

    Protected Function ConvertStatus(ByVal code As Short) As String
        Dim status = New String() {"Cancelled", "Delivered", "On Delivery", "Processing"}
        Return status(code)
    End Function

    Protected Function ConvertStatusClass(ByVal code As Short) As String
        Dim status = New String() {"text-danger", "text-success", "pall-5 bg-success text-white", "pall-5 bg-primary text-white"}
        Return status(code)
    End Function

    Protected Function ConvertPath(ByVal filename As String) As String
        If String.IsNullOrEmpty(filename) Then
            Return "images/Product/unknown.jpg"
        End If
        Return "images/Product/" & filename
    End Function

End Class