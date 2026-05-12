<%@ page import="model.Event" %>
<%@ page import="model.User" %>

<%
    User organizer = (User) session.getAttribute("loggedInUser");
    if (organizer == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Event event = (Event) request.getAttribute("event");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Event</title>

<style>
body {
    margin: 0;
    font-family: Arial;
    background: linear-gradient(135deg, #f2f2f2, #64748b);
}

/* Navbar */
.navbar {
    background: #1A3263;
    color: white;
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
}

.nav-logo {
    color: #64748b;
    font-weight: bold;
    text-decoration: none;
}

.nav-link {
    color: white;
    margin-left: 15px;
    text-decoration: none;
}

/* Container */
.container {
    width: 60%;
    margin: 40px auto;
    background: white;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

/* Title */
h2 {
    text-align: center;
    color: #1A3263;
}

/* Inputs */
label {
    display: block;
    margin-top: 15px;
    font-weight: bold;
}

input, textarea {
    width: 100%;
    padding: 10px;
    margin-top: 5px;
    border-radius: 8px;
    border: 1px solid #ccc;
}

textarea {
    resize: vertical;
}

/* Buttons */
.buttons {
    margin-top: 25px;
    text-align: center;
}

.btn {
    padding: 10px 20px;
    border-radius: 8px;
    border: none;
    cursor: pointer;
    font-weight: bold;
}

.save {
    background: #6b7280;
    color: white;
}

.cancel {
    background: #1A3263;
    color: white;
    text-decoration: none;
    padding: 10px 20px;
}

</style>
</head>

<body>

<div class="navbar">
    <a href="organizer-dashboard" class="nav-logo">Campus Event</a>
    <div>
        <a href="organizer-dashboard" class="nav-link">Dashboard</a>
        <a href="logout" class="nav-link">Logout</a>
    </div>
</div>

<div class="container">

<h2>Edit Event</h2>

<form action="edit-event" method="post">

<input type="hidden" name="id" value="<%= event.getId() %>">

<label>Title</label>
<input type="text" name="title" value="<%= event.getTitle() %>" required>

<label>Description</label>
<textarea name="description" required><%= event.getDescription() %></textarea>

<label>Date</label>
<input type="date" name="eventDate" value="<%= event.getEventDate() %>" required>

<label>Location</label>
<input type="text" name="location" value="<%= event.getLocation() %>" required>

<label>Capacity</label>
<input type="number" name="capacity" value="<%= event.getCapacity() %>" required>

<div class="buttons">
    <button type="submit" class="btn save">Update</button>
    <a href="organizer-dashboard" class="cancel">Cancel</a>
</div>

</form>

</div>

</body>
</html>