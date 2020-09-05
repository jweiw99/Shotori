Public Class Shop
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Function LvCategory_GetData() As IQueryable(Of ProductCategories)
        Dim category = ctx.ProductCategories.OrderBy(Function(g) g.Name).ToList()
        Return category.AsQueryable()
    End Function

    Private Sub LvCategory_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles LvCategory.ItemDataBound
        If e.Item.ItemType = ListViewItemType.DataItem Then
            'get CategoryID
            Dim CategoryID As String = CType(e.Item.FindControl("lblCategoryID"), Label).Text.ToString()

            'find child listview "ProductsListView"
            Dim ProductsListView As ListView = CType(e.Item.FindControl("LvProduct"), ListView)

            'retrieve records based on CategoryID and populate child listview "ProductsListView"
            Dim products = ctx.Product.Where(Function(g) g.Status = 1 And g.CatId = CategoryID).OrderBy(Function(g) g.Name).ToList()

            ProductsListView.DataSource = products
            ProductsListView.DataBind()

        End If
    End Sub

End Class