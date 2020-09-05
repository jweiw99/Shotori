Imports System.ComponentModel.DataAnnotations

Public Class Review
    <Key>
    Public Property rId As Int32
    <Required>
    Public Property ProId As Int32
    <Required>
    Public Property Email As String
    <Required>
    Public Property Comment As String
    <Required>
    Public Property CreateDateTime As DateTime
End Class
