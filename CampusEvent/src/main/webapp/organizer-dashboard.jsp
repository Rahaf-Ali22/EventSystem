<%@ page import="java.util.List" %>
<%@ page import="model.Event" %>
<%@ page import="model.User" %>
<%@ page import="model.Reservation" %>
<%@ page import="dao.EventDAO" %>
<%@ page import="dao.ReservationDAO" %>

<%
User organizer = (User) session.getAttribute("loggedInUser");

if (organizer == null || !"organizer".equalsIgnoreCase(organizer.getRole())) {
    response.sendRedirect("login.jsp");
    return;
}

List<Event> myEvents = (List<Event>) request.getAttribute("myEvents");
Integer totalEvents = (Integer) request.getAttribute("totalEvents");
Integer openEvents = (Integer) request.getAttribute("openEvents");

if (totalEvents == null) totalEvents = 0;
if (openEvents == null) openEvents = 0;

EventDAO eventDAO = new EventDAO();
ReservationDAO reservationDAO = new ReservationDAO();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Organizer Dashboard</title>

<style>

body {
    margin: 0;
    font-family: Arial;
    background: linear-gradient(135deg, #f2f2f2, #cbd5e1);
}

.container {
    width: 90%;
    margin: 30px auto;
}

.hero {
    background: #1A3263;
    color: white;
    padding: 30px;
    border-radius: 12px;
    text-align: center;
}

.stats {
    display: flex;
    gap: 20px;
    margin: 25px 0;
}

.card {
    flex: 1;
    background: white;
    padding: 25px;
    border-radius: 12px;
    text-align: center;
}

.number {
    font-size: 28px;
    font-weight: bold;
    color: #6b7280;
}

.grid {
    display: flex;
    gap: 20px;
}

.box {
    flex: 1;
    background: white;
    padding: 20px;
    border-radius: 12px;
}

.event {
    border-bottom: 1px solid #ddd;
    padding: 12px 0;
}

.btn {
    display: inline-block;
    margin-top: 8px;
    margin-right: 5px;
    padding: 6px 12px;
    background: #1A3263;
    color: white;
    border-radius: 6px;
    text-decoration: none;
    font-size: 13px;
}

.delete {
    background: #d9534f;
}

.status-open { color: green; font-weight: bold; }
.status-closed { color: red; font-weight: bold; }
.status-completed { color: gray; font-weight: bold; }

.attendance-box {
    margin-top: 10px;
    padding: 8px;
    background: #f9f9f9;
    border-radius: 8px;
}

</style>
</head>

<body>

<jsp:include page="organizer-navbar.jsp" />

<div class="container">

<div class="hero">
    <h2>Welcome, <%= organizer.getName() %></h2>
    <p>You create and manage events for students</p>
</div>

<div class="stats">
    <div class="card">
        <h3>Total Events</h3>
        <div class="number"><%= totalEvents %></div>
    </div>

    <div class="card">
        <h3>Open Events</h3>
        <div class="number"><%= openEvents %></div>
    </div>
</div>

<div class="grid">

<div class="box">
<h3>My Events</h3>

<%
if (myEvents != null && !myEvents.isEmpty()) {
    for (Event e : myEvents) {

        int count = eventDAO.getEventReservationsCount(e.getId());
        List<Reservation> reservations = reservationDAO.getReservationsByEvent(e.getId());
%>

<div class="event">

<b><%= e.getTitle() %></b><br>
<img src="<%= request.getContextPath() %>/uploads/<%= e.getImage() %>" 
     width="120"
     style="border-radius:10px;"> 
<br>
Location: <%= e.getLocation() %><br>

Status:
<span class="
<%= "OPEN".equals(e.getStatus()) ? "status-open" :
    "CLOSED".equals(e.getStatus()) ? "status-closed" :
    "status-completed" %>">
<%= e.getStatus() %>
</span>

<br>
Attendees: <%= count %>

<br>

<a href="edit-event?id=<%= e.getId() %>" class="btn">Edit</a>

<a href="delete-event?id=<%= e.getId() %>" 
   onclick="return confirm('Are you sure?');"
   class="btn delete">
   Delete
</a>
<a href="event-control?action=toggle&id=<%= e.getId() %>" class="btn">
    <%= "OPEN".equals(e.getStatus()) ? "Close" : "Open" %>
</a>

<a href="event-control?action=complete&id=<%= e.getId() %>" class="btn">Complete</a>
<!-- 🔥 Attendance -->
<div class="attendance-box">

<b>Attendance:</b><br>

<%
if (reservations != null) {
    for (Reservation r : reservations) {
%>

<%
dao.UserDAO userDAO = new dao.UserDAO();
model.User u = userDAO.getUserById(r.getUserId());
%>

<b><%= u.getName() %></b> (<%= u.getRole() %>)


<a href="mark-attendance?id=<%= r.getId() %>&status=Present" class="btn">Present</a>

<a href="mark-attendance?id=<%= r.getId() %>&status=Absent" class="btn delete">Absent</a>

<br>

<%
    }
}
%>

</div>

</div>

<%
    }
} else {
%>
<p>No events yet</p>
<%
}
%>

</div>

<div class="box">
<h3>Overview</h3>

<p><b>Your Role:</b> Organizer</p>

<p>
You can:
<br>- Create events
<br>- Edit your events
<br>- Delete events
<br>- Manage event status
<br>- Track attendance
</p>

<br>

<a href="create-event" class="btn">Create New Event</a>

</div>

</div>

</div>

</body>
</html>