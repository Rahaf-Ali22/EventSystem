<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>

<h2>Login</h2>

<form action="login" method="post">
    <label>Email:</label><br>
    <input type="email" name="email" required><br><br>

    <label>Password:</label><br>
    <input type="password" name="password" required><br><br>

    <input type="submit" value="Login">
</form>
<%
    String error = (String) request.getAttribute("errorMessage");
    if (error != null) {
%>
    <p style="color:red;"><%= error %></p>
<%
    }
%>
</body>
</html>