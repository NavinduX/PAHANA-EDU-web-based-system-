<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<link rel="stylesheet" href="CSS/navbar.css">
<nav class="navbar">
    <div class="navbar-user">
        <h3 style="color: #fff;">Hi, <%= user != null ? user.getUsername() : "Guest" %></h3>
    </div>
    <div class="navbar-menu">
        <a href="home.jsp">Home</a>
        <a href="manageCustomers">Customer</a>
        <a href="manageItems">Item</a>
        <a href="calculateBill">Bill</a>
        <a href="help.jsp">Help</a>
    </div>
    <div class="navbar-exit">
        <a href="logout">Exit</a>
    </div>
</nav>