<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPages/Default.Master" CodeBehind="Cart.aspx.vb" Inherits="Shotori.Cart" %>

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
                            <h2 class="bradcaump-title">Cart</h2>
                            <nav class="bradcaump-inner">
                                <a class="breadcrumb-item" href="Default">Home</a>
                                <span class="brd-separetor">/</span>
                                <span class="breadcrumb-item active">Cart</span>
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
                            <asp:GridView ID="GvProducts" runat="server" DataKeyNames="ProId" SelectMethod="gvProduct_GetData" DeleteMethod="fvProduct_DeleteItem" UpdateMethod="fvProduct_UpdateItem" ItemType="Shotori.CartProduct" AutoGenerateColumns="False" AllowSorting="True">
                                <Columns>
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
                                            <asp:TextBox ID="tbQty" class="form-control" step="1" type="number" runat="server" pattern="\d*" Text="<%#: BindItem.Qty %>"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total" ItemStyle-CssClass="product-subtotal" HeaderStyle-CssClass="table-active">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTotalPrice" runat="server" Text="<%#: Item.Total %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action" ItemStyle-CssClass="product-remove" HeaderStyle-CssClass="table-active">
                                        <ItemTemplate>
                                            <asp:Button ID="btnUpdate" class="btn btn-info" runat="server" Text="Update" CommandName="Update" />
                                            <asp:Button ID="btnDelete" class="btn btn-danger" runat="server" CommandName="Delete" Text="Delete" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>No product added to cart</EmptyDataTemplate>
                                <EmptyDataRowStyle HorizontalAlign="Center" />
                            </asp:GridView>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8 col-sm-7 col-xs-12">
                            <div class="buttons-cart">
                                <a href="Shop">Continue Shopping</a>
                            </div>
                            <div class="coupon">
                                <h3>Please read before purchase</h3>
                                <p><i class="fas fa-truck"></i><span style="padding-left: 15px">Delivery is only available in Malaysia, we are currently unable to deliver outside of Malaysia.</span></p>
                                <p><i class="far fa-money-bill-alt"></i><span style="padding-left: 15px">Only cash on delivery.</span></p>
                            </div>

                        </div>
                        <div class="col-md-4 col-sm-5 col-xs-12">
                            <div class="cart_totals">
                                <h2>Cart Totals</h2>
                                <table>
                                    <tbody>
                                        <tr class="cart-subtotal">
                                            <th>Subtotal</th>
                                            <td class="amount">RM <span runat="server" id="subtotal"></span></td>
                                        </tr>
                                        <tr class="shipping">
                                            <th>Shipping</th>
                                            <td>
                                                <ul id="shipping_method">
                                                    <li>
                                                        <label>
                                                            Free Shipping
                                                        </label>
                                                    </li>
                                                    <li></li>
                                                </ul>
                                            </td>
                                        </tr>
                                        <tr class="order-total">
                                            <th>Total</th>
                                            <td class="amount">
                                                <strong>RM <span runat="server" id="totalAmount"></span></strong>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="wc-proceed-to-checkout">
                                    <a href="CheckOut">Proceed to Checkout</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- cart-main-area end -->
    </form>
</asp:Content>
