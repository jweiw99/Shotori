Imports System.ComponentModel.DataAnnotations

Public Class CartProduct
    <Required>
    Public Property ProId As Int32
    Public Property ImageFile As String
    <Required>
    Public Property Name As String
    <Required>
    Public Property Price As Decimal
    <Required>
    Public Property Qty As Int16
    <Required>
    Public Property Total As Decimal
End Class
