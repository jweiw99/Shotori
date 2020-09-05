<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPages/Default.Master" CodeBehind="ResetPassword.aspx.vb" Inherits="Shotori.ResetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function check(input) {
            if (input.value != $('#<%=NewPassword.ClientID %>').val()) {
                input.setCustomValidity('Password Must be Matching.');
            } else {
                // input is valid -- reset the error message
                input.setCustomValidity('');
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Start Login Register Area -->
    <div class="htc__login__register bg__white ptb--150" style="background: rgba(0, 0, 0, 0) url(images/bg/contact.jpg) no-repeat scroll center center / cover;">
        <div class="container  ptb--60">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <ul class="login__register__menu" role="tablist">
                        <li role="presentation" class="login active"><a href="#">Reset Password</a></li>
                    </ul>
                </div>
            </div>
            <!-- Start Login Register Content -->
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="htc__login__register__wrap">
                        <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                            <p class="text-warning mb-3">
                                <asp:Literal runat="server" ID="FailureText" />
                            </p>
                        </asp:PlaceHolder>
                        <!-- Start Single Content -->
                        <form runat="server">
                            <div id="login" class="single__tabs__panel tab-pane fade in active">
                                <div class="login">
                                    <input runat="server" autocomplete="off" id="NewPassword" type="password" name="password" placeholder="New Password*" required />
                                    <input runat="server" autocomplete="off" id="NewPasswordConfirm" type="password" name="password" placeholder="Confirm New Password*" oninput="check(this)" required />
                                </div>
                                <div class="login htc__login__btn">
                                    <asp:Button runat="server" OnClick="Reset" Text="Update" CssClass="btn btn-default" />
                                </div>
                            </div>
                        </form>
                        <!-- End Single Content -->
                    </div>
                </div>
            </div>
            <!-- End Login Register Content -->
        </div>
    </div>
    <!-- End Login Register Area -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Script" runat="server">
</asp:Content>
