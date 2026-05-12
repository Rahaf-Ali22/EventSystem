<%@ page import="model.User" %>
<%
User user = (User) session.getAttribute("loggedInUser");

if (user == null || !"organizer".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect("login.jsp");
    return;
}

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

    <a href="organizer-dashboard"
       class="nav-link <%= currentPage.contains("organizer-dashboard") ? "active" : "" %>">
       Dashboard
    </a>

    <a href="organizer-dashboard"
       class="nav-link <%= currentPage.contains("organizer-dashboard") ? "active" : "" %>">
       My Events
    </a>

    <a href="create-event"
       class="nav-link <%= currentPage.contains("create-event") ? "active" : "" %>">
       Create Event
    </a>

    <a href="logout" class="nav-link logout">Logout</a>

</div>