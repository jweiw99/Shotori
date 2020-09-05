<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPages/Default.Master" CodeBehind="Default.aspx.vb" Inherits="Shotori._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .header--3 .mainmenu__area {
            position: absolute;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Start Feature Product -->
    <section class="categories-slider-area pb--100 bg__white">
        <div class="container-fluid pl-0 pr-0">
            <div class="row">
                <!-- Start Slider Area -->
                <div class="slider__container slider--one">
                    <div class="slider__activation__wrap owl-carousel owl-theme">
                        <asp:ListView ID="LvBanner" runat="server" SelectMethod="LvBanner_GetData" DataKeyNames="Text">
                            <EmptyDataTemplate>
                                <div class="text-center">No data Found</div>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <!-- Start Single Slide -->
                                <div class="slide slider__full--screen slider-height-inherit slider-text-right" style="background: rgba(0, 0, 0, 0) url('<%#: Eval("Value") %>') no-repeat scroll center center / cover;">
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-md-10 col-lg-8 col-md-offset-2 col-lg-offset-4 col-sm-12 col-xs-12">
                                                <div class="slider__inner">
                                                    <!-- <h1>Shotori <span class="text--theme">Collection</span></h1>
                                                    <div class="slider__btn">
                                                        <a class="htc__btn" href="Shop.aspx">shop now</a> 
                                                </div>-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- End Single Slide -->
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
                <!-- Start Slider Area -->
            </div>
        </div>
    </section>
    <!-- End Feature Product -->

    <!-- Start Info -->
    <section class="htc__product__area pb--100 bg__white">
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-lg-4">
                    <div class="furgan-iconbox style-01">
                        <div class="iconbox-inner">
                            <div class="icon"><i class="fas fa-shipping-fast"></i></div>
                            <div class="content">
                                <h4 class="title">Fast Shipping.</h4>
                                <div class="desc">With sites in 5 languages, we ship to over 200 countries</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 col-lg-4">
                    <div class="furgan-iconbox style-01">
                        <div class="iconbox-inner">
                            <div class="icon"><i class="fas fa-user-lock"></i></div>
                            <div class="content">
                                <h4 class="title">Safe delivery</h4>
                                <div class="desc">Pay with the world’s most popular, secure payment methods.</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 col-lg-4">
                    <div class="furgan-iconbox style-01">
                        <div class="iconbox-inner">
                            <div class="icon"><i class="fas fa-sync"></i></div>
                            <div class="content">
                                <h4 class="title">365 Days Return</h4>
                                <div class="desc">Round-the-clock assistance for a shopping experience.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Info -->

    <section id="portfoio-area" class="portfolio-area pp-scrollable section-padding-top-xlg bg-white">
        <div class="container container-xlg">
            <div class="row">
                <div class="col-xl-12 col-lg-12 col-12">
                    <div class="section-title text-center">
                        <h1>Shotori's Promotion</h1>
                    </div>
                </div>
            </div>

            <div class="portfolio-wrap section-title text-left">
                <h6>Product</h6>
            </div>
            <div class="portfolio-wrap section-padding-bottom-xlg">
                <!-- Portfolios -->
                <div class="row no-gutters portfolios portfolios-style-1">
                    <asp:ListView ID="LvPromotion" runat="server" SelectMethod="LvPromotion_GetData" DataKeyNames="ProId" ItemType="Shotori.ProductItem">
                        <EmptyDataTemplate>
                            <div class="text-center">No data Found</div>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <!-- Single Portfolio -->
                            <div class="cr-col-2 col-lg-3 col-md-4 col-sm-6 col-12 portfolio-single mt--30">
                                <div class="portfolio">
                                    <div class="portfoilo-thumb">
                                        <img class="mx-auto d-block" src="images/Product/<%#: Item.ImageFile %>">
                                        <div class="text-center text-md-left furgan-iconbox style-01">
                                            <h4 class="title mt--10"><%#: Item.Name %></h4>
                                            <h6 class="desc text-truncate" style="display: block;"><%#: Item.Description %></h6>
                                            <div class="proPrice mt--20 text-right small"><del>RM <%#: Item.Price %></del></div>
                                            <div class="text-right text-danger">RM <%#: Item.PromoPrice %></div>
                                        </div>
                                    </div>
                                    <div class="portfolio-content">
                                        <div class="portfolio-content-inner text-center">
                                            <a href="ProductDetails?pid=<%#: Item.ProId %>" class="bg-white cr-btn cr-btn-xl cr-btn-rounded" style="padding-right: 5px"><i
                                                class="fa fa-angle-right text-theme"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>
    </section>
</asp:Content>
