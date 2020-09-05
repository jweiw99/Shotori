<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/MasterPages/Admin.Master" CodeBehind="ProductCategory.aspx.vb" Inherits="Shotori.ProductCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Product Categories</h1>
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary pt-3 float-left">View Product Categories</h6>
            <div class="d-flex align-items-end justify-content-end">
                <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#addModal">Add Category</button>
            </div>
            <asp:Label ID="errorMessage" CssClass="text text-danger" runat="server" />
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <asp:GridView ID="GvCategories" runat="server" class="table table-bordered table-hover table-sm" DataKeyNames="CatId" SelectMethod="gvCategories_GetData" DeleteMethod="fvCategory_DeleteItem" UpdateMethod="fvCategory_UpdateItem" ItemType="Shotori.ProductCategories" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True">
                    <Columns>
                        <asp:TemplateField HeaderText="No" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <asp:Label runat="server" Text="<%#: Container.DataItemIndex + 1 %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Category Name" HeaderStyle-CssClass="table-active" SortExpression="Name">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server" Text="<%#: Item.Name %>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbName" class="form-control" runat="server" Text="<%#: BindItem.Name %>"></asp:TextBox>
                            </EditItemTemplate>
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
                    <h5 class="modal-title" id="exampleModalLabel">Add Category</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" class="form-control" autocomplete="off" ID="catName" placeholder="Category Name*"></asp:TextBox>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnAdd" class="btn btn-info" runat="server" Text="Add" />
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        $(document).ready(function () {
            $('#<%= btnAdd.ClientID %>').click(function () {
                if ($('#<%= catName.ClientID %>').val() == "") {
                    document.getElementById("<%= catName.ClientID %>").setCustomValidity('Cannot be empty');
                } else {
                    document.getElementById("<%= catName.ClientID %>").setCustomValidity('');
                }
            });
            $(".btn").not("#<%= btnAdd.ClientID %>").click(function () {
                document.getElementById("<%= catName.ClientID %>").setCustomValidity('');
            });
        });
    </script>
</asp:Content>
