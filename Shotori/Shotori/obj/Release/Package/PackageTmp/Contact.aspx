<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPages/Default.Master" CodeBehind="contact.aspx.vb" Inherits="Shotori.contact" %>

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
                            <h2 class="bradcaump-title">Contact US</h2>
                            <nav class="bradcaump-inner">
                                <a class="breadcrumb-item" href="Default">Home</a>
                                <span class="brd-separetor">/</span>
                                <span class="breadcrumb-item active">Contact US</span>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Bradcaump area -->
    <!-- Start Contact Area -->
    <section class="htc__contact__area ptb--120 bg__white">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                    <div class="htc__contact__container">
                        <div class="htc__contact__address">
                            <h2 class="contact__title">contact info</h2>
                            <div class="contact__address__inner">
                                <!-- Start Single Adress -->
                                <div class="single__contact__address">
                                    <div class="contact__icon">
                                        <span class="ti-location-pin"></span>
                                    </div>
                                    <div class="contact__details">
                                        <p>
                                            Location :
                                            <br>
                                            Jalan Universiti, Bandar Barat,
31900 Kampar, Negeri Perak, Malaysia
                                        </p>
                                    </div>
                                </div>
                                <!-- End Single Adress -->
                            </div>
                            <div class="contact__address__inner">
                                <!-- Start Single Adress -->
                                <div class="single__contact__address">
                                    <div class="contact__icon">
                                        <span class="ti-mobile"></span>
                                    </div>
                                    <div class="contact__details">
                                        <p>
                                            Phone :
                                            <br>
                                            <a href="tel:+605-468 8888">+605-468 8888</a>
                                        </p>
                                    </div>
                                </div>
                                <!-- End Single Adress -->
                            </div>
                            <div class="contact__address__inner">
                                <!-- Start Single Adress -->
                                <div class="single__contact__address">
                                    <div class="contact__icon">
                                        <span class="ti-email"></span>
                                    </div>
                                    <div class="contact__details">
                                        <p>
                                            Mail :<br>
                                            <a href="mailto:info@utar.edu.my">info@utar.edu.my</a>
                                        </p>
                                    </div>
                                </div>
                                <!-- End Single Adress -->
                            </div>
                            <div class="contact__address__inner">
                                <!-- Start Single Adress -->
                                <div class="single__contact__address">
                                    <div class="contact__icon">
                                        <span class="ti-user"></span>
                                    </div>
                                    <div class="contact__details">
                                        <p>
                                            Office Hours :<br>
                                            Monday to Friday: 8:30am - 5:30pm<br>
                                            <small>(OFF ON SATURDAY, SUNDAY AND PUBLIC HOLIDAYS)</small>
                                        </p>
                                    </div>
                                </div>
                                <!-- End Single Adress -->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12 smt-30 xmt-30">
                    <div class="map-contacts">
                        <div id="googleMap">
                            <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d7956.754689516053!2d101.14298!3d4.340067!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xa86e1b61b2c8e747!2sFaculty+of+Information+and+Communication+Technology+(FICT)%2C+UTAR!5e0!3m2!1sen!2smy!4v1550330774218" width="100%" height="100%" frameborder="0" style="border: 0" allowfullscreen></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Contact Area -->
</asp:Content>
