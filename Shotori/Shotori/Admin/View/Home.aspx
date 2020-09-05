<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/MasterPages/Admin.Master" CodeBehind="Home.aspx.vb" Inherits="Shotori.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Dashboard</h1>
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-stats">
                        <div class="card-header card-header-info card-header-icon">
                            <div class="card-icon">
                                <i class="material-icons">attach_money</i>
                            </div>
                            <p class="card-category">Today Profit</p>
                            <h3 class="card-title">
                                <small>RM </small><span runat="server" id="lbltodayProfit"></span>
                            </h3>
                        </div>
                        <div class="card-footer">
                            <div class="stats">
                                <i class="material-icons">update</i> Just Updated
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-stats">
                        <div class="card-header card-header-info card-header-icon">
                            <div class="card-icon">
                                <i class="material-icons">store</i>
                            </div>
                            <p class="card-category">Month Profit</p>
                            <h3 class="card-title">
                                <small>RM </small><span runat="server" id="lblmonthProfit"></span>
                            </h3>
                        </div>
                        <div class="card-footer">
                            <div class="stats">
                                <i class="material-icons">update</i> Just Updated
                 
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-stats">
                        <div class="card-header card-header-info card-header-icon">
                            <div class="card-icon">
                                <i class="material-icons">attach_money</i>
                            </div>
                            <p class="card-category">Month Revenue</p>
                            <h3 class="card-title">
                                <small>RM </small><span runat="server" id="lblmonthRevenue"></span>
                            </h3>
                        </div>
                        <div class="card-footer">
                            <div class="stats">
                                <i class="material-icons">update</i> Just Updated
                 
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-stats">
                        <div class="card-header card-header-warning card-header-icon">
                            <div class="card-icon">
                                <i class="fa fa-wrench"></i>
                            </div>
                            <p class="card-category">Month Cost</p>
                            <h3 class="card-title">
                                <small>RM </small><span runat="server" id="lvlmonthCost"></span>
                            </h3>
                        </div>
                        <div class="card-footer">
                            <div class="stats">
                                <i class="material-icons">update</i> Just Updated
                 
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-stats">
                        <div class="card-header card-header-success card-header-icon">
                            <div class="card-icon">
                                <i class="fa fa-truck"></i>
                            </div>
                            <p class="card-category">Total of On Delivery</p>
                            <h3 class="card-title"><span runat="server" id="lblOnDelivery"></span></h3>
                        </div>
                        <div class="card-footer">
                            <div class="stats">
                                <i class="material-icons">update</i> Just Updated
                 
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-stats">
                        <div class="card-header card-header-success card-header-icon">
                            <div class="card-icon">
                                <i class="material-icons">people</i>
                            </div>
                            <p class="card-category">Total Customer Register</p>
                            <h3 class="card-title"><span runat="server" id="lblcustomerRegister"></span></h3>
                        </div>
                        <div class="card-footer">
                            <div class="stats">
                                <i class="material-icons">update</i> Just Updated
                 
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-stats">
                        <div class="card-header card-header-danger card-header-icon">
                            <div class="card-icon">
                                <i class="material-icons">info_outline</i>
                            </div>
                            <p class="card-category">Total Pending Order</p>
                            <h3 class="card-title"><span runat="server" id="lblpendingOrder"></span></h3>
                        </div>
                        <div class="card-footer">
                            <div class="stats">
                                <i class="material-icons">update</i> Just Updated
                 
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-stats">
                        <div class="card-header card-header-danger card-header-icon">
                            <div class="card-icon">
                                <i class="material-icons">money_off</i>
                            </div>
                            <p class="card-category">This Month Cancelled Order</p>
                            <h3 class="card-title"><span runat="server" id="lblcancelOrder"></span></h3>
                        </div>
                        <div class="card-footer">
                            <div class="stats">
                                <i class="material-icons">update</i> Just Updated
                 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="card card-chart">
                        <div class="card-header card-header-info">
                            <div class="ct-chart" id="dailySalesChart"></div>
                        </div>
                        <div class="card-body">
                            <h4 class="card-title">Daily Sales</h4>
                            <p class="card-category">
                                <span id="dailySalesPercent"><%= dailySalesPercent %></span>
                            </p>
                        </div>
                        <div class="card-footer">
                            <div class="stats">
                                <i class="material-icons">update</i> Just Updated
                 
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card card-chart">
                        <div class="card-header card-header-success">
                            <div class="ct-chart" id="receivedOrderChart"></div>
                        </div>
                        <div class="card-body">
                            <h4 class="card-title">Received Order</h4>
                            <p class="card-category">
                                <span id="receivedOrderPercent"><%= receivedOrderPercent %></span>
                            </p>
                        </div>
                        <div class="card-footer">
                            <div class="stats">
                                <i class="material-icons">update</i> Just Updated
                 
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header card-header-warning">
                            <h4 class="card-title">Monthly Top Sales Product</h4>
                            <p class="card-category">Top Sales Products on August</p>
                        </div>
                        <div class="card-body table-responsive">
                            <asp:GridView ID="GvOrders" runat="server" class="table table-hover" ItemType="Shotori.CustomerOrder" SelectMethod="gvOrder_GetData" AutoGenerateColumns="False" AllowPaging="False" AllowSorting="False" BorderWidth="0">
                                <Columns>
                                    <asp:TemplateField HeaderText="ID" HeaderStyle-CssClass="text-warning">
                                        <ItemTemplate>
                                            <asp:Label ID="lblproID" runat="server" Text="<%#: Item.ProId %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Name" HeaderStyle-CssClass="text-warning">
                                        <ItemTemplate>
                                            <asp:Label ID="lblproName" runat="server" Text="<%#: ConvertProName(Item.ProId) %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Quantity" HeaderStyle-CssClass="text-warning">
                                        <ItemTemplate>
                                            <asp:Label ID="lblproQty" runat="server" Text="<%#: Item.Qty %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Category" HeaderStyle-CssClass="text-warning">
                                        <ItemTemplate>
                                            <asp:Label ID="lblqty" runat="server" Text="<%#: ConvertCategory(Item.ProId) %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>No Data Available</EmptyDataTemplate>
                                <EmptyDataRowStyle HorizontalAlign="Center" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">

    <script>
        $(document).ready(function () {

            initDashboardPageCharts();

            function initDashboardPageCharts() {

                if ($('#dailySalesChart').length != 0 && $('#receivedOrderChart').length != 0) {
                    /* ----------==========     Daily Sales Chart initialization    ==========---------- */

                    var dailySalesData = [<%= dailySales %>]

                    dataDailySalesChart = {
                        labels: ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
                        series: [
                            dailySalesData
                        ]
                    };

                    optionsDailySalesChart = {
                        lineSmooth: Chartist.Interpolation.cardinal({
                            tension: 0
                        }),
                        low: 0,
                        high: Math.max.apply(Math, dailySalesData) + 100,
                        chartPadding: {
                            top: 0,
                            right: 0,
                            bottom: 0,
                            left: 0
                        },
                    }

                    var dailySalesChart = new Chartist.Line('#dailySalesChart', dataDailySalesChart, optionsDailySalesChart);

                    md.startAnimationForLineChart(dailySalesChart);


                    /* ----------==========     Received Order Chart initialization    ==========---------- */

                    var receivedOrderData = [<%= receivedOrders %>]

                    dataReceivedOrderChart = {
                        labels: ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
                        series: [
                            receivedOrderData
                        ]
                    };

                    optionsReceivedOrderChart = {
                        lineSmooth: Chartist.Interpolation.cardinal({
                            tension: 0
                        }),
                        low: 0,
                        high: Math.max.apply(Math, receivedOrderData) + 10, // creative tim: we recommend you to set the high sa the biggest value + something for a better look
                        chartPadding: {
                            top: 0,
                            right: 0,
                            bottom: 0,
                            left: 0
                        }
                    }

                    var completedTasksChart = new Chartist.Line('#receivedOrderChart', dataReceivedOrderChart, optionsReceivedOrderChart);

                    // start animation for the Completed Tasks Chart - Line Chart
                    md.startAnimationForLineChart(completedTasksChart);

                }
            }
        });
    </script>
</asp:Content>
