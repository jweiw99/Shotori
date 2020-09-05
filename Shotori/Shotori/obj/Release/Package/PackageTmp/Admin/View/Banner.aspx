<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/MasterPages/Admin.Master" CodeBehind="Banner.aspx.vb" Inherits="Shotori.Banner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Home Page Banner</h1>
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary pt-3 float-left">View Banner List</h6>
            <div class="d-flex align-items-end justify-content-end">
                <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#addModal">Add Banner</button>
            </div>
            <asp:Label ID="errorMessage" CssClass="text text-danger" runat="server" />
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <asp:GridView ID="GvBanner" runat="server" class="table table-bordered table-hover table-sm" DataKeyNames="Text" SelectMethod="GvBanner_GetData" DeleteMethod="GvBanner_DeleteItem"
                    UpdateMethod="GvBanner_UpdateItem" AutoGenerateColumns="False" AllowPaging="True">
                    <Columns>
                        <asp:TemplateField HeaderStyle-Width="50" HeaderText="No" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <asp:Label runat="server" Text="<%#: Container.DataItemIndex + 1 %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Banner Image" ItemStyle-Width="150" HeaderStyle-CssClass="table-active">
                            <ItemTemplate>
                                <img height="200" width="500" src="<%# Eval("Value") %>" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:FileUpload ID="FuImage" runat="server" class="form-control" />
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
                    <h5 class="modal-title" id="exampleModalLabel">Add Banner</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="mt-3">
                        Image :
                    <input type="file" name="banImage" class="form-control addProdTextBox" id="banImage" runat="server" />
                    </div>
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
            $('#addModal').on('show.bs.modal', function (e) {
                $('.addProdTextBox').attr('required', 'required');
            });
            $('#addModal').on('hidden.bs.modal', function () {
                $('.addProdTextBox').removeAttr('required');
            });
        });
    </script>
</asp:Content>
