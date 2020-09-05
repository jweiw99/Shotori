Public Class Profile
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Context.User.Identity.IsAuthenticated Then
            Response.Redirect("~/Login")
        End If

        If Not IsPostBack Then
            Dim state = ctx.CountryState.OrderBy(Function(g) g.Name)

            ddlstate.DataSource = state.ToArray
            ddlstate.DataTextField = "Name"
            ddlstate.DataValueField = "StateId"
            ddlstate.DataBind()

            Dim user = ctx.UserInfo.Where(Function(g) g.Email = Context.User.Identity.Name).SingleOrDefault
            If user IsNot Nothing Then
                usrName.Value = user.Name
                usrEmail.Value = user.Email
                usrPhone.Value = user.Phone
                usrPostal.Value = user.PostalCode
                ddlstate.SelectedValue = user.State
                usrAddress.Value = user.Address
                usrCountry.Value = user.Country
            Else
                Response.Redirect("~/Login")
            End If
        End If

    End Sub

    Private Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
        Try
            Dim user = ctx.UserInfo.Where(Function(g) g.Email = Context.User.Identity.Name).SingleOrDefault

            If user IsNot Nothing Then
                user.Name = usrName.Value
                user.Phone = usrPhone.Value
                user.PostalCode = usrPostal.Value
                user.State = ddlstate.SelectedValue
                user.Address = usrAddress.Value
                user.Country = usrCountry.Value
                ctx.SaveChanges()
                errorMessage.Text = "Save"
            Else
                errorMessage.Text = "Update Failed"
            End If


        Catch ex As Exception
            errorMessage.Text = "Update Failed"
        End Try

    End Sub

End Class