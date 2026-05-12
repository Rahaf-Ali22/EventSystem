<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%
    User admin = (User) session.getAttribute("loggedInUser");

    if (admin == null || !"admin".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<style>

body {
    margin: 0;
    font-family: Arial;
    background: linear-gradient(135deg, #f2f2f2, #cbd5e1);
}

/* 🔥 NAVBAR الجديد */
.navbar {
    background: #1A3263;
    padding: 15px 30px;
    display: flex;
    align-items: center;
    gap: 15px;
}

.nav-link {
    color: white;
    text-decoration: none;
    font-weight: bold;
    padding: 8px 15px;
    border-radius: 8px;
    transition: 0.2s;
}

/* Hover */
.nav-link:hover {
    background: #6b7280;
}

/* Active */
.nav-link.active {
    background: #cbd5e1;
    color: #1A3263;
}

/* Logout */
.logout {
    margin-left: auto;
    border: 1px solid white;
}

/* Container */
.container {
    width: 90%;
    margin: 30px auto;
}

/* Hero */
.hero {
    background: #1A3263;
    color: white;
    padding: 25px;
    border-radius: 12px;
    text-align: center;
}

/* Stats */
.stats {
    display: flex;
    gap: 20px;
    margin: 20px 0;
}

.card {
    flex: 1;
    background: white;
    padding: 20px;
    border-radius: 12px;
    text-align: center;
}

.number {
    font-size: 26px;
    font-weight: bold;
    color: #6b7280;
}

/* Grid */
.grid {
    display: flex;
    gap: 20px;
}

/* Boxes */
.box {
    flex: 1;
    background: white;
    padding: 20px;
    border-radius: 12px;
}

/* Items */
.item {
    border-bottom: 1px solid #ddd;
    padding: 10px 0;
}

.item p {
    margin: 5px 0;
    font-size: 14px;
}

/* Actions */
.actions a {
    display: block;
    margin-top: 10px;
    color: #1A3263;
    font-weight: bold;
    text-decoration: none;
}

</style>
</head>

<body>

<!-- 🔥 Navbar -->
<jsp:include page="navbar.jsp" />

<div class="container">

    <!-- Hero -->
    <div class="hero">
        <h2>Welcome, <%= admin.getName() %></h2>
        <p>Manage system users, events, and settings efficiently</p>
    </div>

    <!-- Stats -->
    <div class="stats">

        <div class="card">
            <h3>Total Users</h3>
            <div class="number"><%= request.getAttribute("totalUsers") %></div>
        </div>

        <div class="card">
            <h3>Blocked Users</h3>
            <div class="number"><%= request.getAttribute("blockedUsers") %></div>
        </div>

        <div class="card">
            <h3>Total Events</h3>
            <div class="number"><%= request.getAttribute("totalEvents") %></div>
        </div>

        <div class="card">
            <h3>Open Events</h3>
            <div class="number"><%= request.getAttribute("openEvents") %></div>
        </div>

    </div>

    <!-- Grid -->
    <div class="grid">

        <!-- Recent Users -->
        <div class="box">
            <h3>Recent Users</h3>

            <%
            List<User> users = (List<User>) request.getAttribute("usersList");

            if (users != null) {
                for (User u : users) {
            %>
                <div class="item">

                    <b><%= u.getName() %></b>

                    <p>
                        <%= u.getEmail() %><br>

                        Role:
                        <span style="color:
                        <%= "admin".equalsIgnoreCase(u.getRole()) ? "red" :
                            "organizer".equalsIgnoreCase(u.getRole()) ? "blue" : "green" %>;">
                            <%= u.getRole() %>
                        </span>
                        <br>

                        Joined: <%= u.getAdmissionYear() %>
                    </p>

                </div>
            <%
                }
            } else {
            %>
                <p>No users data</p>
            <%
            }
            %>
        </div>

        <!-- Quick Actions -->
        <div class="box">
            <h3>Quick Actions</h3>

            <div class="actions">
                <a href="admin-users">Manage Users</a>
                <a href="admin-events">Manage Events</a>
                <a href="manage-departments">Departments</a>
                <a href="manage-categories">Categories</a>
            </div>

        </div>

    </div>

</div>

</body>
</html>