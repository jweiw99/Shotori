Imports Microsoft.AspNet.Identity.Owin

Public Class ResetPassword
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Context.User.Identity.IsAuthenticated Then
            Response.Redirect("~/Login")
        End If
    End Sub

    Protected Sub Reset()
        Try
            Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            Dim User = ctx.Users.Where(Function(g) g.Email = Context.User.Identity.Name).SingleOrDefault
            If User IsNot Nothing Then
                User.PasswordHash = manager.PasswordHasher.HashPassword(NewPassword.Value)
                ctx.SaveChanges()
                ErrorMessage.Visible = False
                Response.Write("<script>alert('Password Updated');</script>")
            Else
                FailureText.Text = "Invalid Old Password"
                ErrorMessage.Visible = True
            End If
        Catch ex As Exception
            FailureText.Text = "Invalid Input"
            ErrorMessage.Visible = True
        End Try
    End Sub

End Class