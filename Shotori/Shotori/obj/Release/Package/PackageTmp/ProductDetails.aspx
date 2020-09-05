<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPages/Default.Master" CodeBehind="ProductDetails.aspx.vb" Inherits="Shotori.ProductDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Start Bradcaump area -->
    <div class="ht__bradcaump__area" style="background: rgba(0, 0, 0, 0) url(images/bg/contact.jpg) no-repeat scroll center center / cover;">
        <div class="ht__bradcaump__wrap">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="bradcaump__inner text-center">
                            <h2 class="bradcaump-title">Product Details</h2>
                            <nav class="bradcaump-inner">
                                <a class="breadcrumb-item" href="Default">Home</a>
                                <span class="brd-separetor">/</span>
                                <a class="breadcrumb-item" href="Shop">Shop</a>
                                <span class="brd-separetor">/</span>
                                <span class="breadcrumb-item active">Product Details</span>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Bradcaump area -->

    <form runat="server">
        <!-- Start Product Details -->
        <section class="htc__product__details pt--120 pb--100 bg__white">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                        <div class="portfolio-full-image tab-content">
                            <div role="tabpanel" class="tab-pane fade in active product-video-position" id="img-tab-1">
                                <img src="images/Product/unknown.jpg" runat="server" id="proImage">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12 smt-30 xmt-30">
                        <div class="htc__product__details__inner pt--30">
                            <div class="pro__detl__title">
                                <h2 runat="server" id="proName"></h2>
                            </div>
                            <div class="pro__details">
                                <p runat="server" id="proDesc"></p>
                            </div>
                            <ul class="pro__dtl__prize" runat="server" id="proPrice">
                            </ul>
                            <div class="product-action-wrap">
                                <div class="prodict-statas"><span>Quantity :</span></div>
                                <div class="product-quantity">
                                    <div class="product-quantity">
                                        <div class="cart-plus-minus">
                                            <input class="cart-plus-minus-box" runat="server" id="proQty" type="text" name="proQty" value="1" pattern="\d*">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <ul class="pro__dtl__btn">
                                <li class="buy__now__btn">
                                    <asp:Button runat="server" OnClick="AddToCart" Text="Add to Cart" CssClass="btn btn-default" /></li>

                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- End Product Details -->
        <!-- Start Product tab -->
        <section class="htc__product__details__tab bg__white pb--120">
            <div class="container">
                <!-- Start Single Content -->
                <div id="reviews" class="product__tab__content fade in active">
                    <div class="review__address__inner">
                        <asp:ListView ID="LvReview" runat="server" SelectMethod="LvReview_GetData" DataKeyNames="rId" ItemType="Shotori.Review">
                            <EmptyDataTemplate>
                                <div class="text-center">No review of this product </div>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <!-- Start Single Review -->
                                <div class="pro__review mt--40">
                                    <div class="review__thumb">
                                        <img class="img-rounded img-cover" width="100" height="100" src="images/profilePic/<%: GetRandomIcon() %>.jpg">
                                    </div>
                                    <div class="review__details">
                                        <div class="review__info">
                                            <h4><%# ConvertName(Item.Email) %></h4>
                                        </div>
                                        <div class="review__date">
                                            <span><%#: Item.CreateDateTime %></span>
                                        </div>
                                        <p style="width: 100%"><%#: Item.Comment %></p>
                                    </div>
                                </div>
                                <!-- End Single Review -->
                            </ItemTemplate>
                        </asp:ListView>
                    </div>

                    <% If Context.User.Identity.IsAuthenticated Then %>
                    <!-- Start RAting Area -->
                    <div class="rating__wrap mt--70">
                        <h2 class="rating-title">Write  A review</h2>

                    </div>
                    <!-- End RAting Area -->
                    <div class="review__box">
                        <div class="single-review-form">
                            <div class="review-box message">
                                <textarea runat="server" id="usrReview" pattern="[a-zA-Z0-9\s!,\.]+" placeholder="Write your review"></textarea>
                            </div>
                        </div>
                        <div class="review-btn">
                            <asp:Button runat="server" OnClientClick="checkComment" ID="submitReview" Text="Submit Review" CssClass="btn btn-default" />
                        </div>
                    </div>
                    <% End If %>
                </div>
                <!-- End Single Content -->
            </div>
        </section>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Script" runat="server">
    <script>
        $(document).ready(function () {
            $('#<%= submitReview.ClientID %>').click(function () {
                if ($('#<%= usrReview.ClientID %>').val() == "") {
                    document.getElementById("<%= usrReview.ClientID %>").setCustomValidity('Cannot be empty');
                } else {
                    var errorMsg = "Please do not enter special character.";
                    var pattern = new RegExp('^' + $('#<%= usrReview.ClientID %>').attr('pattern') + '$');
                    $.each($('#<%= usrReview.ClientID %>').val().split("\n"), function () {
                        // check if the line matches the pattern
                        var hasError = !this.match(pattern);
                        if (typeof document.getElementById("<%= usrReview.ClientID %>").setCustomValidity === 'function') {
                            document.getElementById("<%= usrReview.ClientID %>").setCustomValidity(hasError ? errorMsg : '');
                        }
                    });
                }
            });
            $(".btn").not("#<%= submitReview.ClientID %>").click(function () {
                document.getElementById("<%= usrReview.ClientID %>").setCustomValidity('');
            });
        });
    </script>
</asp:Content>
