Imports System.Data.Entity.Infrastructure
Imports System.IO
Imports System.Web.ModelBinding

Public Class Product
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim category = CategoryList()
        ddlCategoryList.DataSource = category
        ddlCategoryList.DataTextField = "Text"
        ddlCategoryList.DataValueField = "Value"

        ddlProCat.DataSource = category
        ddlProCat.DataTextField = "Text"
        ddlProCat.DataValueField = "Value"

        If Not Page.IsPostBack Then
            If category.Length > 0 Then
                ddlCategoryList.DataBind()
                ddlProCat.DataBind()
            End If
        End If
    End Sub

    Public Function gvProduct_GetData(<Control("ddlCategoryList", "SelectedValue")> ByVal CatId As Integer) As IQueryable(Of ProductItem)
        Dim products = ctx.Product.Where(Function(g) g.CatId = CatId).ToList()
        Return products.AsQueryable()
    End Function

    Public Sub fvProduct_DeleteItem(ByVal ProId As Integer)

        Try
            Dim product = ctx.Product.Where(Function(r) r.ProId = CInt(ProId)).SingleOrDefault()

            If product.ImageFile IsNot "" Then
                File.Delete(Server.MapPath("~/images/Product/" & product.ImageFile))
            End If

            ctx.Product.Remove(product)
            ctx.SaveChanges()
            GvProducts.DataBind()
            errorMessage.Text = "Deleted"
        Catch ex As Exception
            errorMessage.Text = "Unable to delete changes. It may deleted by another user."
        End Try

    End Sub

    Private Sub GvProducts_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles GvProducts.RowEditing
        errorMessage.Text = ""
        Session("imageFileName") = ctx.Product.Find(GvProducts.DataKeys(e.NewEditIndex).Value).ImageFile
        Dim rawByte = Convert.FromBase64String(CType(GvProducts.Rows(e.NewEditIndex).FindControl("RowVersion"), Label).Text)
        Session("originalRowVersion") = rawByte
    End Sub

    Private Sub GvProducts_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs) Handles GvProducts.RowCancelingEdit
        GvProducts.DataBind()
    End Sub

    Private Sub GvProducts_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles GvProducts.RowUpdating
        Dim item As Shotori.ProductItem = Nothing
        item = ctx.Product.Find(GvProducts.DataKeys(e.RowIndex).Value)
        If item Is Nothing Then
            errorMessage.Text = "Item not found"
            Return
        End If

        Try
            Dim filepath As String = ""
            Dim filename As String = ""
            Dim fileImage As FileUpload = CType(GvProducts.Rows(e.RowIndex).FindControl("FuImage"), FileUpload)
            Dim selectedValue As String = CType(GvProducts.Rows(e.RowIndex).FindControl("ddlCategory"), DropDownList).SelectedItem.Text

            If Not String.IsNullOrEmpty(fileImage.FileName) Then
                filepath = selectedValue & "/"
                filename = Guid.NewGuid().ToString("N") & Path.GetExtension(fileImage.FileName)
                Directory.CreateDirectory(Server.MapPath("~/images/Product/" & filepath))
                fileImage.SaveAs(Server.MapPath(Path.Combine("~/images/Product/" & filepath, filename)))

                If Not String.IsNullOrEmpty(Session("imageFileName")) Then
                    File.Delete(Server.MapPath("~/images/Product/" & Session("imageFileName")))
                End If

                Session("imageFileName") = filepath & filename
            End If

        Catch ex As Exception
            errorMessage.Text = "File Upload Error"
        End Try


    End Sub

    Public Sub fvProduct_UpdateItem(ByVal ProId As Integer)
        Dim item As Shotori.ProductItem = Nothing
        item = ctx.Product.Find(ProId)
        If item Is Nothing Then
            errorMessage.Text = "Item not found"
            Return
        End If

        item.ImageFile = Session("imageFileName")

        If TryUpdateModel(item) Then
            If ModelState.IsValid Then
                Try
                    ctx.Entry(item).OriginalValues("RowVersion") = CType(Session("originalRowVersion"), Byte())
                    ctx.SaveChanges()
                    errorMessage.Text = "Updated"
                Catch ex As DbUpdateConcurrencyException
                    Dim entry = ex.Entries.Single()
                    Dim clientValues = CType(entry.Entity, ProductItem)
                    Dim databaseEntry = entry.GetDatabaseValues()

                    If databaseEntry Is Nothing Then
                        errorMessage.Text = "Unable to save changes. It may deleted by another user."
                    Else
                        Dim databaseValues = CType(databaseEntry.ToObject(), ProductItem)
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

    Private Sub btnAdd_Click(sender As Object, e As EventArgs) Handles btnAdd.Click
        Try
            Dim product As New ProductItem()
            Dim filepath As String = ""
            Dim filename As String = ""

            product.CatId = CInt(ddlProCat.SelectedValue)
            product.Name = proName.Value
            product.Description = proDesc.Value
            product.BasePrice = proBasePrice.Value
            product.Price = proPrice.Value
            product.PromoPrice = proPromoPrice.Value
            product.Promotion = proPromotion.Checked

            If Not String.IsNullOrEmpty(proImage.PostedFile.FileName) Then
                filepath = ShowCategory(product.CatId) & "/"
                filename = Guid.NewGuid().ToString("N") & Path.GetExtension(proImage.PostedFile.FileName)
                Directory.CreateDirectory(Server.MapPath("~/images/Product/" & filepath))
                proImage.PostedFile.SaveAs(Server.MapPath(Path.Combine("~/images/Product/" & filepath, filename)))
            End If

            product.ImageFile = filepath & filename
            product.Status = proStatus.Value

            ctx.Product.Add(product)
            ctx.SaveChanges()

            errorMessage.Text = "Inserted"
            GvProducts.DataBind()

        Catch ex As Exception
            errorMessage.Text = "Insert Failed"
        End Try

    End Sub

    Protected Function ShowPromotion(ByVal promotion As Object) As String
        Dim isPromotion = CType(promotion, Boolean)
        Dim PromotionString As String

        If isPromotion Then
            PromotionString = "Yes"
        Else
            PromotionString = "No"
        End If

        Return PromotionString
    End Function


    Protected Function ShowCategory(ByVal CatId As Integer) As String
        Dim item As Shotori.ProductCategories = Nothing
        item = ctx.ProductCategories.Find(CatId)
        If item Is Nothing Then
            Return "N/A"
        End If

        Return item.Name
    End Function

    Protected ReadOnly Property CategoryList() As ListItem()
        Get
            Dim item = New List(Of ListItem)
            Dim categories = ctx.ProductCategories.OrderBy(Function(g) g.Name).ToList()
            categories.ForEach(Sub(a) item.Add(New ListItem(a.Name, a.CatId)))

            Return item.ToArray
        End Get
    End Property

    Protected ReadOnly Property StatusList() As ListItem()
        Get

            Dim item1 = New ListItem("On", 1)
            Dim item2 = New ListItem("Off", 0)
            Return New ListItem() {item1, item2}
        End Get
    End Property

    Protected Function ShowStatus(ByVal status As Object) As String
        Dim proStatus = CInt(status)
        Dim StatusString As String

        If proStatus = 1 Then
            StatusString = "On"
        Else
            StatusString = "Off"
        End If

        Return StatusString
    End Function

    Protected Function ConvertPath(ByVal filename As String) As String
        If String.IsNullOrEmpty(filename) Then
            Return "../../images/Product/unknown.jpg"
        End If
        Return "../../images/Product/" & filename
    End Function

    Protected Function ConvertByte(ByVal rowVersion As Byte()) As String
        Return Convert.ToBase64String(rowVersion)
    End Function

End Class