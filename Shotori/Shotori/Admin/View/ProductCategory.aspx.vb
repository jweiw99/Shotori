Imports System.Data.Entity.Infrastructure

Public Class ProductCategory
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Function gvCategories_GetData() As IQueryable(Of ProductCategories)
        Dim categories = ctx.ProductCategories
        Return categories
    End Function

    Public Sub fvCategory_DeleteItem(ByVal CatId As Integer)

        Try
            Dim category = ctx.ProductCategories.Where(Function(r) r.CatId = CInt(CatId)).SingleOrDefault()
            Dim Product = ctx.Product.Where(Function(r) r.CatId = CInt(CatId)).ToList()

            If Product.Count > 0 Then
                Product.ForEach(Function(a) ctx.Product.Remove(a))
            End If

            ctx.ProductCategories.Remove(category)
            ctx.SaveChanges()
            GvCategories.DataBind()
            errorMessage.Text = "Deleted"
        Catch ex As Exception
            errorMessage.Text = "Unable to delete changes. It may deleted by another user."
        End Try

    End Sub

    Private Sub GvCategories_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles GvCategories.RowEditing
        errorMessage.Text = ""
        Session("adminCategoryEditName") = CType(GvCategories.Rows(e.NewEditIndex).FindControl("lblName"), Label).Text
    End Sub

    Private Sub GvCategories_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs) Handles GvCategories.RowCancelingEdit
        GvCategories.DataBind()
    End Sub

    Public Sub fvCategory_UpdateItem(ByVal CatId As Integer)
        Dim item As Shotori.ProductCategories = Nothing
        item = ctx.ProductCategories.Find(CatId)
        If item Is Nothing Then
            errorMessage.Text = "Item not found"
            Return
        End If

        If TryUpdateModel(item) Then
            If ModelState.IsValid Then
                Try
                    ctx.Entry(item).OriginalValues("Name") = CStr(Session("adminCategoryEditName"))
                    ctx.SaveChanges()
                    errorMessage.Text = "Updated"
                Catch ex As DbUpdateConcurrencyException
                    Dim entry = ex.Entries.Single()
                    Dim clientValues = CType(entry.Entity, ProductCategories)
                    Dim databaseEntry = entry.GetDatabaseValues()

                    If databaseEntry Is Nothing Then
                        errorMessage.Text = "Unable to save changes. It may deleted by another user."
                    Else
                        Dim databaseValues = CType(databaseEntry.ToObject(), ProductCategories)
                        errorMessage.Text = "The record you attempted to edit was modified by another user."
                        Session("adminCategoryEditName") = item.Name
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
            Dim category As New ProductCategories()
            category.Name = catName.Text

            ctx.ProductCategories.Add(category)
            ctx.SaveChanges()

            errorMessage.Text = "Inserted"
            GvCategories.DataBind()

        Catch ex As Exception
            errorMessage.Text = "Insert Failed"
        End Try

    End Sub
End Class