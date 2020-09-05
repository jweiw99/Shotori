<%@ Page Title="" Async="true" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/MasterPages/Admin.Master" CodeBehind="Customer.aspx.vb" Inherits="Shotori.Customer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="h3 mb-2 text-gray-800">Customer Management</h1>
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary pt-3 float-left">Customer List</h6>
            <div class="d-flex align-items-end justify-content-end">
                <asp:TextBox ID="txtSearch" CssClass="form-control" Width="300" runat="server" type="text" pattern="[a-zA-Z0-9\s!,\.@\-]+" placeholder="Search by Name / Email / Phone"></asp:TextBox>
                <a href="#" runat="server" onserverclick="SearchCustomer"><i class="material-icons">search</i></a>
            </div>
            <asp:Label ID="errorMessage" CssClass="text text-danger" runat="server" />
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <asp:GridView ID="gvCust" runat="server" class="table table-bordered table-hover table-sm" DataKeyNames="UserId" SelectMethod="gvCust_GetData" ItemType="Shotori.UserInfo" UpdateMethod="fvCust_UpdateItem" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True">
                    <Columns>
                        <asp:TemplateField HeaderText="Customer Name" HeaderStyle-CssClass="table-active" SortExpression="Name">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server" Text="<%#: Item.Name %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Phone Number" HeaderStyle-CssClass="table-active" SortExpression="Phone">
                            <ItemTemplate>
                                <asp:Label ID="lblPhone" runat="server" Text="<%#: Item.Phone%>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Email Address" HeaderStyle-CssClass="table-active" SortExpression="Email">
                            <ItemTemplate>
                                <asp:Label ID="lblEmail" runat="server" Text="<%#: Item.Email %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Address" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <asp:Label ID="lblAddress" runat="server" Text="<%#: Item.Address %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Postal Code" HeaderStyle-CssClass="table-active" SortExpression="PostalCode">
                            <ItemTemplate>
                                <asp:Label ID="lblPostal" runat="server" Text="<%#: Item.PostalCode %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="State" HeaderStyle-CssClass="table-active" SortExpression="State">
                            <ItemTemplate>
                                <asp:Label ID="lblState" runat="server" Text="<%#: ConvertState(Item.State) %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Country" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <asp:Label ID="lblCountry" runat="server" Text="<%#: Item.Country %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action" ItemStyle-Width="250" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <asp:Button ID="btnUpdate" class="btn btn-info" runat="server" CommandName="Update" Text="Reset Password" OnClientClick="return confirm('Are you sure you want to reset password?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>No data found</EmptyDataTemplate>
                    <EmptyDataRowStyle HorizontalAlign="Center" />
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
