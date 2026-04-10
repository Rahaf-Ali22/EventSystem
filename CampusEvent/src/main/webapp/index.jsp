<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("loggedInUser");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Campus Event System</title>
    
</head>
<body>
   <h1>Campus Event Management System 🚀</h1>

<p>Welcome, <%= user.getName() %> 👋</p>

<hr>

<h3>What do you want to do?</h3>

<ul>
    <li><a href="#">View Events</a></li>
    <li><a href="#">My Tickets</a></li>
    <li><a href="#">Create Event (Organizer)</a></li>
</ul>

<br>

<a href="logout">Logout</a>
    
</body>
</html>