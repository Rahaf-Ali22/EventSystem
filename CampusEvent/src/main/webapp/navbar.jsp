<%@ page import="model.User" %>
<%
User user = (User) session.getAttribute("loggedInUser");
String currentPage = request.getRequestURI();
%>

<style>
.navbar {
    background: #1A3263;
    padding: 15px 30px;
    display: flex;
    align-items: center;
    gap: 15px;
}

.logo {
    color: #cbd5e1;
    font-weight: bold;
    margin-right: 20px;
    font-size: 18px;
}

.nav-link {
    color: white;
    text-decoration: none;
    font-weight: bold;
    padding: 8px 15px;
    border-radius: 8px;
    transition: 0.2s;
}

.nav-link:hover {
    background: #6b7280;
}

.nav-link.active {
    background: #cbd5e1;
    color: #1A3263;
}

.logout {
    margin-left: auto;
    border: 1px solid white;
}
</style>

<div class="navbar">

    <div class="logo">Campus Event System</div>

    <a href="admin-dashboard"
       class="nav-link <%= currentPage.contains("admin-dashboard") ? "active" : "" %>">
       Dashboard
    </a>

    <a href="admin-users"
       class="nav-link <%= currentPage.contains("admin-users") ? "active" : "" %>">
       Manage Users
    </a>

    <a href="admin-events"
       class="nav-link <%= currentPage.contains("admin-events") ? "active" : "" %>">
       Manage Events
    </a>

    <a href="manage-departments"
       class="nav-link <%= currentPage.contains("departments") ? "active" : "" %>">
       Departments
    </a>

    <a href="manage-categories"
       class="nav-link <%= currentPage.contains("categories") ? "active" : "" %>">
       Categories
    </a>

    <a href="logout" class="nav-link logout">Logout</a>

</div>