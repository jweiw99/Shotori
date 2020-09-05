
Imports Twilio
Imports Twilio.Rest.Api.V2010.Account
Imports Twilio.Types

Public Class TwilioMobile

    Shared Sub sendSMS(ByVal mobile As String, ByVal msg As String)

        Const accountSid = "AC83fde6668a894a53016975551dbb37ce"
        Const authToken = ""

        TwilioClient.Init(accountSid, authToken)

        Dim toNumber = New PhoneNumber(mobile)
        Dim message = MessageResource.Create(
        toNumber, from:=New PhoneNumber("+18336611088"),
        body:=msg)

    End Sub
End Class
