<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Shotori._Default2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="keywords" content="">

    <title>Shotori CMS</title>

    <!-- All css files are included here. -->
    <!-- Bootstrap fremwork main css -->
    <link href="../Styles/bootstrap.min.css" rel="stylesheet" />

    <!-- This core.css file contents all plugings css file. -->
    <link href="../Styles/core.css" rel="stylesheet" />

    <!-- Theme main style -->
    <link href="../Styles/admin.css" rel="stylesheet" />

    <!-- Font Awesome -->
    <link href="/Styles/shortcode/all.css" rel="stylesheet" />

    <!-- Responsive css -->
    <link href="../Styles/responsive.css" rel="stylesheet" />

    <!-- User style -->
    <link href="../Styles/custom.css" rel="stylesheet" />


</head>
<body class="bg-gradient-primary">
    <div class="container">
        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6 bg-white">
                                <div class="p-5">
                                    <div class="text-center">
                                        <img src="../images/logo/logo.png" height="88" width="142" alt="Shotori"></a>
                    <h1 class="h5 text-gray-900 mb-4">Welcome Back, Shotorian!</h1>
                                    </div>
                                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                                        <p class="text-warning mb-3">
                                            <asp:Literal runat="server" ID="FailureText" />
                                        </p>
                                    </asp:PlaceHolder>
                                    <form class="user" runat="server">
                                        <div class="input-wrapper">
                                            <i class="fas fa-envelope"></i>
                                            <input runat="server" autocomplete="off" id="email" type="email" name="email" placeholder="Staff Email" autofocus required />
                                        </div>
                                        <div class="input-wrapper">
                                            <i class="fas fa-key"></i>
                                            <input runat="server" autocomplete="off" id="password" type="password" name="password" placeholder="Password" required />
                                        </div>
                                        <div class="pl-3 pb-3 checkbox">
                                            <asp:CheckBox runat="server" ID="RememberMe" />
                                            <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me?</asp:Label>
                                        </div>
                                        <asp:Button runat="server" OnClick="LogIn" Text="Login" class="btn btn-facebook btn-user btn-block login-button" />
                                    </form>
                                    <hr>
                                    <div class="text-left">
                                        On password related enquiry, please email to
                    <a class="text-decoration-none" href="mailto:info@utar.edu.my">info@utar.edu.my</a>
                                        with necessary details (e.g. full name, some descriptions on the case)
                    for further assistance.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>

    <!-- jquery latest version -->
    <script src="../Scripts/vendor/jquery-1.12.0.min.js"></script>

    <!-- Bootstrap framework js -->
    <script src="../Scripts/bootstrap.min.js"></script>
</body>
</html>
