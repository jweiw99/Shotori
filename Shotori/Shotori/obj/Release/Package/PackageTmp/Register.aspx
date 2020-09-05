<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPages/Default.Master" CodeBehind="Register.aspx.vb" Inherits="Shotori.Register" %>

<%@ Register Src="~/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function check(input) {
            if (input.value != $('#<%=regPassword.ClientID %>').val()) {
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
                        <li role="presentation" class="login"><a href="Login.aspx">Login</a></li>
                        <li role="presentation" class="register active"><a href="Register.aspx">Register</a></li>
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
                            <div id="register" class="single__tabs__panel tab-pane fade in active">
                                <div class="login">
                                    <input runat="server" autocomplete="off" id="regEmail" type="email" name="email" placeholder="Email*" autofocus required />
                                    <input runat="server" autocomplete="off" id="regPassword" type="password" name="password" placeholder="Password*" required />
                                    <input runat="server" autocomplete="off" id="regConfirmPassword" type="password" name="password" placeholder="Confirm Password*" oninput="check(this)" required />
                                </div>
                                <div class="login htc__login__btn">
                                    <asp:Button runat="server" OnClick="CreateUser_Click" Text="Register" CssClass="btn btn-default" />
                                </div>
                                <div>
                                    <uc:OpenAuthProviders runat="server" ID="OpenAuthLogin" />
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
