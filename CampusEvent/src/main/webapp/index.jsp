<%@ page import="java.util.List" %>
<%@ page import="model.Event" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("loggedInUser");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String currentPage = request.getRequestURI();

    Integer totalEvents = (Integer) request.getAttribute("totalEvents");
    Integer openEvents = (Integer) request.getAttribute("openEvents");
    Integer myReservationsCount = (Integer) request.getAttribute("myReservationsCount");
    List<Event> upcomingEvents = (List<Event>) request.getAttribute("upcomingEvents");

    if (totalEvents == null) totalEvents = 0;
    if (openEvents == null) openEvents = 0;
    if (myReservationsCount == null) myReservationsCount = 0;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>

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

        .logout-link {
            border: 1px solid #f8c8dc;
        }

        .active-link {
            background-color: #f8c8dc;
            color: #1A3263 !important;
            box-shadow: 0 0 10px #f8c8dc, 0 0 20px #f8c8dc;
        }

        .user-badge {
            color: #f8c8dc;
            font-weight: bold;
            margin-right: 10px;
        }

        .page-container {
            width: 94%;
            max-width: 1200px;
            margin: 18px auto 24px;
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

        .hero-actions {
            display: flex;
            justify-content: center;
            gap: 16px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-block;
            padding: 13px 24px;
            background-color: transparent;
            color: white;
            border: 2px solid #f8c8dc;
            border-radius: 10px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn:hover {
            background-color: #f8c8dc;
            color: #1A3263;
            box-shadow: 0 0 10px #f8c8dc, 0 0 20px #f8c8dc, 0 0 35px #f8c8dc;
        }

        .btn.primary {
            background: #f8c8dc;
            color: #1A3263;
        }

        .btn.primary:hover {
            background: transparent;
            color: white;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
            margin-bottom: 20px;
        }

        .stat-card {
            background: white;
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 0 15px rgba(0,0,0,0.08);
            text-align: center;
            border: 1px solid #f8c8dc;
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

        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 16px;
        }

        .panel {
            background: white;
            border-radius: 18px;
            padding: 20px;
            box-shadow: 0 0 15px rgba(0,0,0,0.08);
        }

        .panel h2 {
            margin: 0 0 14px 0;
            color: #1A3263;
            font-size: 25px;
        }

        .event-preview-card {
            background: #f9f3f6;
            border: 1px solid #f8c8dc;
            border-radius: 14px;
            padding: 16px;
            margin-bottom: 14px;
        }

        .event-preview-card h3 {
            margin: 0 0 8px 0;
            color: #1A3263;
            font-size: 19px;
        }

        .event-preview-card p {
            margin: 6px 0;
            color: #555;
            line-height: 1.5;
        }

        .mini-card {
            background: #f9f3f6;
            border: 1px solid #f8c8dc;
            border-radius: 14px;
            padding: 16px;
            margin-bottom: 12px;
        }

        .mini-card h3 {
            margin: 0 0 8px 0;
            color: #1A3263;
            font-size: 18px;
        }

        .mini-card p {
            margin: 0;
            color: #555;
            line-height: 1.6;
        }

        .tip-box {
            background: #1A3263;
            color: white;
            border-radius: 16px;
            padding: 16px;
            margin-top: 16px;
            line-height: 1.7;
        }

        .tip-box strong {
            color: #f8c8dc;
        }

        .empty-state {
            text-align: center;
            color: #666;
            padding: 18px 0;
        }

        @media (max-width: 900px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }

            .content-grid {
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
        <a href="home" class="nav-logo">Campus Event System</a>
    </div>

    <div class="nav-right">
        <span class="user-badge">Hi, <%= user.getName() %></span>

        <a href="home" class="nav-link active-link">Home</a>
        <a href="view-events" class="nav-link">Events</a>
        <a href="my-reservations" class="nav-link">My Reservations</a>
        <a href="profile" class="nav-link">My Profile</a>
        <a href="logout" class="nav-link logout-link">Logout</a>
    </div>
</div>

<div class="page-container">

    <div class="hero-section">
        <h1>Welcome, <%= user.getName() %></h1>
        <div class="hero-subtitle">Student Dashboard</div>
        <div class="hero-text">
            Track real campus activity from one place. View available events, monitor your reservations,
            and stay updated with upcoming activities across the system.
        </div>

        <div class="hero-actions">
            <a class="btn primary" href="view-events">Explore Events</a>
            <a class="btn" href="my-reservations">My Reservations</a>
            <a class="btn" href="profile">My Profile</a>
        </div>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <h3>Total Events</h3>
            <div class="stat-number"><%= totalEvents %></div>
        </div>

        <div class="stat-card">
            <h3>Open Events</h3>
            <div class="stat-number"><%= openEvents %></div>
        </div>

        <div class="stat-card">
            <h3>My Reservations</h3>
            <div class="stat-number"><%= myReservationsCount %></div>
        </div>
    </div>

    <div class="content-grid">
        <div class="panel">
            <h2>Upcoming Events</h2>

            <%
                if (upcomingEvents != null && !upcomingEvents.isEmpty()) {
                    for (Event event : upcomingEvents) {
            %>
                <div class="event-preview-card">
                    <h3><%= event.getTitle() %></h3>
                    <p><strong>Date:</strong> <%= event.getEventDate() %></p>
                    <p><strong>Location:</strong> <%= event.getLocation() %></p>
                    <p><strong>Category:</strong> <%= event.getCategory() %></p>
                    <p><strong>Seats Remaining:</strong> <%= event.getSeatsRemaining() %></p>
                </div>
            <%
                    }
                } else {
            %>
                <div class="empty-state">No upcoming events available right now.</div>
            <%
                }
            %>

            <div class="tip-box">
                <strong>Tip:</strong> Go to the Events page to see all events, reserve your seat,
                and use filters to search by title, department, date, category, type, or availability.
            </div>
        </div>

        <div class="panel">
            <h2>Overview</h2>

            <div class="mini-card">
                <h3>Your Role</h3>
                <p><%= user.getRole() %></p>
            </div>

            <div class="mini-card">
                <h3>Profile Status</h3>
                <p>Your profile is active and ready to use.</p>
            </div>

            <div class="mini-card">
                <h3>Reservation Summary</h3>
                <p>You currently have <strong><%= myReservationsCount %></strong> reservation(s).</p>
            </div>

            <div class="mini-card">
                <h3>Available Opportunities</h3>
                <p>There are <strong><%= openEvents %></strong> open event(s) you can explore now.</p>
            </div>
        </div>
    </div>

</div>

</body>
</html>