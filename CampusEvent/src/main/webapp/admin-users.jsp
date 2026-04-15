<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%
    User admin = (User) session.getAttribute("loggedInUser");

    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<User> users = (List<User>) request.getAttribute("usersList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users</title>

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
            max-width: 1300px;
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
            min-width: 1000px;
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

        .btn-block {
            background: #ff9800;
        }

        .btn-unblock {
            background: #4caf50;
        }

        .btn-delete {
            background: #e53935;
        }

        .status-blocked {
            color: red;
            font-weight: bold;
        }

        .status-active {
            color: green;
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
        <a href="admin-users" class="nav-link active-link">Manage Users</a>
        <a href="admin-events" class="nav-link">Manage Events</a>
        <a href="admin-departments" class="nav-link">Departments</a>
        <a href="admin-categories" class="nav-link">Categories</a>
        <a href="logout" class="nav-link logout-link">Logout</a>
    </div>
</div>

<div class="page-container">

    <div class="header-box">
        <h1>Manage Users</h1>
        <p>View all users and control their accounts.</p>
    </div>

  <%
    String success = request.getParameter("success");
    String error = request.getParameter("error");

    if ("blocked".equals(success)) {
%>
    <p class="message success">User blocked successfully.</p>
<%
    } else if ("unblocked".equals(success)) {
%>
    <p class="message success">User unblocked successfully.</p>
<%
    } else if ("deleted".equals(success)) {
%>
    <p class="message success">User deleted successfully.</p>
<%
    }

    if ("fail".equals(error)) {
%>
    <p class="message error">Operation failed.</p>
<%
    } else if ("invalid".equals(error)) {
%>
    <p class="message error">Invalid request.</p>
<%
    } else if ("self".equals(error)) {
%>
    <p class="message error">You cannot block, unblock, or delete your own admin account.</p>
<%
    } else if ("hasReservations".equals(error)) {
%>
    <p class="message error">You cannot delete this user because they have reservations.</p>
<%
    } else if ("hasEvents".equals(error)) {
%>
    <p class="message error">You cannot delete this user because they are linked to existing events.</p>
<%
    } else if ("admin".equals(error)) {
%>
    <p class="message error">Admin accounts cannot be managed from this panel.</p>
<%
    } else if ("notfound".equals(error)) {
%>
    <p class="message error">User not found.</p>
<%
    }
%>
    <div class="table-box">
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Faculty</th>
                <th>Department</th>
                <th>Admission Year</th>
                <th>Role</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>

            <%
                if (users != null && !users.isEmpty()) {
                    for (User user : users) {
            %>
            <tr>
                <td><%= user.getId() %></td>
                <td><%= user.getName() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getFaculty() %></td>
                <td><%= user.getDepartment() %></td>
                <td><%= user.getAdmissionYear() %></td>
                <td><%= user.getRole() %></td>
                <td>
                    <% if (user.isBlocked()) { %>
                        <span class="status-blocked">Blocked</span>
                    <% } else { %>
                        <span class="status-active">Active</span>
                    <% } %>
                </td>
                <td>
                    <% if (user.isBlocked()) { %>
                        <a class="btn btn-unblock" href="admin-users?action=unblock&id=<%= user.getId() %>">Unblock</a>
                    <% } else { %>
                        <a class="btn btn-block" href="admin-users?action=block&id=<%= user.getId() %>">Block</a>
                    <% } %>

                    <a class="btn btn-delete" href="admin-users?action=delete&id=<%= user.getId() %>"
                       onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="9">No users found.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

</div>

</body>
</html>