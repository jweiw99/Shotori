<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/MasterPages/Admin.Master" CodeBehind="Product.aspx.vb" Inherits="Shotori.Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Product Items</h1>
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary pt-3 float-left">View Product Items</h6>
            <div class="d-flex align-items-end justify-content-end">
                <asp:DropDownList ID="ddlCategoryList" runat="server" class="btn btn-facebook mt-3" AutoPostBack="True">
                    <asp:ListItem Value="-1">--- Select a Category ---</asp:ListItem>
                </asp:DropDownList>
                <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#addModal">Add Product</button>
            </div>
            <asp:Label ID="errorMessage" CssClass="text text-danger" runat="server" />
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <asp:GridView ID="GvProducts" runat="server" class="table table-bordered table-hover table-sm" DataKeyNames="ProId" SelectMethod="gvProduct_GetData" DeleteMethod="fvProduct_DeleteItem" UpdateMethod="fvProduct_UpdateItem" ItemType="Shotori.ProductItem" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True">
                    <Columns>
                        <asp:TemplateField HeaderText="No" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <asp:Label runat="server" Text="<%#: Container.DataItemIndex + 1 %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Image" ItemStyle-Width="150" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <asp:Image ID="ImgImage" Height="150" Width="150" runat="server" ImageUrl="<%# ConvertPath(Item.ImageFile) %>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:FileUpload ID="FuImage" runat="server" class="form-control" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name" HeaderStyle-CssClass="table-active" SortExpression="Name">
                            <ItemTemplate>
                                <a href="../../ProductDetails?pid=<%#: Item.ProId %>" target="_blank">
                                    <asp:Label ID="lblName" runat="server" Text="<%#: Item.Name %>" />
                                </a>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbName" class="form-control" pattern="[a-zA-Z0-9.\[\]\s,]+" runat="server" Text="<%#: BindItem.Name %>"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <asp:Label ID="lblDesc" runat="server" Text="<%#: Item.Description %>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbDesc" class="form-control" pattern="[a-zA-Z0-9.\[\]\s,]+" runat="server" Text="<%#: BindItem.Description %>"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Base Price" HeaderStyle-CssClass="table-active" SortExpression="BasePrice">
                            <ItemTemplate>
                                <asp:Label ID="lblBasePrice" runat="server" Text="<%#: Item.BasePrice %>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbBasePrice" class="form-control" step="0.01" type="number" runat="server" pattern="^\d*(\.\d{0,2})?$" Text="<%#: BindItem.BasePrice %>"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sales Price" HeaderStyle-CssClass="table-active" SortExpression="Price">
                            <ItemTemplate>
                                <asp:Label ID="lblPrice" runat="server" Text="<%#: Item.Price %>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbPrice" class="form-control" step="0.01" type="number" runat="server" pattern="^\d*(\.\d{0,2})?$" Text="<%#: BindItem.Price %>"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Promotion Price" HeaderStyle-CssClass="table-active" SortExpression="PromoPrice">
                            <ItemTemplate>
                                <asp:Label ID="lblPromoPrice" runat="server" Text="<%#: Item.PromoPrice %>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbPromoPrice" class="form-control" step="0.01" type="number" runat="server" pattern="^\d*(\.\d{0,2})?$" Text="<%#: BindItem.PromoPrice %>"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Promotion" HeaderStyle-CssClass="table-active" SortExpression="Promotion">
                            <ItemTemplate>
                                <asp:Label ID="lblPromotion" runat="server" Text="<%#: ShowPromotion(Item.Promotion) %>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="cbPromotion" runat="server" Checked="<%#: BindItem.Promotion %>" Text="On" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Category" HeaderStyle-CssClass="table-active" SortExpression="CatId">
                            <ItemTemplate>
                                <asp:Label ID="lblCategory" runat="server" Text="<%#: ShowCategory(Item.CatId) %>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlCategory" Style="-webkit-appearance: button;" runat="server" DataSource='<%# CategoryList %>' DataTextField="Text" DataValueField="Value" SelectedValue='<%#: BindItem.CatId %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status" HeaderStyle-CssClass="table-active" SortExpression="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblStatus" runat="server" Text="<%#: ShowStatus(Item.Status) %>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlStatus" Style="-webkit-appearance: button;" runat="server" DataSource='<%# StatusList %>' DataTextField="Text" DataValueField="Value" SelectedValue='<%#: BindItem.Status %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Row Version" HeaderStyle-CssClass="d-none" ItemStyle-CssClass="d-none">
                            <ItemTemplate>
                                <asp:Label ID="RowVersion" runat="server" Text="<%#: ConvertByte(Item.RowVersion) %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action" ItemStyle-Width="250" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" class="btn btn-dark" runat="server" CommandName="Edit" Text="Edit" />
                                <asp:Button ID="btnDelete" class="btn btn-danger" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this?');" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Button ID="btnUpdate" class="btn btn-info" runat="server" Text="Update" CommandName="Update" />
                                <asp:Button ID="btnCancel" class="btn btn-secondary" runat="server" Text="Cancel" CommandName="Cancel" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>No data found</EmptyDataTemplate>
                    <EmptyDataRowStyle HorizontalAlign="Center" />
                </asp:GridView>
            </div>
        </div>
    </div>
    <!-- Add Modal-->
    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Add Product Item</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div>
                        Category :
                    <asp:DropDownList ID="ddlProCat" runat="server" class="form-control">
                        <asp:ListItem Value="-1">--- Select a Category ---</asp:ListItem>
                    </asp:DropDownList>
                    </div>
                    <div class="mt-3">
                        Name :
                    <input type="text" runat="server" class="form-control addProdTextBox" autocomplete="off" pattern="[a-zA-Z0-9.\[\]\s,]+" id="proName" name="proName" placeholder="Product Name*" autofocus="autofocus" />
                    </div>
                    <div class="mt-3">
                        Description :
                    <textarea rows="2" class="form-control" runat="server" id="proDesc" name="proDesc" pattern="[a-zA-Z0-9.\[\]\s,]+" placeholder="Product Description"></textarea>
                    </div>
                    <div class="mt-3">
                        Base Price :
                    <input type="number" step=".01" runat="server" class="form-control addProdTextBox" autocomplete="off" id="proBasePrice" name="proBasePrice" placeholder="Base Price*" pattern="^\d*(\.\d{0,2})?$" />
                    </div>
                    <div class="mt-3">
                        Sales Price :
                    <input type="number" step=".01" runat="server" class="form-control addProdTextBox" autocomplete="off" id="proPrice" name="proPrice" placeholder="Sales Price*" pattern="^\d*(\.\d{0,2})?$" />
                    </div>
                    <div class="mt-3">
                        Promotion Price :
                    <input type="number" step=".01" runat="server" class="form-control addProdTextBox" autocomplete="off" id="proPromoPrice" name="proPromoPrice" placeholder="Promotion Price*" pattern="^\d*(\.\d{0,2})?$" />
                    </div>
                    <div class="mt-3">
                        Promotion :
                    <input id="proPromotion" type="checkbox" runat="server" />
                    </div>
                    <div class="mt-3">
                        Image :
                    <input type="file" name="proImage" class="form-control" id="proImage" runat="server" />
                    </div>
                    <div class="mt-3">
                        Status : 
                    <select class="form-control" id="proStatus" name="proStatus" runat="server">
                        <option value="0">Off</option>
                        <option value="1">On</option>
                    </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnAdd" class="btn btn-info" runat="server" Text="Add" onchange="checkIndex" />
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        $(document).ready(function () {
            $('#addModal').on('show.bs.modal', function (e) {
                $('.addProdTextBox').attr('required', 'required');
            });
            $('#addModal').on('hidden.bs.modal', function () {
                $('.addProdTextBox').removeAttr('required');
            });
            function checkIndex() {
                var item = document.getElementById("<%= ddlProCat.ClientID %>");
                if (item.options[item.selectedIndex].value == "-1") {
                    item.setCustomValidity('Please select valid option');
                } else {
                    item.setCustomValidity('');
                }
            }
        });
    </script>
</asp:Content>
