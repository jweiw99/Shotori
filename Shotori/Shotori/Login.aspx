<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPages/Default.Master" CodeBehind="Login.aspx.vb" Inherits="Shotori.Login" %>

<%@ Register Src="~/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Start Login Register Area -->
    <div class="htc__login__register bg__white ptb--150" style="background: rgba(0, 0, 0, 0) url(images/bg/contact.jpg) no-repeat scroll center center / cover;">
        <div class="container  ptb--60">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <ul class="login__register__menu" role="tablist">
                        <li role="presentation" class="login active"><a href="Login.aspx">Login</a></li>
                        <li role="presentation" class="register"><a href="Register.aspx">Register</a></li>
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
                                    <input runat="server" autocomplete="off" id="Email" type="email" name="email" placeholder="Email*" autofocus required />
                                    <input runat="server" autocomplete="off" id="Password" type="password" name="password" placeholder="Password*" required />
                                </div>
                                <div class="tabs__checkbox">
                                    <asp:CheckBox runat="server" ID="RememberMe" />
                                    <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me?</asp:Label>
                                </div>
                                <div class="login htc__login__btn">
                                    <asp:Button runat="server" OnClick="LogIn" Text="Login" CssClass="btn btn-default" />
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
