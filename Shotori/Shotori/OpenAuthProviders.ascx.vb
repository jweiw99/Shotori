Imports System.Globalization
Imports Microsoft.AspNet.Identity
Imports Microsoft.Owin.Security

Partial Public Class OpenAuthProviders
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Property ReturnUrl() As String
        Get
            Return m_ReturnUrl
        End Get
        Set(value As String)
            m_ReturnUrl = value
        End Set
    End Property
    Private m_ReturnUrl As String

    Protected Sub loginWithGoogle_ServerClick(sender As Object, e As EventArgs)
        Dim provider = "Google"
        Dim redirectUrl As String = ResolveUrl([String].Format(CultureInfo.InvariantCulture, "~/RegisterExternalLogin?{0}={1}&returnUrl={2}", IdentityHelper.ProviderNameKey, provider, ReturnUrl))
        Dim properties As AuthenticationProperties = New AuthenticationProperties() With {.RedirectUri = redirectUrl}
        'Add xsrf verification when linking accounts
        If (Context.User.Identity.IsAuthenticated) Then
            properties.Dictionary.Item(IdentityHelper.XsrfKey) = Context.User.Identity.GetUserId()
        End If
        Context.GetOwinContext().Authentication.Challenge(properties, provider)
        Response.StatusCode = 401
        Response.[End]()
    End Sub
End Class