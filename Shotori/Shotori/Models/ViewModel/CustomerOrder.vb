Imports System.ComponentModel.DataAnnotations

Public Class CustomerOrder
    <Key>
    Public Property oId As Int32
    <Required>
    Public Property ProId As Int32
    <Required>
    Public Property Email As String
    <Required>
    Public Property Qty As Int16
    <Required>
    Public Property BasePrice As Decimal
    <Required>
    Public Property Price As Decimal
    <Required>
    Public Property State As String
    <Required>
    Public Property Status As Int16
    <Required>
    Public Property UpdateDateTime As DateTime
    <Required>
    Public Property CreateDateTime As DateTime
    <Timestamp>
    Public Property RowVersion As Byte()
End Class
