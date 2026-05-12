package controller;

import dao.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

@WebServlet("/event-control")
public class EventControlServlet extends HttpServlet {

    private EventDAO eventDAO;

    @Override
    public void init() throws ServletException {
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

        User organizer = (User) session.getAttribute("loggedInUser");

        if (!"organizer".equalsIgnoreCase(organizer.getRole())) {
            response.sendRedirect("home");
            return;
        }

        String action = request.getParameter("action");
        int eventId = Integer.parseInt(request.getParameter("id"));

        boolean result = false;

        if ("toggle".equalsIgnoreCase(action)) {
            result = eventDAO.toggleEventStatus(eventId);

        } else if ("complete".equalsIgnoreCase(action)) {
            result = eventDAO.completeEvent(eventId);
        }

        if (result) {
            response.sendRedirect("organizer-dashboard?success=updated");
        } else {
            response.sendRedirect("organizer-dashboard?error=fail");
        }
    }
}