<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/MasterPages/Admin.Master" CodeBehind="Order.aspx.vb" Inherits="Shotori.Order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Order Management</h1>
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary pt-3 float-left">View Order</h6>
            <div class="d-flex align-items-end justify-content-end">
                <asp:TextBox ID="txtSearch" CssClass="form-control" runat="server" type="number" placeholder="Search Order No"></asp:TextBox>
                <a href="#" runat="server" onserverclick="SearchOrder"><i class="material-icons">search</i></a>
            </div>
            <asp:Label ID="errorMessage" CssClass="text text-danger" runat="server" />
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <asp:GridView ID="GvOrders" runat="server" class="table table-bordered table-hover table-sm" DataKeyNames="oId" SelectMethod="gvOrder_GetData" UpdateMethod="gvOrder_UpdateItem" ItemType="Shotori.CustomerOrder" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True">
                    <Columns>
                        <asp:TemplateField HeaderText="Order ID" HeaderStyle-CssClass="table-active" SortExpression="oId">
                            <ItemTemplate>
                                <asp:Label ID="lbloID" runat="server" Text="<%#: Item.oId %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product ID" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <a href="../../ProductDetails?pid=<%#: Item.ProId %>" target="_blank">
                                    <asp:Label ID="lblproID" runat="server" Text="<%#: Item.ProId %>" />
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <a href="../../ProductDetails?pid=<%#: Item.ProId %>" target="_blank">
                                    <asp:Label ID="lblproName" runat="server" Text="<%#: ConvertProName(Item.ProId) %>" />
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Category" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <asp:Label ID="lblproCategory" runat="server" Text="<%#: ConvertCategory(Item.ProId) %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <asp:Label ID="lblqty" runat="server" Text="<%#: Item.Qty %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Customer Name" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <a href="Customer?cusEmail=<%#: Item.Email %>">
                                    <asp:Label ID="lblcusName" runat="server" Text="<%#: ConvertCusName(Item.Email) %>" /></a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Contact" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <asp:Label ID="lblcusContact" runat="server" Text="<%#: ConvertCusContact(Item.Email) %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="State" HeaderStyle-CssClass="table-active" SortExpression="State">
                            <ItemTemplate>
                                <asp:Label ID="lblstate" runat="server" Text="<%#: Item.State %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status" HeaderStyle-CssClass="table-active" SortExpression="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblStatus" CssClass="<%#: ConvertStatusClass(Item.Status) %>" runat="server" Text="<%#: ShowStatus(Item.Status) %>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlStatus" Style="-webkit-appearance: button;" runat="server" DataSource='<%# StatusList %>' DataTextField="Text" DataValueField="Value" SelectedValue='<%#: BindItem.Status %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Order Date" HeaderStyle-CssClass="table-active" SortExpression="CreateDateTime">
                            <ItemTemplate>
                                <asp:Label ID="lblorderDate" runat="server" Text="<%#: Item.CreateDateTime %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Row Version" HeaderStyle-CssClass="d-none" ItemStyle-CssClass="d-none">
                            <ItemTemplate>
                                <asp:Label ID="RowVersion" runat="server" Text="<%#: ConvertByte(Item.RowVersion) %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action" ItemStyle-Width="250" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" class="btn btn-dark" runat="server" CommandName="Edit" Text="Edit" />
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
