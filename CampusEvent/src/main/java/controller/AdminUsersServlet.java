package controller;

import dao.EventDAO;
import dao.ReservationDAO;
import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;


public class AdminUsersServlet extends HttpServlet {

    private UserDAO userDAO;
    private ReservationDAO reservationDAO;
    private EventDAO eventDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        reservationDAO = new ReservationDAO();
        eventDAO = new EventDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (!"admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect("home");
            return;
        }

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if (action != null && idParam != null) {
            try {
                int userId = Integer.parseInt(idParam);

                if (userId == loggedInUser.getId()) {
                    response.sendRedirect("admin-users?error=self");
                    return;
                }

                User targetUser = userDAO.getUserById(userId);

                if (targetUser == null) {
                    response.sendRedirect("admin-users?error=notfound");
                    return;
                }

                if ("admin".equalsIgnoreCase(targetUser.getRole())) {
                    response.sendRedirect("admin-users?error=admin");
                    return;
                }

                boolean result = false;

                if ("block".equalsIgnoreCase(action)) {
                    result = userDAO.blockUser(userId);
                    response.sendRedirect("admin-users?" + (result ? "success=blocked" : "error=fail"));
                    return;

                } else if ("unblock".equalsIgnoreCase(action)) {
                    result = userDAO.unblockUser(userId);
                    response.sendRedirect("admin-users?" + (result ? "success=unblocked" : "error=fail"));
                    return;

                } else if ("delete".equalsIgnoreCase(action)) {

                    if (reservationDAO.userHasReservations(userId)) {
                        response.sendRedirect("admin-users?error=hasReservations");
                        return;
                    }

                    if (eventDAO.userHasCreatedEvents(userId)) {
                        response.sendRedirect("admin-users?error=hasEvents");
                        return;
                    }

                    result = userDAO.deleteUser(userId);
                    response.sendRedirect("admin-users?" + (result ? "success=deleted" : "error=fail"));
                    return;

                } else if ("makeOrganizer".equalsIgnoreCase(action)) {
                    result = userDAO.updateUserRole(userId, "organizer");
                    response.sendRedirect("admin-users?" + (result ? "success=organizer" : "error=fail"));
                    return;

                } else if ("makeStudent".equalsIgnoreCase(action)) {
                    result = userDAO.updateUserRole(userId, "student");
                    response.sendRedirect("admin-users?" + (result ? "success=student" : "error=fail"));
                    return;
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin-users?error=invalid");
                return;
            }
        }

        List<User> users = userDAO.getAllUsers();
        request.setAttribute("usersList", users);
        request.getRequestDispatcher("admin-users.jsp").forward(request, response);
    }
}