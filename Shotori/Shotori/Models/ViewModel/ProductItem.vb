Imports System.ComponentModel.DataAnnotations
Public Class ProductItem
    <Key>
    Public Property ProId As Int32
    <Required>
    Public Property CatId As Int32
    <Required>
    Public Property Name As String
    Public Property Description As String
    <Required>
    Public Property BasePrice As Decimal
    <Required>
    Public Property Price As Decimal
    <Required>
    Public Property PromoPrice As Decimal
    <Required>
    Public Property Promotion As Boolean
    Public Property ImageFile As String
    <Required>
    Public Property Status As Integer
    <Timestamp>
    Public Property RowVersion As Byte()
End Class
