<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("loggedInUser");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Integer totalUsers = (Integer) request.getAttribute("totalUsers");
    Integer blockedUsers = (Integer) request.getAttribute("blockedUsers");
    Integer totalEvents = (Integer) request.getAttribute("totalEvents");
    Integer openEvents = (Integer) request.getAttribute("openEvents");

    if (totalUsers == null) totalUsers = 0;
    if (blockedUsers == null) blockedUsers = 0;
    if (totalEvents == null) totalEvents = 0;
    if (openEvents == null) openEvents = 0;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>

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
            box-shadow: 0 0 10px #f8c8dc, 0 0 20px #f8c8dc;
        }

        .active-link {
            background-color: #f8c8dc;
            color: #1A3263 !important;
            box-shadow: 0 0 10px #f8c8dc, 0 0 20px #f8c8dc;
        }

        .logout-link {
            border: 1px solid #f8c8dc;
        }

        .user-badge {
            color: #f8c8dc;
            font-weight: bold;
            margin-right: 10px;
        }

        .page-container {
            width: 94%;
            max-width: 1200px;
            margin: 20px auto;
        }

        .hero-section {
            background: #1A3263;
            color: white;
            border-radius: 22px;
            padding: 34px 28px;
            text-align: center;
            box-shadow: 0 0 20px rgba(0,0,0,0.12);
            margin-bottom: 20px;
        }

        .hero-section h1 {
            margin: 0 0 10px 0;
            font-size: 38px;
        }

        .hero-subtitle {
            color: #f8c8dc;
            font-size: 22px;
            margin-bottom: 16px;
        }

        .hero-text {
            width: 82%;
            margin: 0 auto 24px;
            line-height: 1.7;
            font-size: 17px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
            margin-bottom: 20px;
        }

        .stat-card {
            background: white;
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 0 15px rgba(0,0,0,0.08);
            border: 1px solid #f8c8dc;
            text-align: center;
        }

        .stat-card h3 {
            margin: 0 0 10px 0;
            color: #1A3263;
            font-size: 20px;
        }

        .stat-number {
            font-size: 34px;
            font-weight: bold;
            color: #ff4fa3;
        }

        .cards-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
        }

        .dashboard-card {
            background: white;
            border-radius: 18px;
            padding: 24px;
            box-shadow: 0 0 15px rgba(0,0,0,0.08);
            border: 1px solid #f8c8dc;
            text-align: center;
        }

        .dashboard-card h2 {
            margin-top: 0;
            color: #1A3263;
            font-size: 24px;
        }

        .dashboard-card p {
            color: #555;
            line-height: 1.6;
            min-height: 60px;
        }

        .btn {
            display: inline-block;
            padding: 12px 22px;
            background-color: #ff4fa3;
            color: white;
            border-radius: 10px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn:hover {
            background-color: #e63e91;
            box-shadow: 0 0 10px #f8c8dc, 0 0 20px #f8c8dc;
        }

        @media (max-width: 900px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }

            .cards-grid {
                grid-template-columns: 1fr;
            }

            .hero-text {
                width: 96%;
            }

            .hero-section h1 {
                font-size: 32px;
            }

            .nav-right {
                gap: 10px;
                justify-content: flex-end;
            }
        }
    </style>
</head>

<body>

<div class="navbar">
    <div class="nav-left">
        <a href="admin-dashboard" class="nav-logo">Campus Event System</a>
    </div>

    <div class="nav-right">
      
        <a href="admin-dashboard" class="nav-link active-link">Dashboard</a>
        <a href="admin-users" class="nav-link">Manage Users</a>
        <a href="admin-events" class="nav-link">Manage Events</a>
        <a href="admin-departments" class="nav-link">Departments</a>
        <a href="admin-categories" class="nav-link">Categories</a>
        <a href="logout" class="nav-link logout-link">Logout</a>
    </div>
</div>

<div class="page-container">

    <div class="hero-section">
        <h1>Welcome, <%= user.getName() %></h1>
        <div class="hero-subtitle">Admin Dashboard</div>
        <div class="hero-text">
            Monitor real system data, manage users, and control campus events through one centralized admin panel.
        </div>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <h3>Total Users</h3>
            <div class="stat-number"><%= totalUsers %></div>
        </div>

        <div class="stat-card">
            <h3>Blocked Users</h3>
            <div class="stat-number"><%= blockedUsers %></div>
        </div>

        <div class="stat-card">
            <h3>Total Events</h3>
            <div class="stat-number"><%= totalEvents %></div>
        </div>

        <div class="stat-card">
            <h3>Open Events</h3>
            <div class="stat-number"><%= openEvents %></div>
        </div>
    </div>

    <div class="cards-grid">
        <div class="dashboard-card">
            <h2>Manage Users</h2>
            <p>View all users, block or unblock accounts, and delete users when needed.</p>
            <a href="admin-users" class="btn">Open Users Panel</a>
        </div>

        <div class="dashboard-card">
            <h2>Manage Events</h2>
            <p>View all events, monitor their status, and delete any event from the admin panel.</p>
            <a href="admin-events" class="btn">Open Events Panel</a>
        </div>

        <div class="dashboard-card">
            <h2>System Summary</h2>
            <p>
                The system currently has <strong><%= totalUsers %></strong> user(s),
                <strong><%= totalEvents %></strong> event(s),
                and <strong><%= openEvents %></strong> open event(s).
            </p>
            <a href="logout" class="btn">Logout</a>
        </div>
    </div>

</div>

</body>
</html>