<%@ page import="java.util.List" %>
<%@ page import="model.Event" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    User user = (User) session.getAttribute("loggedInUser");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Event> events = (List<Event>) request.getAttribute("eventsList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Events</title>
</head>
<body>

    <h1>Available Events</h1>
    <p>Welcome, <%= user.getName() %> 👋</p>

    <hr>

    <%
        String success = request.getParameter("success");
        if (success != null) {
    %>
        <p style="color:green;">Reservation successful!</p>
    <%
        }
    %>

    <%
        String error = request.getParameter("error");
        if ("already".equals(error)) {
    %>
        <p style="color:red;">You already reserved this event!</p>
    <%
        }
    %>

    <%
        if (events != null && !events.isEmpty()) {
            for (Event event : events) {
    %>
        <div style="margin-bottom: 20px; border: 1px solid black; padding: 10px;">
            <h3><%= event.getTitle() %></h3>
            <p><strong>Description:</strong> <%= event.getDescription() %></p>
            <p><strong>Date:</strong> <%= event.getEventDate() %></p>
            <p><strong>Location:</strong> <%= event.getLocation() %></p>
            <p><strong>Capacity:</strong> <%= event.getCapacity() %></p>

            <a href="reserve?eventId=<%= event.getId() %>">Reserve</a>
        </div>
    <%
            }
        } else {
    %>
        <p>No events found.</p>
    <%
        }
    %>

    <br>
    <a href="index.jsp">Back to Home</a>
    <br><br>
    <a href="logout">Logout</a>

</body>
</html>