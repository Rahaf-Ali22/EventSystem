<%@ page import="java.util.List" %>
<%@ page import="model.Event" %>
<%@ page import="model.User" %>
<%@ page import="model.Department" %>
<%@ page import="model.Category" %>
<%
    User admin = (User) session.getAttribute("loggedInUser");

    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Event event = (Event) request.getAttribute("event");
    List<Department> departments = (List<Department>) request.getAttribute("departmentsList");
    List<Category> categories = (List<Category>) request.getAttribute("categoriesList");

    if (event == null) {
        response.sendRedirect("admin-events");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Event</title>

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

        .container {
            width: 70%;
            max-width: 950px;
            margin: 35px auto;
            background: white;
            border-radius: 18px;
            padding: 30px;
            box-shadow: 0 0 15px rgba(0,0,0,0.08);
        }

        h1 {
            text-align: center;
            color: #1A3263;
            margin-top: 0;
            margin-bottom: 25px;
        }

        .message {
            text-align: center;
            font-weight: bold;
            margin-bottom: 18px;
            color: red;
        }

        label {
            display: block;
            margin-top: 14px;
            margin-bottom: 8px;
            font-weight: bold;
            color: #1A3263;
        }

        input, textarea, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            box-sizing: border-box;
        }

        textarea {
            min-height: 110px;
            resize: vertical;
        }

        .buttons {
            margin-top: 28px;
            text-align: center;
        }

        .btn {
            display: inline-block;
            padding: 12px 22px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: bold;
            border: none;
            cursor: pointer;
            margin: 8px;
        }

        .btn-save {
            background: #ff4fa3;
            color: white;
        }

        .btn-back {
            background: #1A3263;
            color: white;
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

<div class="container">
    <h1>Edit Event</h1>

    <%
        String error = request.getParameter("error");
        if ("seats".equals(error)) {
    %>
        <p class="message">Seats remaining cannot be greater than capacity.</p>
    <%
        } else if ("fail".equals(error)) {
    %>
        <p class="message">Failed to update event.</p>
    <%
        }
    %>

    <form action="admin-edit-event" method="post">
        <input type="hidden" name="id" value="<%= event.getId() %>">

        <label>Title</label>
        <input type="text" name="title" value="<%= event.getTitle() %>" required>

        <label>Description</label>
        <textarea name="description" required><%= event.getDescription() %></textarea>

        <label>Event Date</label>
        <input type="date" name="eventDate" value="<%= event.getEventDate() %>" required>

        <label>Location</label>
        <input type="text" name="location" value="<%= event.getLocation() %>" required>

        <label>Capacity</label>
        <input type="number" name="capacity" value="<%= event.getCapacity() %>" min="1" required>

        <label>Seats Remaining</label>
        <input type="number" name="seatsRemaining" value="<%= event.getSeatsRemaining() %>" min="0" required>

        <label>Department / Club</label>
        <select name="departmentClub" required>
            <%
                if (departments != null && !departments.isEmpty()) {
                    for (Department department : departments) {
            %>
                <option value="<%= department.getName() %>"
                    <%= department.getName().equals(event.getDepartmentClub()) ? "selected" : "" %>>
                    <%= department.getName() %>
                </option>
            <%
                    }
                }
            %>
        </select>

        <label>Category</label>
        <select name="category" required>
            <%
                if (categories != null && !categories.isEmpty()) {
                    for (Category categoryObj : categories) {
            %>
                <option value="<%= categoryObj.getName() %>"
                    <%= categoryObj.getName().equals(event.getCategory()) ? "selected" : "" %>>
                    <%= categoryObj.getName() %>
                </option>
            <%
                    }
                }
            %>
        </select>

        <label>Event Type</label>
        <select name="eventType" required>
            <option value="Workshop" <%= "Workshop".equals(event.getEventType()) ? "selected" : "" %>>Workshop</option>
            <option value="Seminar" <%= "Seminar".equals(event.getEventType()) ? "selected" : "" %>>Seminar</option>
            <option value="Club Social Event" <%= "Club Social Event".equals(event.getEventType()) ? "selected" : "" %>>Club Social Event</option>
            <option value="Sports Activity" <%= "Sports Activity".equals(event.getEventType()) ? "selected" : "" %>>Sports Activity</option>
        </select>

        <label>Status</label>
        <select name="status" required>
            <option value="OPEN" <%= "OPEN".equals(event.getStatus()) ? "selected" : "" %>>OPEN</option>
            <option value="CLOSED" <%= "CLOSED".equals(event.getStatus()) ? "selected" : "" %>>CLOSED</option>
            <option value="EXPIRED" <%= "EXPIRED".equals(event.getStatus()) ? "selected" : "" %>>EXPIRED</option>
        </select>

        <div class="buttons">
            <button type="submit" class="btn btn-save">Save Changes</button>
            <a href="admin-events" class="btn btn-back">Back</a>
        </div>
    </form>
</div>

</body>
</html>