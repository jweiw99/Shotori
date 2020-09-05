Imports System.IO

Public Class _Default
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Function LvPromotion_GetData() As IQueryable(Of ProductItem)
        Dim products = ctx.Product.Where(Function(g) g.Status = 1 And g.Promotion = True).OrderBy(Function(g) g.Name).ToList()
        Return products.AsQueryable()
    End Function

    Public Function LvBanner_GetData() As List(Of ListItem)
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

        Return FileList
    End Function

End Class