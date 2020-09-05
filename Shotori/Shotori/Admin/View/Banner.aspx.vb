Imports System.IO

Public Class Banner
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Function GvBanner_GetData() As IQueryable(Of ListItem)
        Dim filePaths() As String = Directory.GetFiles(Server.MapPath("~/images/slider/"))

        'Sort the directory
        Dim FilesStr() As String
        FilesStr = filePaths
        Array.Sort(FilesStr)

        Dim FileList As List(Of ListItem) = New List(Of ListItem)

        'list the names of all files in the specified directory
        For Each tempfilepath In filePaths
            Dim filepath As String = "../../images/slider/" & Path.GetFileName(tempfilepath)
            FileList.Add(New ListItem(Path.GetFileName(tempfilepath), filepath))
        Next

        Session("TotalFile") = FileList.Count.ToString
        Return FileList.AsQueryable
    End Function

    Public Sub GvBanner_DeleteItem(ByVal Text As String)

        Try
            File.Delete(Server.MapPath("~/images/slider/" & Text))
            GvBanner.DataBind()
            errorMessage.Text = "Deleted"
        Catch ex As Exception
            errorMessage.Text = "Unable to delete changes. It may deleted by another user."
        End Try

    End Sub
    Private Sub GvBanner_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles GvBanner.RowUpdating
        Session("DeleteFile") = False
        Try
            Dim fileImage As FileUpload = CType(GvBanner.Rows(e.RowIndex).FindControl("FuImage"), FileUpload)
            Dim filename As String = (e.RowIndex + 1).ToString & Path.GetExtension(fileImage.FileName)
            Dim filepath As String = Server.MapPath(Path.Combine("~/images/slider/", filename))
            If File.Exists(filepath) Then
                File.Delete(filepath)
            Else
                Session("DeleteFile") = True
            End If

            fileImage.SaveAs(filepath)
            GvBanner.DataBind()
            errorMessage.Text = "Updated"

        Catch ex As Exception
            errorMessage.Text = "Unable to edit changes. It may deleted by another user."
        End Try
    End Sub

    Public Sub GvBanner_UpdateItem(ByVal Text As String)
        Dim action As Boolean = CBool(Session("DeleteFile"))
        If action Then
            File.Delete(Server.MapPath("~/images/slider/" & Text))
        End If
    End Sub

    Private Sub btnAdd_Click(sender As Object, e As EventArgs) Handles btnAdd.Click
        Dim filename As String = CStr(CInt(Session("TotalFile")) + 1)

        Try
            If Not String.IsNullOrEmpty(banImage.PostedFile.FileName) Then
                Directory.CreateDirectory(Server.MapPath("~/images/slider/"))
                banImage.PostedFile.SaveAs(Server.MapPath(Path.Combine("~/images/slider/", filename & Path.GetExtension(banImage.PostedFile.FileName))))
                GvBanner.DataBind()
                errorMessage.Text = "Inserted"
            Else
                errorMessage.Text = "Invalid File"
            End If

        Catch ex As Exception
            errorMessage.Text = "Upload Failed"
        End Try

    End Sub

    Private Sub GvBanner_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles GvBanner.RowEditing
        errorMessage.Text = ""
    End Sub
End Class