<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="CSS/loginPage.css">
</head>
<body>
<div class="main-layout">
    <div class="login-container">
        <div class="header-bar">
            <h3>Pahana Edu Online Billing System</h3>
        </div>
        <h2>Sign Up</h2>
        <form method="post" action="login">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <% if (request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>
            <button type="submit">Login</button>
        </form>
    </div>
</div>
</body>
</html>