Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.Owin

Public Class Register
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Context.User.Identity.IsAuthenticated Then
            Response.Redirect("~/Profile")
        End If
    End Sub

    Protected Sub CreateUser_Click(sender As Object, e As EventArgs)
        Dim userName As String = regEmail.Value
        Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
        Dim signInManager = Context.GetOwinContext().Get(Of ApplicationSignInManager)()
        Dim user = New ApplicationUser() With {.UserName = userName, .Email = userName}
        Dim result = manager.Create(user, regPassword.Value)
        If result.Succeeded Then
            ' For more information on how to enable account confirmation and password reset please visit https://go.microsoft.com/fwlink/?LinkID=320771
            ' Dim code = manager.GenerateEmailConfirmationToken(user.Id)
            ' Dim callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id, Request)
            ' manager.SendEmail(user.Id, "Confirm your account", "Please confirm your account by clicking <a href=""" & callbackUrl & """>here</a>.")

            manager.AddToRole(user.Id, "Customer")
            Dim tempUser As UserInfo = New UserInfo()
            tempUser.UserId = user.Id
            tempUser.Email = user.Email
            ctx.UserInfo.Add(tempUser)
            ctx.SaveChanges()

            signInManager.SignIn(user, isPersistent:=False, rememberBrowser:=False)
            IdentityHelper.RedirectToReturnUrl("Profile.aspx", Response)
        Else
            FailureText.Text = result.Errors.FirstOrDefault()
            ErrorMessage.Visible = True
        End If
    End Sub
End Class