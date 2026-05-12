package controller;

import dao.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Event;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/organizer-dashboard")
public class OrganizerDashboardServlet extends HttpServlet {

    private EventDAO eventDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	eventDAO.updateExpiredEvents();
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");

        if (!"organizer".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("home");
            return;
        }

        int totalEvents = eventDAO.getOrganizerEventsCount(user.getId());
        int openEvents = eventDAO.getOrganizerOpenEventsCount(user.getId());
        List<Event> myEvents = eventDAO.getEventsByOrganizer(user.getId());

        request.setAttribute("totalEvents", totalEvents);
        request.setAttribute("openEvents", openEvents);
        request.setAttribute("myEvents", myEvents);

        request.getRequestDispatcher("organizer-dashboard.jsp").forward(request, response);
    }
}