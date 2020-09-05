Imports System.ComponentModel.DataAnnotations
Public Class UserInfo
    <Key>
    Public Property UId As Int32
    <Required>
    Public Property UserId As String
    <Required>
    Public Property Email As String
    Public Property Name As String
    Public Property Phone As String
    Public Property Address As String
    Public Property State As String
    Public Property Country As String
    Public Property PostalCode As Int32

End Class
