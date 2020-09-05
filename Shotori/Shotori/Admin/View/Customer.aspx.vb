Imports System.Data.Entity.Infrastructure
Imports System.Threading.Tasks
Imports System.Web.ModelBinding
Imports Microsoft.AspNet.Identity.Owin
Imports SendGrid
Imports SendGrid.Helpers.Mail

Public Class Customer
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Not String.IsNullOrEmpty(Request.QueryString("cusEmail")) Then
                txtSearch.Text = Request.QueryString("cusEmail")
            End If
        End If
    End Sub

    Public Function gvCust_GetData() As IQueryable(Of UserInfo)

        If Not String.IsNullOrEmpty(txtSearch.Text.Trim()) Then
            Dim customersData = ctx.UserInfo.Where(Function(g) g.Email.Contains(txtSearch.Text) OrElse g.Phone.Contains(txtSearch.Text) OrElse g.Name.Contains(txtSearch.Text)).ToList
            If customersData.Count > 0 Then
                Dim ListCustomer = New List(Of UserInfo)
                For Each item In customersData
                    Dim data = ctx.Users.Where(Function(g) g.Email = item.Email And g.Roles.Select(Function(u) u.RoleId).Contains("4f624960-b5a2-41b7-8a93-15c81546a5e4")).SingleOrDefault
                    If data IsNot Nothing Then
                        ListCustomer.Add(item)
                    End If
                Next
                Return ListCustomer.AsQueryable
            End If
        Else
            Dim data = ctx.Users.Where(Function(g) g.Roles.Select(Function(u) u.RoleId).Contains("4f624960-b5a2-41b7-8a93-15c81546a5e4")).ToList
            If data.Count > 0 Then
                Dim ListCustomer = New List(Of UserInfo)
                For Each item In data
                    Dim customersData = ctx.UserInfo.Where(Function(g) g.Email = item.Email).SingleOrDefault
                    If customersData IsNot Nothing Then
                        ListCustomer.Add(customersData)
                    End If
                Next
                Return ListCustomer.AsQueryable
            End If
        End If
        Return (New List(Of UserInfo)).AsQueryable

    End Function

    Public Sub SearchCustomer()
        gvCust.DataBind()
    End Sub

    Public Function ConvertState(ByVal stateid As String) As String
        Dim state = ctx.CountryState.Where(Function(g) g.StateId = stateid).SingleOrDefault
        If state IsNot Nothing Then
            Return state.Name
        End If
        Return "Unknown State"
    End Function

    Public Async Sub fvCust_UpdateItem(ByVal UserId As String)
        Try
            Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            Dim User = ctx.Users.Where(Function(g) g.Id = UserId).SingleOrDefault
            If User IsNot Nothing Then
                Dim min As Integer = 0
                Dim max As Integer = 9999

                Dim randomdata As Random = New Random()
                Dim randomInt As Integer = randomdata.Next(min, max)

                Dim randomPassword As String = String.Format("A{0:D4}", randomInt)
                User.PasswordHash = manager.PasswordHasher.HashPassword(randomPassword)
                ctx.SaveChanges()
                errorMessage.Text = "Reset completed"

                Dim to_addr = New List(Of EmailAddress)
                to_addr.Add(New EmailAddress(User.Email))
                Dim psSubject = "Shotori account password reset"
                Dim psContent = "Please use this new password for your account .<br/> Here is your new password: " & randomPassword
                Dim psContent_TextFormat = "Please use this new password for your account .Here is your new password: " & randomPassword

                Dim emailResult = Await EmailCustomer.SendEmailWithSendGrid(to_addr, psSubject, psContent, psContent_TextFormat)
            Else
                errorMessage.Text = "Cannot reset password"
            End If
        Catch ex As Exception
            errorMessage.Text = "Error"
        End Try
    End Sub

    Private Sub gvCust_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles gvCust.RowEditing
        errorMessage.Text = ""
        Session("rowEditIndex") = e.NewEditIndex
    End Sub

End Class