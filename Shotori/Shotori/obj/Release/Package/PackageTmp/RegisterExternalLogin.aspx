<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPages/Default.Master" CodeBehind="RegisterExternalLogin.aspx.vb" Inherits="Shotori.RegisterExternalLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Start Login Area -->
    <div class="htc__login__register bg__white ptb--150" style="background: rgba(0, 0, 0, 0) url(images/bg/contact.jpg) no-repeat scroll center center / cover;">
        <div class="container  ptb--60">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <ul class="login__register__menu" style="max-width: 100%">
                        <li class="login active"><a href="#">Login With <%: ProviderName %> account</a></li>
                    </ul>
                </div>
            </div>
            <!-- Start Login Content -->
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="htc__login__register__wrap">
                        <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                            <p class="text-warning mb-3">
                                <asp:Literal runat="server" ID="FailureText" />
                            </p>
                        </asp:PlaceHolder>

                        <p class="text-info">
                            You've authenticated with <strong><%: ProviderName %></strong>. Please enter an email below for the current site
                and click the Log in button.
                        </p>

                        <!-- Start Single Content -->
                        <form runat="server">
                            <div id="login" class="single__tabs__panel tab-pane fade in active">

                                <div class="login">
                                    <input runat="server" autocomplete="off" id="Email" type="email" name="email" placeholder="Email*" autofocus required />
                                </div>
                                <div class="login htc__login__btn">
                                    <asp:Button runat="server" OnClick="LogIn_Click" Text="Login" CssClass="btn btn-default" />
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
