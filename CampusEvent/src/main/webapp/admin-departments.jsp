<%@ page import="java.util.List" %>
<%@ page import="model.Department" %>
<%@ page import="model.User" %>
<%
    User admin = (User) session.getAttribute("loggedInUser");

    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Department> departments = (List<Department>) request.getAttribute("departmentsList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Departments</title>

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
            gap: 12px;
            flex-wrap: wrap;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            font-weight: bold;
            padding: 8px 12px;
            border-radius: 8px;
        }

        .nav-link:hover, .active-link {
            background: #f8c8dc;
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
            width: 92%;
            max-width: 1200px;
            margin: 25px auto;
        }

        .header-box {
            background: #1A3263;
            color: white;
            padding: 25px;
            border-radius: 16px;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-box, .table-box {
            background: white;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 0 12px rgba(0,0,0,0.08);
        }

        input[type="text"] {
            width: 70%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
        }

        .btn {
            display: inline-block;
            padding: 10px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            color: white;
            border: none;
            cursor: pointer;
        }

        .btn-add {
            background: #4caf50;
        }

        .btn-delete {
            background: #e53935;
        }

        .message {
            text-align: center;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .success {
            color: green;
        }

        .error {
            color: red;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 14px;
            border-bottom: 1px solid #eee;
            text-align: center;
        }

        th {
            background: #1A3263;
            color: white;
        }
    </style>
</head>
<body>

<div class="navbar">
    <a href="admin-dashboard" class="nav-logo">Campus Event System</a>

  <div class="nav-right">
  
    <a href="admin-dashboard" class="nav-link">Dashboard</a>
    <a href="admin-users" class="nav-link">Manage Users</a>
    <a href="admin-events" class="nav-link">Manage Events</a>
    <a href="admin-departments" class="nav-link active-link">Departments</a>
    <a href="admin-categories" class="nav-link">Categories</a>
    <a href="logout" class="nav-link logout-link">Logout</a>
</div>
</div>

<div class="page-container">

    <div class="header-box">
        <h1>Manage Departments</h1>
        <p>Add and delete departments from the system.</p>
    </div>

    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");

        if ("added".equals(success)) {
    %>
        <p class="message success">Department added successfully.</p>
    <%
        } else if ("deleted".equals(success)) {
    %>
        <p class="message success">Department deleted successfully.</p>
    <%
        }

        if ("exists".equals(error)) {
    %>
        <p class="message error">Department already exists.</p>
    <%
        } else if ("empty".equals(error)) {
    %>
        <p class="message error">Department name is required.</p>
    <%
        } else if ("fail".equals(error) || "invalid".equals(error)) {
    %>
        <p class="message error">Operation failed.</p>
    <%
        }
    %>

    <div class="form-box">
        <form action="admin-departments" method="post">
            <input type="text" name="name" placeholder="Enter department name" required>
            <button type="submit" class="btn btn-add">Add Department</button>
        </form>
    </div>

    <div class="table-box">
        <table>
            <tr>
                <th>ID</th>
                <th>Department Name</th>
                <th>Action</th>
            </tr>

            <%
                if (departments != null && !departments.isEmpty()) {
                    for (Department department : departments) {
            %>
            <tr>
                <td><%= department.getId() %></td>
                <td><%= department.getName() %></td>
                <td>
                    <a class="btn btn-delete"
                       href="admin-departments?action=delete&id=<%= department.getId() %>"
                       onclick="return confirm('Are you sure you want to delete this department?');">
                       Delete
                    </a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="3">No departments found.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

</div>

</body>
</html>