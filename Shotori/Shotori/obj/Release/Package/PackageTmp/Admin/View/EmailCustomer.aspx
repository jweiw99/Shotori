<%@ Page Title="" Async="true" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/MasterPages/Admin.Master" CodeBehind="EmailCustomer.aspx.vb" Inherits="Shotori.EmailCustomer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Import Trumbowyg plugins... -->
    <link rel="stylesheet" href="../vendor/Trumbowyg/ui/trumbowyg.min.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Email Customer</h1>
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <div class="d-flex">
                <h6 class="m-0 font-weight-bold text-primary pt-3 float-left">Email to All Customer</h6>
            </div>
            <asp:Label ID="errorMessage" CssClass="text text-danger mt-3" runat="server" />
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <div class="mt-2 mb-3">
                    Subject (Only Character, number and [] symbol are allowed) : 
                    <input type="text" runat="server" class="form-control" autocomplete="off" id="tbEmailSub" pattern="[a-zA-Z0-9.\[\]\s]+" placeholder="Email Subject*" autofocus="autofocus" required="required" />
                </div>
                <textarea id="tbContent" class="richeditor" runat="server" name="tbContent" placeholder="Email Content*" required></textarea>
                <div class="d-flex align-items-end justify-content-end">
                    <asp:Button ID="btnEmail" class="btn btn-info" runat="server" OnClientClick="makeSafe()" OnClick="btnEmail_ClickAsync" Text="Email Now" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <!-- Import Trumbowyg plugins... -->
    <script src="../vendor/Trumbowyg/trumbowyg.min.js"></script>
    <script src="../vendor/Trumbowyg/plugins/upload/trumbowyg.cleanpaste.min.js"></script>
    <script src="../vendor/Trumbowyg/plugins/upload/trumbowyg.pasteimage.min.js"></script>
    <script>

        $(document).ready(function () {
            $('.richeditor').trumbowyg({
                btns: [
                    ['viewHTML'],
                    ['undo', 'redo'], // Only supported in Blink browsers
                    ['formatting'],
                    ['strong', 'em', 'del'],
                    ['superscript', 'subscript'],
                    ['link'],
                    ['insertImage'],
                    ['justifyLeft', 'justifyCenter', 'justifyRight', 'justifyFull'],
                    ['unorderedList', 'orderedList'],
                    ['horizontalRule'],
                    ['removeformat'],
                    ['fullscreen']
                ]
            });

        });

        function makeSafe() {
            document.getElementById('<%= tbContent.ClientID %>').value = window.escape(document.getElementById('<%= tbContent.ClientID %>').value);
        };

    </script>
</asp:Content>
