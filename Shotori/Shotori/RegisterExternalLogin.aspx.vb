﻿Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.Owin
Imports Microsoft.Owin.Security

Public Class RegisterExternalLogin
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Process the result from an auth provider in the request
        ProviderName = IdentityHelper.GetProviderNameFromRequest(Request)
        If [String].IsNullOrEmpty(ProviderName) Then
            RedirectOnFail()
            Return
        End If

        If Not IsPostBack Then
            Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
            Dim signInManager = Context.GetOwinContext().Get(Of ApplicationSignInManager)()
            Dim loginInfo = Context.GetOwinContext().Authentication.GetExternalLoginInfo()
            If loginInfo Is Nothing Then
                RedirectOnFail()
                Return
            End If
            Dim appuser = manager.Find(loginInfo.Login)
            If appuser IsNot Nothing Then
                signInManager.SignIn(appuser, isPersistent:=False, rememberBrowser:=False)
                IdentityHelper.RedirectToReturnUrl(Request.QueryString("ReturnUrl"), Response)
            ElseIf User.Identity.IsAuthenticated Then
                Dim verifiedloginInfo = Context.GetOwinContext().Authentication.GetExternalLoginInfo(IdentityHelper.XsrfKey, User.Identity.GetUserId())
                If verifiedloginInfo Is Nothing Then
                    RedirectOnFail()
                    Return
                End If

                Dim result = manager.AddLogin(User.Identity.GetUserId(), verifiedloginInfo.Login)
                If result.Succeeded Then
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString("ReturnUrl"), Response)
                Else
                    AddErrors(result)
                    Return
                End If
            Else
                Email.Value = loginInfo.Email
            End If
        End If
    End Sub

    Protected Property ProviderName() As String
        Get
            Return If(DirectCast(ViewState("ProviderName"), String), [String].Empty)
        End Get
        Private Set(value As String)
            ViewState("ProviderName") = value
        End Set
    End Property

    Protected Property ProviderAccountKey() As String
        Get
            Return If(DirectCast(ViewState("ProviderAccountKey"), String), [String].Empty)
        End Get
        Private Set(value As String)
            ViewState("ProviderAccountKey") = value
        End Set
    End Property

    Private Sub RedirectOnFail()
        Response.Redirect(If((User.Identity.IsAuthenticated), "~/Profile", "~/Login"))
    End Sub

    Protected Sub LogIn_Click(sender As Object, e As EventArgs)
        CreateAndLoginUser()
    End Sub

    Private Sub CreateAndLoginUser()
        If Not IsValid Then
            Return
        End If
        Dim manager = Context.GetOwinContext().GetUserManager(Of ApplicationUserManager)()
        Dim signInManager = Context.GetOwinContext().Get(Of ApplicationSignInManager)()
        Dim user = New ApplicationUser() With {.UserName = Email.Value, .Email = Email.Value}
        Dim result = manager.Create(user)
        If Not result.Succeeded Then
            AddErrors(result)
            Return
        End If

        manager.AddToRole(user.Id, "Customer")
        Dim tempUser As UserInfo = New UserInfo()
        tempUser.UserId = user.Id
        tempUser.Email = user.Email
        ctx.UserInfo.Add(tempUser)
        ctx.SaveChanges()

        Dim loginInfo = Context.GetOwinContext().Authentication.GetExternalLoginInfo()
        If loginInfo Is Nothing Then
            RedirectOnFail()
            Return
        End If
        result = manager.AddLogin(user.Id, loginInfo.Login)
        If Not result.Succeeded Then
            AddErrors(result)
            Return
        End If
        signInManager.SignIn(user, isPersistent:=False, rememberBrowser:=False)

        ' For more information on how to enable account confirmation and password reset please visit https://go.microsoft.com/fwlink/?LinkID=320771
        ' Dim code = manager.GenerateEmailConfirmationToken(user.Id)
        ' Send this link via email: IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id)

        IdentityHelper.RedirectToReturnUrl(Request.QueryString("ReturnUrl"), Response)
        Return
    End Sub

    Private Sub AddErrors(result As IdentityResult)
        For Each [error] As String In result.Errors
            FailureText.Text = [error]
            ErrorMessage.Visible = True
        Next
    End Sub

End Class