<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("loggedInUser");

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
    <title>Edit Profile</title>
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
            box-shadow: 0 2px 10px rgba(0,0,0,0.15);
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
            transition: 0.3s;
        }

        .nav-link:hover {
            background-color: #64748b;
            color: #1A3263;
            box-shadow: 0 0 10px #64748b,
                        0 0 20px #64748b;
        }

        .active-link {
            background-color: #64748b;
            color: #1A3263 !important;
            box-shadow: 0 0 10px #64748b,
                        0 0 20px #64748b;
        }

        .logout-link {
            border: 1px solid #64748b;
        }

        .user-badge {
            color: #64748b;
            font-weight: bold;
            margin-right: 10px;
        }

        .container {
            width: 55%;
            margin: 50px auto;
            background: white;
            border-radius: 18px;
            padding: 35px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        h2 {
            text-align: center;
            color: #1A3263;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            box-sizing: border-box;
        }

        .buttons {
            margin-top: 30px;
            text-align: center;
        }

        .btn {
            display: inline-block;
            text-decoration: none;
            background-color: #6b7280;
            color: white;
            padding: 12px 22px;
            margin: 10px;
            border-radius: 8px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            transition: 0.3s;
            font-weight: bold;
        }

        .btn:hover {
            background-color: #e63e91;
            box-shadow: 0 0 10px #64748b,
                        0 0 20px #64748b;
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

        <a href="logout" class="nav-link logout-link">Logout</a>
    </div>
</div>

<div class="container">
    <h2>Edit My Profile</h2>

    <form action="update-profile" method="post">
        <label>Full Name</label>
        <input type="text" name="name" value="<%= user.getName() %>" required>

        <label>Email</label>
        <input type="email" name="email" value="<%= user.getEmail() %>" required>

        <label>Faculty</label>
        <input type="text" name="faculty" value="<%= user.getFaculty() %>" required>

        <label>Department</label>
        <input type="text" name="department" value="<%= user.getDepartment() %>" required>

        <label>Admission Year</label>
        <input type="number" name="admissionYear" value="<%= user.getAdmissionYear() %>" required>

        <div class="buttons">
            <button type="submit" class="btn">Save Changes</button>
            <a href="profile" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>

</body>
</html>