package controller;

import dao.EventDAO;
import model.Event;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class ViewEventsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EventDAO eventDAO = new EventDAO();
        List<Event> events;

        String keyword = request.getParameter("keyword");
        String filterType = request.getParameter("filterType");

        if (keyword != null && filterType != null && !keyword.trim().isEmpty()) {
            events = eventDAO.searchEvents(keyword, filterType);
        } else if ("availability".equals(filterType)) {
            events = eventDAO.searchEvents("", filterType);
        } else {
            events = eventDAO.getAllEvents();
        }

        request.setAttribute("eventsList", events);
        request.getRequestDispatcher("view-events.jsp").forward(request, response);
    }
}