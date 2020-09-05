Imports System.ComponentModel.DataAnnotations

Public Class CartOrder
    <Required>
    Public Property oId As Int32
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
    <Required>
    Public Property Status As Int16
    <Required>
    Public Property UpdateDate As DateTime
    <Required>
    Public Property OrderDate As DateTime
End Class
