<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPages/Default.Master" CodeBehind="MyOrder.aspx.vb" Inherits="Shotori.MyOrder" %>

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
                            <h2 class="bradcaump-title">My Order</h2>
                            <nav class="bradcaump-inner">
                                <a class="breadcrumb-item" href="Default">Home</a>
                                <span class="brd-separetor">/</span>
                                <span class="breadcrumb-item active">My Order</span>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Bradcaump area -->
    <form runat="server">
        <!-- cart-main-area start -->
        <div class="cart-main-area ptb--120 bg__white">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <asp:Label ID="errorMessage" CssClass="text text-danger" runat="server" />
                        <div class="table-content table-responsive">
                            <asp:GridView ID="GvProducts" runat="server" ItemType="Shotori.CartOrder" SelectMethod="gvProduct_GetData" AutoGenerateColumns="False" AllowPaging="true" AllowSorting="True">
                                <Columns>
                                    <asp:TemplateField HeaderText="Order No" ItemStyle-Width="100" ItemStyle-CssClass="product-name" HeaderStyle-CssClass="table-active">
                                        <ItemTemplate>
                                            <asp:Label ID="lbloId" runat="server" Text="<%#: Item.oId %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Image" ItemStyle-CssClass="product-thumbnail" HeaderStyle-CssClass="table-active">
                                        <ItemTemplate>
                                            <asp:Image ID="ImgImage" runat="server" ImageUrl="<%# ConvertPath(Item.ImageFile) %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Product" ItemStyle-CssClass="product-name" HeaderStyle-CssClass="table-active">
                                        <ItemTemplate>
                                            <asp:Label ID="lblName" runat="server" Text="<%#: Item.Name %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Price" ItemStyle-CssClass="product-price" HeaderStyle-CssClass="table-active">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPrice" runat="server" Text="<%#: Item.Price %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Quantity" ItemStyle-CssClass="product-quantity" HeaderStyle-CssClass="table-active">
                                        <ItemTemplate>
                                            <asp:Label ID="lblQty" runat="server" Text="<%#: Item.Qty %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total" ItemStyle-CssClass="product-subtotal" HeaderStyle-CssClass="table-active">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTotalPrice" runat="server" Text="<%#: Item.Total %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status" ItemStyle-CssClass="product-remove" HeaderStyle-CssClass="table-active">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStatus" runat="server" CssClass="<%#: ConvertStatusClass(Item.Status) %>" Text="<%#: ConvertStatus(Item.Status) %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Update Date" ItemStyle-CssClass="product-remove" HeaderStyle-CssClass="table-active">
                                        <ItemTemplate>
                                            <asp:Label ID="lblUpdateTime" runat="server" Text="<%#: Item.UpdateDate %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Order Date" ItemStyle-CssClass="product-remove" HeaderStyle-CssClass="table-active">
                                        <ItemTemplate>
                                            <asp:Label ID="lblOrderTime" runat="server" Text="<%#: Item.OrderDate %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>No product added to cart</EmptyDataTemplate>
                                <EmptyDataRowStyle HorizontalAlign="Center" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- cart-main-area end -->
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Script" runat="server">
</asp:Content>
