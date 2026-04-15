<%@ page import="model.User" %>
<%
    User user = (User) request.getAttribute("userProfile");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String currentPage = request.getRequestURI();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
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
            box-shadow: 0 0 10px #f8c8dc,
                        0 0 20px #f8c8dc;
        }

        .active-link {
            background-color: #f8c8dc;
            color: #1A3263 !important;
            box-shadow: 0 0 10px #f8c8dc,
                        0 0 20px #f8c8dc;
        }

        .logout-link {
            border: 1px solid #f8c8dc;
        }

        .user-badge {
            color: #f8c8dc;
            font-weight: bold;
            margin-right: 10px;
        }

        .container {
            width: 60%;
            margin: 50px auto;
            background: white;
            border-radius: 18px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        h2 {
            text-align: center;
            color: #1A3263;
            margin-bottom: 30px;
        }

        .success-message {
            text-align: center;
            color: green;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .error-message {
            text-align: center;
            color: red;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .profile-item {
            margin-bottom: 18px;
            font-size: 18px;
            padding: 14px 12px;
            border-bottom: 1px solid #eee;
        }

        .label {
            font-weight: bold;
            color: #444;
            display: inline-block;
            width: 180px;
        }

        .buttons {
            margin-top: 30px;
            text-align: center;
        }

        .btn {
            display: inline-block;
            text-decoration: none;
            background-color: #ff4fa3;
            color: white;
            padding: 12px 22px;
            margin: 10px;
            border-radius: 8px;
            font-size: 16px;
            transition: 0.3s;
            border: none;
            font-weight: bold;
        }

        .btn:hover {
            background-color: #e63e91;
            box-shadow: 0 0 10px #f8c8dc,
                        0 0 20px #f8c8dc;
        }

        .btn-secondary {
            background-color: #1A3263;
        }

        .btn-secondary:hover {
            background-color: #16202c;
        }

        @media (max-width: 900px) {
            .container {
                width: 90%;
            }

            .nav-right {
                gap: 10px;
                justify-content: flex-end;
            }

            .label {
                width: 140px;
            }
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="nav-left">
        <a href="index.jsp" class="nav-logo">Campus Event System</a>
    </div>

    <div class="nav-right">
       

        <a href="home" class="nav-link <%= currentPage.contains("index.jsp") ? "active-link" : "" %>">Home</a>

        <a href="view-events" class="nav-link <%= currentPage.contains("view-events") ? "active-link" : "" %>">Events</a>

        <a href="my-reservations" class="nav-link <%= currentPage.contains("my-reservations") ? "active-link" : "" %>">My Reservations</a>

        <a href="profile" class="nav-link active-link">My Profile</a>

            </div>
</div>

<div class="container">
    <h2>My Profile</h2>

    <% if(request.getParameter("msg") != null) { %>
        <p class="success-message">Profile updated successfully ✅</p>
    <% } %>

    <% if(request.getParameter("error") != null) { %>
        <p class="error-message">Failed to update profile.</p>
    <% } %>

    <div class="profile-item">
        <span class="label">Full Name:</span>
        <%= user.getName() %>
    </div>

    <div class="profile-item">
        <span class="label">Email:</span>
        <%= user.getEmail() %>
    </div>

    <div class="profile-item">
        <span class="label">Faculty:</span>
        <%= user.getFaculty() %>
    </div>

    <div class="profile-item">
        <span class="label">Department:</span>
        <%= user.getDepartment() %>
    </div>

    <div class="profile-item">
        <span class="label">Admission Year:</span>
        <%= user.getAdmissionYear() %>
    </div>

    <div class="profile-item">
        <span class="label">Role:</span>
        <%= user.getRole() %>
    </div>

    <div class="buttons">
        <a href="edit-profile.jsp" class="btn">Edit Profile</a>
       
    </div>
</div>

</body>
</html>