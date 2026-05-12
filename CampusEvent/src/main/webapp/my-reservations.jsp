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
    String currentPage = request.getRequestURI();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Reservations</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f2f2f2, #64748b);
            color: #1A3263;
        }

        .navbar {
            background: #1A3263;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.15);
            margin-bottom: 30px;
        }

        .nav-logo {
            color: #64748b;
            text-decoration: none;
            font-size: 22px;
            font-weight: bold;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 18px;
            flex-wrap: wrap;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            font-weight: bold;
            padding: 8px 14px;
            border-radius: 8px;
            transition: 0.3s;
        }

        .nav-link:hover {
            background-color: #64748b;
            color: #1A3263;
            box-shadow: 0 0 10px #64748b,
                        0 0 20px #64748b;
        }

        .active-link {
            background-color: #64748b;
            color: #1A3263 !important;
            box-shadow: 0 0 10px #64748b,
                        0 0 20px #64748b;
        }

        .user-badge {
            color: #64748b;
            font-weight: bold;
            margin-right: 10px;
        }

        .logout-link {
            border: 1px solid #64748b;
        }

        .page-container {
            width: 90%;
            margin: 40px auto;
        }

        .header-box {
            background: #1A3263;
            color: white;
            padding: 25px;
            border-radius: 15px;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        .header-box h1 {
            margin: 0 0 10px 0;
        }

        .message {
            text-align: center;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .success {
            color: green;
        }

        .error {
            color: red;
        }

        .events-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }

        .event-card {
            background: #1A3263;
            color: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0,0,0,0.12);
        }

        .event-card h3 {
            margin-top: 0;
            color: #64748b;
        }

        .event-card p {
            margin: 8px 0;
            line-height: 1.5;
        }

        .btn {
            display: inline-block;
            margin-top: 12px;
            padding: 12px 20px;
            background-color: transparent;
            color: white;
            border: 2px solid #64748b;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn:hover {
            background-color: #64748b;
            color: #1A3263;
            box-shadow: 0 0 10px #64748b,
                        0 0 20px #64748b,
                        0 0 40px #64748b;
        }

        .empty-box {
            background: #1A3263;
            color: white;
            text-align: center;
            padding: 25px;
            border-radius: 15px;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="nav-left">
        <a href="index.jsp" class="nav-logo">Campus Event System</a>
    </div>

    <div class="nav-right">
       

        <a href="home" class="nav-link <%= currentPage.contains("index.jsp") ? "active-link" : "" %>">Home</a>

        <a href="view-events" class="nav-link <%= currentPage.contains("view-events") ? "active-link" : "" %>">Events</a>

        <a href="my-reservations" class="nav-link <%= currentPage.contains("my-reservations") ? "active-link" : "" %>">My Reservations</a>

        <a href="profile" class="nav-link <%= currentPage.contains("profile") ? "active-link" : "" %>">My Profile</a>

        <a href="logout" class="nav-link logout-link">Logout</a>
    </div>
</div>

<div class="page-container">

    <div class="header-box">
        <h1>My Reservations</h1>
       
    </div>

    <%
        String cancel = request.getParameter("cancel");
        if ("success".equals(cancel)) {
    %>
        <p class="message success">Reservation cancelled successfully!</p>
    <%
        } else if ("fail".equals(cancel)) {
    %>
        <p class="message error">Failed to cancel reservation.</p>
    <%
        }
    %>

    <%
        if (myEvents != null && !myEvents.isEmpty()) {
    %>
        <div class="events-grid">
            <%
                for (Event event : myEvents) {
            %>
                <div class="event-card">
                    <h3><%= event.getTitle() %></h3>
                    <p><strong>Description:</strong> <%= event.getDescription() %></p>
                    <p><strong>Date:</strong> <%= event.getEventDate() %></p>
                    <p><strong>Location:</strong> <%= event.getLocation() %></p>

                    <a class="btn" href="cancel-reservation?eventId=<%= event.getId() %>">Cancel Reservation</a>
                </div>
            <%
                }
            %>
        </div>
    <%
        } else {
    %>
        <div class="empty-box">
            <p>No reservations found.</p>
        </div>
    <%
        }
    %>

</div>

</body>
</html>