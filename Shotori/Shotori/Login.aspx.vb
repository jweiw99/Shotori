Imports Microsoft.AspNet.Identity.Owin

Public Class Login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Context.User.Identity.IsAuthenticated Then
            Response.Redirect("~/Profile")
        End If
    End Sub

    Protected Sub LogIn(sender As Object, e As EventArgs)
        If IsValid Then
            ' Validate the user password
            Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            Dim signinManager = Context.GetOwinContext().GetUserManager(Of ApplicationSignInManager)()

            ' This doen't count login failures towards account lockout
            ' To enable password failures to trigger lockout, change to shouldLockout := True
            Dim result = signinManager.PasswordSignIn(Email.Value, Password.Value, RememberMe.Checked, shouldLockout:=False)

            Select Case result
                Case SignInStatus.Success
                    IdentityHelper.RedirectToReturnUrl("Profile.aspx", Response)
                    Exit Select
                Case SignInStatus.LockedOut
                    FailureText.Text = "Account Locked"
                    ErrorMessage.Visible = True
                Case Else
                    FailureText.Text = "Invalid login attempt"
                    ErrorMessage.Visible = True
                    Exit Select
            End Select
        End If
    End Sub

End Class