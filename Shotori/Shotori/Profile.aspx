<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPages/Default.Master" CodeBehind="Profile.aspx.vb" Inherits="Shotori.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Start Bradcaump area -->
    <div class="ht__bradcaump__area" style="background: rgba(0, 0, 0, 0) url(images/bg/contact.jpg) no-repeat scroll center center / cover;">
        <div class="ht__bradcaump__wrap">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="bradcaump__inner text-center">
                            <h2 class="bradcaump-title">Profile</h2>
                            <nav class="bradcaump-inner">
                                <a class="breadcrumb-item" href="Default">Home</a>
                                <span class="brd-separetor">/</span>
                                <span class="breadcrumb-item active">Profile</span>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Bradcaump area -->
    <!-- Begin Page Content -->
    <section>
        <div class="pt--100 container">
            <div class="card-main shadow">
                <div class="card-header d-flex bd-highlight align-items-center" style="padding: 20px">
                    <h6 class="m-0 font-weight-bold text-primary bd-highlight">Build Your Profile</h6>
                </div>
                <div class="card-body wizard-card">
                    <div class="d-flex align-items-end justify-content-end">
                        <asp:Label ID="errorMessage" CssClass="text text-danger" runat="server" />
                    </div>
                    <form runat="server">
                        <div class="form-group">
                            <label>Name <small>(required)</small></label>
                            <input runat="server" name="usrName" id="usrName" pattern="[a-zA-Z0-9\s]+" type="text" class="form-control"
                                placeholder="Andrew..." required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-12">
                                <div class="form-group">
                                    <label>Email</label>
                                    <input runat="server" name="usrEmail" id="usrEmail" type="text" class="form-control" readonly>
                                </div>
                            </div>
                            <div class="col-md-6 col-12">
                                <div class="form-group">
                                    <label>Mobile Contact <small>(required)</small></label>
                                    <input runat="server" type="tel" id="usrPhone" pattern="[0-9]{2,3}-[0-9]{7,8}"
                                        class="form-control" placeholder="010-9999999" required>
                                </div>
                            </div>
                            <div class="col-md-4 col-12">
                                <div class="form-group">
                                    <label>Postal Code <small>(required)</small></label>
                                    <input runat="server" name="usrPostal" id="usrPostal" type="text" maxlength="5" pattern="[0-9]{5}" class="form-control" placeholder="99999" required />
                                </div>
                            </div>
                            <div class="col-md-4 col-12">
                                <div class="form-group">
                                    <label>State <small>(required)</small></label>
                                    <asp:DropDownList ID="ddlstate" runat="server" class="form-control" required>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-4 col-12">
                                <div class="form-group pb--10">
                                    <label>Country</label>
                                    <input runat="server" name="usrCountry" id="usrCountry" type="text" value="Malaysia" class="form-control" readonly>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group" style="padding: 0 15px 0 15px">
                                    <label>Address <small>(required)</small></label>
                                    <textarea runat="server" name="usrAddress" id="usrAddress" pattern="[a-zA-Z0-9\s,\.]+" class="form-control" rows="3"
                                        placeholder="No 10...." required></textarea>
                                </div>
                            </div>
                            <div class="col-12 d-flex align-items-end justify-content-end pt--20 pb--20" style="padding-right: 15px">
                                <asp:Button ID="btnSubmit" class="btn btn-info" runat="server" Text="Submit" />
                            </div>
                        </div>
                        <!-- end row -->
                    </form>
                </div>
            </div>
        </div>
    </section>
    <!-- /.container -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Script" runat="server">
    <script>
        $(document).ready(function () {
            $('#<%= btnSubmit.ClientID %>').click(function () {
                if ($('#<%= usrAddress.ClientID %>').val() == "") {
                    document.getElementById("<%= usrAddress.ClientID %>").setCustomValidity('Cannot be empty');
                } else {
                    var errorMsg = "Please do not enter special character.";
                    var pattern = new RegExp('^' + $('#<%= usrAddress.ClientID %>').attr('pattern') + '$');
                    $.each($('#<%= usrAddress.ClientID %>').val().split("\n"), function () {
                        // check if the line matches the pattern
                        var hasError = !this.match(pattern);
                        if (typeof document.getElementById("<%= usrAddress.ClientID %>").setCustomValidity === 'function') {
                            document.getElementById("<%= usrAddress.ClientID %>").setCustomValidity(hasError ? errorMsg : '');
                        }
                    });
                }
            });
        });
    </script>
</asp:Content>
