<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPages/Default.Master" CodeBehind="CheckOut.aspx.vb" Inherits="Shotori.CheckOut" %>

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
                            <h2 class="bradcaump-title">Checkout</h2>
                            <nav class="bradcaump-inner">
                                <a class="breadcrumb-item" href="Default">Home</a>
                                <span class="brd-separetor">/</span>
                                <a class="breadcrumb-item" href="Cart">Cart</a>
                                <span class="brd-separetor">/</span>
                                <span class="breadcrumb-item active">Checkout</span>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Bradcaump area -->
    <form runat="server">
        <!-- Start Checkout Area -->
        <section class="our-checkout-area ptb--120 bg__white">
            <div class="container">
                <div class="row">
                    <div class="col-md-8 col-lg-8">
                        <div class="ckeckout-left-sidebar">
                            <!-- Start Checkbox Area -->
                            <div class="checkout-form">
                                <h2 class="section-title-3">Deliver details</h2>
                                <p class="mt--20">Please confirm following details before purchase or else back to <a href="Profile" class="text-danger">Profile</a> to edit</p>
                                <div class="checkout-form-inner">
                                    <div class="single-checkout-box">
                                        <input runat="server" id="usrName" type="text" readonly>
                                        <input runat="server" id="usrCountry" type="text" value="Malaysia" readonly>
                                    </div>
                                    <div class="single-checkout-box">
                                        <input runat="server" id="usrEmail" type="text" readonly>
                                        <input runat="server" type="text" id="usrPhone" readonly>
                                    </div>
                                    <div class="single-checkout-box">
                                        <textarea runat="server" id="usrAddress" rows="5" readonly></textarea>
                                    </div>
                                    <div class="single-checkout-box mt--40">
                                        <input runat="server" id="usrState" type="text" readonly>
                                        <input runat="server" id="usrPostal" type="text" readonly />
                                    </div>
                                </div>
                            </div>
                            <!-- End Checkbox Area -->
                        </div>
                    </div>
                    <div class="col-md-4 col-lg-4">
                        <div class="checkout-right-sidebar">
                            <div class="our-important-note">
                                <h2 class="section-title-3">Note :</h2>
                                <p class="note-desc">Please read before purchase</p>
                                <ul class="important-note">
                                    <li><i class="zmdi zmdi-caret-right-circle"></i><span style="padding-left: 15px">Delivery is only available in Malaysia, we are currently unable to deliver outside of Malaysia.</span></li>
                                    <li><i class="zmdi zmdi-caret-right-circle"></i><span style="padding-left: 15px">Only cash on delivery.</span></li>
                                </ul>
                            </div>
                            <div class="puick-contact-area mt--60">
                                <h2 class="section-title-3">Quick Contract</h2>
                                <a href="phone:+8801722889963">+605-468 8888</a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Start Payment Box -->
                <div class="payment-form">
                    <h2 class="section-title-3">Order details</h2>
                    <p>Please confirm following order item before purchase or else back to <a href="Cart" class="text-danger">Cart</a> to edit</p>
                    <div class="payment-form-inner">
                        <div class="table-content table-responsive">
                            <asp:GridView ID="GvProducts" runat="server" DataKeyNames="ProId" SelectMethod="gvProduct_GetData" ItemType="Shotori.CartProduct" AutoGenerateColumns="False" AllowSorting="True">
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
                                            <asp:Label ID="lblQty" runat="server" Text="<%#: Item.Qty %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total" ItemStyle-CssClass="product-subtotal" HeaderStyle-CssClass="table-active">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTotalPrice" runat="server" Text="<%#: Item.Total %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>No product added to cart</EmptyDataTemplate>
                                <EmptyDataRowStyle HorizontalAlign="Center" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <!-- End Payment Box -->
                <!-- Start Payment Way -->
                <div class="our-payment-sestem">
                    <div class="row">
                        <div class="col-md-8 col-sm-7 col-xs-12">
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
                                    <asp:Button ID="btnBuy" class="ts-btn btn-light btn-large hover-theme" runat="server" Text="CONFIRM & BUY NOW" OnClientClick="return confirm('Are you sure you want to place order?');" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Payment Way -->
                </div>
            </div>
        </section>
        <!-- End Checkout Area -->
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Script" runat="server">
</asp:Content>
