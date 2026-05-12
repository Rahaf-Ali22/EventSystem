<%@ page import="java.util.List" %>
<%@ page import="model.Department" %>
<%@ page import="model.Category" %>
<%@ page import="model.User" %>
<%
    User organizer = (User) session.getAttribute("loggedInUser");

    if (organizer == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Department> departments = (List<Department>) request.getAttribute("departmentsList");
    List<Category> categories = (List<Category>) request.getAttribute("categoriesList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Event</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f2f2f2, #64748b);
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
            color: #64748b;
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
        }

        .nav-link:hover, .active-link {
            background-color: #64748b;
            color: #1A3263 !important;
        }

        .logout-link {
            border: 1px solid #64748b;
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
            background: #6b7280;
            color: white;
        }

        .btn-back {
            background: #1A3263;
            color: white;
        }
    </style>
</head>
<body>

<jsp:include page="organizer-navbar.jsp" />


<div class="container">
    <h1>Create Event</h1>

    <%
        String error = request.getParameter("error");
        if ("fail".equals(error)) {
    %>
        <p class="message">Failed to create event.</p>
    <%
        } else if ("invalid".equals(error)) {
    %>
        <p class="message">Invalid event data.</p>
    <%
        }
    %>

   <form action="create-event" method="post" enctype="multipart/form-data">
        <label>Title</label>
        <input type="text" name="title" required>

        <label>Description</label>
        <textarea name="description" required></textarea>

        <label>Event Date</label>
        <input type="date" name="eventDate" required>

        <label>Location</label>
        <input type="text" name="location" required>

        <label>Capacity</label>
        <input type="number" name="capacity" min="1" required>

        <label>Department / Club</label>
        <select name="departmentClub" required>
            <%
                if (departments != null && !departments.isEmpty()) {
                    for (Department department : departments) {
            %>
                <option value="<%= department.getName() %>"><%= department.getName() %></option>
            <%
                    }
                }
            %>
            
        </select>

        <label>Category</label>
        <select name="category" required>
            <%
                if (categories != null && !categories.isEmpty()) {
                    for (Category category : categories) {
            %>
                <option value="<%= category.getName() %>"><%= category.getName() %></option>
            <%
                    }
                }
            %>
        </select>

        <label>Event Type</label>
        <select name="eventType" required>
            <option value="Workshop">Workshop</option>
            <option value="Seminar">Seminar</option>
            <option value="Club Social Event">Club Social Event</option>
            <option value="Sports Activity">Sports Activity</option>
        </select>
<label>Event Image:</label>
<input type="file" name="image" accept="image/*"><br>

        <div class="buttons">
            <button type="submit" class="btn btn-save">Create Event</button>
            <a href="organizer-dashboard" class="btn btn-back">Back</a>
        </div>
    </form>
</div>

</body>
</html>