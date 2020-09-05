Imports System.Threading.Tasks
Imports SendGrid
Imports SendGrid.Helpers.Mail

Public Class EmailCustomer
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Async Sub btnEmail_ClickAsync()
        If IsValid Then
            Try
                Dim to_addr = New List(Of EmailAddress)

                Dim tempCustomerRegister = ctx.Users.Where(Function(g) g.Roles.Select(Function(u) u.RoleId).Contains("4f624960-b5a2-41b7-8a93-15c81546a5e4")).ToList
                For Each item In tempCustomerRegister
                    to_addr.Add(New EmailAddress(item.Email))
                Next

                Dim psSubject = tbEmailSub.Value
                Dim psContent = HttpUtility.UrlDecode(tbContent.Value)
                Dim psContent_TextFormat = Regex.Replace(tbContent.Value, "<.*?>", String.Empty)

                errorMessage.Text = "Sent to All Customer"
                tbEmailSub.Value = ""
                tbContent.Value = ""
                Dim Result = Await SendEmailWithSendGrid(to_addr, psSubject, psContent, psContent_TextFormat)

            Catch ex As Exception
                errorMessage.Text = "Invalid Input"
            End Try
        End If
    End Sub


    Shared Async Function SendEmailWithSendGrid(toAddr As List(Of EmailAddress), psSubject As String, psContent As String, psContent_TextFormat As String) As Task(Of String)
        Try
            Dim apiKey = ""
            Dim client = New SendGridClient(apiKey)
            Dim from = New EmailAddress("jweiw99@1utar.my")
            Dim subject = psSubject
            Dim psTo = toAddr
            Dim plainTextContent = psContent_TextFormat
            Dim htmlContent = psContent
            Dim msg = MailHelper.CreateSingleEmailToMultipleRecipients(from, psTo, subject, plainTextContent, htmlContent)

            Dim response = Await client.SendEmailAsync(msg)
        Catch ex As Exception

        End Try
        Return "done"
    End Function

End Class