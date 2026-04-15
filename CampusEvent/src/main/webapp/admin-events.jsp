<%@ page import="java.util.List" %>
<%@ page import="model.Event" %>
<%@ page import="model.User" %>
<%
    User admin = (User) session.getAttribute("loggedInUser");

    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Event> events = (List<Event>) request.getAttribute("eventsList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Events</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f2f2f2, #f8c8dc);
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
        }

        .nav-logo {
            color: #f8c8dc;
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
            background-color: #f8c8dc;
            color: #1A3263;
        }

        .active-link {
            background-color: #f8c8dc;
            color: #1A3263 !important;
        }

        .logout-link {
            border: 1px solid #f8c8dc;
        }

        .user-badge {
            color: #f8c8dc;
            font-weight: bold;
        }

        .page-container {
            width: 95%;
            max-width: 1350px;
            margin: 25px auto;
        }

        .header-box {
            background: #1A3263;
            color: white;
            padding: 25px;
            border-radius: 16px;
            text-align: center;
            margin-bottom: 25px;
        }

        .message {
            text-align: center;
            font-weight: bold;
            margin-bottom: 18px;
        }

        .success {
            color: green;
        }

        .error {
            color: red;
        }

        .table-box {
            background: white;
            padding: 20px;
            border-radius: 18px;
            box-shadow: 0 0 15px rgba(0,0,0,0.08);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1200px;
        }

        th, td {
            padding: 14px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background: #1A3263;
            color: white;
        }

        tr:hover {
            background: #faf4f7;
        }

        .btn {
            display: inline-block;
            padding: 8px 14px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            color: white;
            margin: 2px;
        }

        .btn-delete {
            background: #e53935;
        }

        .status-open {
            color: green;
            font-weight: bold;
        }

        .status-expired {
            color: red;
            font-weight: bold;
        }

        .status-other {
            color: orange;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="nav-left">
        <a href="admin-dashboard" class="nav-logo">Campus Event System</a>
    </div>

    <div class="nav-right">
      
        <a href="admin-dashboard" class="nav-link">Dashboard</a>
        <a href="admin-users" class="nav-link">Manage Users</a>
        <a href="admin-events" class="nav-link active-link">Manage Events</a>  
        <a href="admin-departments" class="nav-link">Departments</a>
<a href="admin-categories" class="nav-link">Categories</a>
<a href="logout" class="nav-link logout-link">Logout</a>
    </div>
</div>

<div class="page-container">

    <div class="header-box">
        <h1>Manage Events</h1>
        <p>View all events and control them from the admin panel.</p>
    </div>

  <%
    String success = request.getParameter("success");
    String error = request.getParameter("error");

    if ("deleted".equals(success)) {
%>
    <p class="message success">Event deleted successfully.</p>
<%
    } else if ("updated".equals(success)) {
%>
    <p class="message success">Event updated successfully.</p>
<%
    }

    if ("fail".equals(error)) {
%>
    <p class="message error">Failed to delete event.</p>
<%
    } else if ("invalid".equals(error)) {
%>
    <p class="message error">Invalid request.</p>
<%
    } else if ("notfound".equals(error)) {
%>
    <p class="message error">Event not found.</p>
<%
    } else if ("hasReservations".equals(error)) {
%>
    <p class="message error">You cannot delete this event because it already has reservations.</p>
<%
    }
%>

    <div class="table-box">
        <table>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Description</th>
                <th>Date</th>
                <th>Location</th>
                <th>Capacity</th>
                <th>Seats Remaining</th>
                <th>Department / Club</th>
                <th>Category</th>
                <th>Event Type</th>
                <th>Status</th>
              <th>Actions</th>
            </tr>

            <%
                if (events != null && !events.isEmpty()) {
                    for (Event event : events) {
            %>
            <tr>
                <td><%= event.getId() %></td>
                <td><%= event.getTitle() %></td>
                <td><%= event.getDescription() %></td>
                <td><%= event.getEventDate() %></td>
                <td><%= event.getLocation() %></td>
                <td><%= event.getCapacity() %></td>
                <td><%= event.getSeatsRemaining() %></td>
                <td><%= event.getDepartmentClub() %></td>
                <td><%= event.getCategory() %></td>
                <td><%= event.getEventType() %></td>
                <td>
                    <%
                        String status = event.getStatus();
                        if ("OPEN".equalsIgnoreCase(status)) {
                    %>
                        <span class="status-open"><%= status %></span>
                    <%
                        } else if ("EXPIRED".equalsIgnoreCase(status)) {
                    %>
                        <span class="status-expired"><%= status %></span>
                    <%
                        } else {
                    %>
                        <span class="status-other"><%= status %></span>
                    <%
                        }
                    %>
                </td>
                <td>
    <a class="btn" style="background:#4caf50;"
       href="admin-edit-event?id=<%= event.getId() %>">
       Edit
    </a>

    <a class="btn btn-delete"
       href="admin-events?action=delete&id=<%= event.getId() %>"
       onclick="return confirm('Are you sure you want to delete this event?');">
       Delete
    </a>
</td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="12">No events found.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

</div>

</body>
</html>