<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPages/Default.Master" CodeBehind="Shop.aspx.vb" Inherits="Shotori.Shop" %>

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
                            <h2 class="bradcaump-title">Products</h2>
                            <nav class="bradcaump-inner">
                                <a class="breadcrumb-item" href="Default">Home</a>
                                <span class="brd-separetor">/</span>
                                <span class="breadcrumb-item active">Products</span>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Bradcaump area -->

    <section id="portfoio-area" class="portfolio-area pp-scrollable section-padding-top-xlg bg-white mt--10">
        <div class="container container-xlg">
            <div class="row">
                <div class="col-xl-12 col-lg-12 col-12">
                    <div class="section-title text-center">
                        <h1>Shotori's Products</h1>
                    </div>
                </div>
            </div>

            <asp:ListView ID="LvCategory" runat="server" SelectMethod="LvCategory_GetData" DataKeyNames="CatId" ItemType="Shotori.ProductCategories">
                <EmptyDataTemplate>
                    <div class="text-center">No data Found</div>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <div class="portfolio-wrap section-title text-left review__info">
                        <h6>Product</h6>
                        <asp:Label ID="lblCategoryID" runat="server" Text='<%#: Item.CatId %>' hidden="true" />
                        <h4 class="mt--10 text-bold"><%#: Item.Name %></h4>
                    </div>
                    <div class="portfolio-wrap section-padding-bottom-xlg">
                        <div class="row no-gutters portfolios portfolios-style-1">
                            <asp:ListView ID="LvProduct" runat="server" DataKeyNames="ProId" ItemType="Shotori.ProductItem">
                                <EmptyDataTemplate>
                                    <div class="text-center">No data Found</div>
                                </EmptyDataTemplate>
                                <ItemTemplate>

                                    <!-- Single Portfolio -->
                                    <div class="cr-col-2 col-lg-3 col-md-4 col-sm-6 col-12 portfolio-single mt--30">
                                        <div class="portfolio" id="itemPlaceholder" runat="server">
                                            <div class="portfoilo-thumb">
                                                <img class="mx-auto d-block" src="images/Product/<%#If(Eval("ImageFile") IsNot "", Item.ImageFile, "unknown.jpg") %>">
                                                <div class="text-center text-md-left furgan-iconbox style-01">
                                                    <h4 class="title mt--10"><%#: Item.Name %></h4>
                                                    <h6 class="desc text-truncate" style="display: block;"><%#: Item.Description %></h6>
                                                    <div class="pt--20" style="height: 65px">
                                                        <%# if(Eval("Promotion"), "<div class='text-right text-danger'>RM " & Eval("PromoPrice") & " </div><div class='proPromoPrice text-right '><del>RM " & Eval("Price") & " </del></div>", "<div class='proprice text-right small'>RM " & Eval("Price") & " </div>") %>
                                                    </div>
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
                </ItemTemplate>
            </asp:ListView>
        </div>
    </section>
</asp:Content>
