Imports System.Web.Script.Serialization

Public Class ProductDetails
    Inherits System.Web.UI.Page

    Dim ctx As New ApplicationDbContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            Dim pid = Request.QueryString("pid")
            If Not String.IsNullOrEmpty(pid) Then
                Dim result As ProductItem
                Dim IsAdmin = ctx.Users.Where(Function(g) g.Email = Context.User.Identity.Name And g.Roles.Select(Function(u) u.RoleId).Contains("872afd29-89a7-4e55-91e1-d4c087e5596e")).SingleOrDefault
                If IsAdmin IsNot Nothing Then
                    result = ctx.Product.Where(Function(g) g.ProId = pid).SingleOrDefault
                Else
                    result = ctx.Product.Where(Function(g) g.ProId = pid And g.Status = 1).SingleOrDefault
                End If
                If result IsNot Nothing Then
                    proImage.Src = "images/Product/" & result.ImageFile
                    proName.InnerText = result.Name
                    proDesc.InnerText = result.Description
                    If result.Promotion Then
                        proPrice.InnerHtml = "<li class='old__prize'>RM " & result.Price & "</li><li>RM " & result.PromoPrice & "</li>"
                    Else
                        proPrice.InnerHtml = "<li>RM " & result.Price & "</li>"
                    End If
                Else
                    Response.Redirect("404")
                End If
            Else
                Response.Redirect("404")
            End If
        End If
    End Sub

    Public Function LvReview_GetData() As IQueryable(Of Review)
        Dim pid = Request.QueryString("pid")
        Dim review = ctx.Review.Where(Function(g) g.ProId = pid).OrderByDescending(Function(g) g.CreateDateTime).Take(3).ToList()
        Return review.AsQueryable()
    End Function

    Private Sub SubmitReview_Click(sender As Object, e As EventArgs) Handles submitReview.Click
        If IsValid Then
            If Context.User.Identity.IsAuthenticated Then
                Dim user = ctx.UserInfo.Where(Function(g) g.Email = Context.User.Identity.Name).SingleOrDefault
                If user IsNot Nothing And Not String.IsNullOrEmpty(user.Name) Then
                    Try
                        Dim pid = Request.QueryString("pid")
                        Dim review = ctx.Review.Where(Function(g) g.Email = Context.User.Identity.Name And g.ProId = pid).SingleOrDefault
                        If review IsNot Nothing Then
                            review.Comment = usrReview.Value
                            review.CreateDateTime = DateTime.Now
                            ctx.SaveChanges()
                        Else
                            review = New Review()
                            review.ProId = pid
                            review.Email = Context.User.Identity.Name
                            review.Comment = usrReview.Value
                            review.CreateDateTime = DateTime.Now
                            ctx.Review.Add(review)
                            ctx.SaveChanges()
                        End If
                        Page.DataBind()
                        Response.Write("<script>alert('Submit Review Success');</script>")
                    Catch ex As Exception
                        Response.Write("<script>alert('Submit Review Failed');</script>")
                    End Try
                Else
                    Response.Write("<script>alert('Please fill up your personal information on user profile before submit review.');</script>")
                End If

            End If
        End If
    End Sub

    Protected Sub AddToCart(sender As Object, e As EventArgs)
        If IsValid Then
            Try
                Dim qty = CType(proQty.Value, Short)
                Dim pid = CInt(Request.QueryString("pid"))
                Dim cookiedata = New List(Of CartCookies)
                Dim jss As New JavaScriptSerializer()
                If Request.Cookies("ShotoriCartCookie") Is Nothing OrElse String.IsNullOrEmpty(Request.Cookies("ShotoriCartCookie").Value) Then
                    Dim cart = New CartCookies()
                    cart.pid = pid
                    cart.qty = qty
                    cookiedata.Add(cart)
                    Response.Cookies("ShotoriCartCookie").Value = jss.Serialize(cookiedata)
                Else
                    Dim temp = jss.Deserialize(Of List(Of CartCookies))(Request.Cookies("ShotoriCartCookie").Value)
                    Dim tempQty = temp.Find(Function(g) g.pid = pid)
                    If tempQty IsNot Nothing Then
                        tempQty.qty += qty
                    Else
                        Dim cart = New CartCookies()
                        cart.pid = pid
                        cart.qty = qty
                        cookiedata.Add(cart)
                    End If
                    cookiedata.AddRange(temp)
                    Response.Cookies("ShotoriCartCookie").Value = New JavaScriptSerializer().Serialize(cookiedata)
                End If
                Response.Cookies("ShotoriCartCookie").Expires = DateTime.Now.AddYears(30)
                Response.Write("<script>alert('Add to Cart Success.');</script>")
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End If
    End Sub

    Protected Function ConvertName(ByVal email As String) As String
        Dim user = ctx.UserInfo.Where(Function(g) g.Email = email).SingleOrDefault
        Dim name = ""
        If user IsNot Nothing Then
            name = user.Name
        End If
        Return name
    End Function

    Protected Function GetRandomIcon() As String
        Static Random_Number As New Random()
        Return Random_Number.Next(1, 5).ToString
    End Function

End Class