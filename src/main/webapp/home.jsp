<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="services.CustomerService,services.ItemService,services.BillService,model.Customer,model.Item,model.Bill" %>
<%@ page import="java.util.List,java.util.ArrayList" %>
<%

    CustomerService customerService = new CustomerService();
    ItemService itemService = new ItemService();
    BillService billService = new BillService();
    int totalCustomers = customerService.getAllCustomers().size();
    int totalItems = itemService.getAllItems().size();
    List<Bill> bills = billService.getAllBills(); // Updated to fetch all bills
    int totalBills = bills.size();
    double totalRevenue = 0;
    for (Bill bill : bills) {
        totalRevenue += bill.getAmount();
    }
%>
<html>
<head>
    <title>Home</title>
    <link rel="stylesheet" href="CSS/homePage.css">
</head>
<body>
<div class="main-layout">
    <jsp:include page="navbar.jsp" />
    <div class="content-area">
        <h2>Pahana Edu Online Billing System</h2>
        <div class="kpi-container">
            <div class="kpi-box">
                <div class="kpi-title">Total Customers</div>
                <div class="kpi-value"><%= totalCustomers %></div>
            </div>
            <div class="kpi-box">
                <div class="kpi-title">Total Items</div>
                <div class="kpi-value"><%= totalItems %></div>
            </div>
            <div class="kpi-box">
                <div class="kpi-title">Total Bills</div>
                <div class="kpi-value"><%= totalBills %></div>
            </div>
            <div class="kpi-box">
                <div class="kpi-title">Total Revenue</div>
                <div class="kpi-value">Rs. <%= String.format("%.2f", totalRevenue) %></div>
            </div>
        </div>
        <!-- Main content for home page -->
    </div>
</div>
</body>
</html>