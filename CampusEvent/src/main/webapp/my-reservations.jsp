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

    List<Event> myEvents = (List<Event>) request.getAttribute("myEvents");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Reservations</title>
</head>
<body>

    <h1>My Reservations</h1>
    <p>Welcome, <%= user.getName() %> 👋</p>

    <hr>
<%
    String cancel = request.getParameter("cancel");
    if ("success".equals(cancel)) {
%>
    <p style="color:green;">Reservation cancelled successfully!</p>
<%
    } else if ("fail".equals(cancel)) {
%>
    <p style="color:red;">Failed to cancel reservation.</p>
<%
    }
%>
    <%
        if (myEvents != null && !myEvents.isEmpty()) {
            for (Event event : myEvents) {
    %>
        <div style="margin-bottom: 20px; border: 1px solid black; padding: 10px;">
            <h3><%= event.getTitle() %></h3>
            <p><strong>Description:</strong> <%= event.getDescription() %></p>
            <p><strong>Date:</strong> <%= event.getEventDate() %></p>
            <p><strong>Location:</strong> <%= event.getLocation() %></p>
            
            <a href="cancel-reservation?eventId=<%= event.getId() %>">Cancel Reservation</a>
        </div>
    <%
            }
        } else {
    %>
        <p>No reservations found.</p>
    <%
        }
    %>

    <br>
    <a href="index.jsp">Back to Home</a>
    <br><br>
    <a href="logout">Logout</a>

</body>
</html>