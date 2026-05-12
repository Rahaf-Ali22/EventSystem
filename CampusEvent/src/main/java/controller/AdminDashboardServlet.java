package controller;

import dao.EventDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private UserDAO userDAO;
    private EventDAO eventDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        eventDAO = new EventDAO();
    }
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔒 1. Check session
        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 🔒 2. Check role (Admin only)
        if (!"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("home");
            return;
        }

        // 📊 3. Get statistics
        int totalUsers = userDAO.getUsersCount();
        int blockedUsers = userDAO.getBlockedUsersCount();
        int totalEvents = eventDAO.getTotalEventsCount();
        int openEvents = eventDAO.getOpenEventsCount();

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("blockedUsers", blockedUsers);
        request.setAttribute("totalEvents", totalEvents);
        request.setAttribute("openEvents", openEvents);

        request.setAttribute("usersList", userDAO.getRecentUsers());

        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }
}