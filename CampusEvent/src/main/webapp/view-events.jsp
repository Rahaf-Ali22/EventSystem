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
    String currentPage = request.getRequestURI();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Events</title>

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
            color: #64748b;
            margin-top: 0;
        }

        .event-card p {
            line-height: 1.5;
        }

        .btn {
            display: inline-block;
            margin-top: 12px;
            padding: 12px 20px;
            border: 2px solid #64748b;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            background: transparent;
            transition: 0.3s;
            cursor: pointer;
            font-weight: bold;
        }

        .btn:hover {
            background-color: #64748b;
            color: #1A3263;
        }

        .search-box {
            background: #1A3263;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 25px;
        }

        .search-form {
            display: flex;
            gap: 15px;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
        }

        .search-form input,
        .search-form select {
            padding: 10px;
            border-radius: 8px;
            border: 2px solid #64748b;
            min-width: 220px;
        }

        .inline-select {
            margin-top: 12px;
            padding: 10px;
            border-radius: 8px;
            border: 2px solid #64748b;
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
        <h1>Available Events</h1>
     
    </div>

    <div class="search-box">
        <form action="view-events" method="get" class="search-form">
            <input type="text" name="keyword" placeholder="Search events...">

            <select name="filterType">
                <option value="title">Event Title</option>
                <option value="department">Department / Club</option>
                <option value="date">Event Date</option>
                <option value="category">Category</option>
                <option value="type">Event Type</option>
                <option value="availability">Availability</option>
            </select>

            <button type="submit" class="btn" style="color:black;">Search</button>
        </form>
    </div>

    <%
        String success = request.getParameter("success");
        if (success != null) {
    %>
        <p class="message success">Reservation successful!</p>
    <%
        }

        String error = request.getParameter("error");
        if ("already".equals(error)) {
    %>
        <p class="message error">You already reserved this event!</p>
    <%
        } else if ("invalid".equals(error)) {
    %>
        <p class="message error">Invalid event.</p>
    <%
        } else if ("fail".equals(error)) {
    %>
        <p class="message error">Reservation failed.</p>
    <%
        } else if ("closed".equals(error)) {
    %>
        <p class="message error">Event is closed.</p>
    <%
        } else if ("full".equals(error)) {
    %>
        <p class="message error">Event is full.</p>
    <%
        }
    %>

    <%
        String rateSuccess = request.getParameter("ratesuccess");
        if (rateSuccess != null) {
    %>
        <p class="message success">Rating submitted successfully!</p>
    <%
        }

        String rateError = request.getParameter("rateerror");
        if (rateError != null) {
    %>
        <p class="message error">Rating failed or already submitted.</p>
    <%
        }
    %>

    <%
        if (events != null && !events.isEmpty()) {
    %>
        <div class="events-grid">
            <%
                for (Event event : events) {
                    String status = event.getStatus();
            %>
                <div class="event-card">
    <h3><%= event.getTitle() %></h3>

<% if (event.getImage() != null && !event.getImage().isEmpty()) { %>
    <img src="<%= request.getContextPath() %>/uploads/<%= event.getImage() %>" 
         width="120"
         style="border-radius:10px; margin-bottom:10px;">
<% } %>
    <p><strong>Description:</strong> <%= event.getDescription() %></p>
    <p><strong>Date:</strong> <%= event.getEventDate() %></p>
    <p><strong>Location:</strong> <%= event.getLocation() %></p>
    <p><strong>Seats Remaining:</strong> <%= event.getSeatsRemaining() %></p>
    <p><strong>Department / Club:</strong> <%= event.getDepartmentClub() %></p>
    <p><strong>Category:</strong> <%= event.getCategory() %></p>
    <p><strong>Event Type:</strong> <%= event.getEventType() %></p>

                    <form action="rate-event" method="post">
                        <input type="hidden" name="eventId" value="<%= event.getId() %>">

                        <select name="rating" class="inline-select">
                            <option value="1">1 ⭐</option>
                            <option value="2">2 ⭐⭐</option>
                            <option value="3">3 ⭐⭐⭐</option>
                            <option value="4">4 ⭐⭐⭐⭐</option>
                            <option value="5">5 ⭐⭐⭐⭐⭐</option>
                        </select>

                        <br>
                        <button type="submit" class="btn" style="color:black;">Submit Rating</button>
                    </form>

                    <p><strong>Status:</strong>
                        <span style="
                            color:
                            <%= "OPEN".equals(status) ? "lightgreen" :
                                "EXPIRED".equals(status) ? "red" :
                                "orange" %>;
                            font-weight: bold;">
                            <%= status %>
                        </span>
                    </p>

                    <%
                        if ("OPEN".equals(status) && event.getSeatsRemaining() > 0) {
                    %>
                        <a class="btn" href="reserve?eventId=<%= event.getId() %>">Reserve</a>
                    <%
                        } else {
                    %>
                        <span class="btn" style="opacity:0.6; cursor:not-allowed;">Not Available</span>
                    <%
                        }
                    %>
                </div>
            <%
                }
            %>
        </div>
    <%
        } else {
    %>
        <p class="message error">No events found.</p>
    <%
        }
    %>

</div>

</body>
</html>