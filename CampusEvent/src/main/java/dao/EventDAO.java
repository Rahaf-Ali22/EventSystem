package dao;

import model.Event;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    public List<Event> getAllEvents() {

        List<Event> events = new ArrayList<>();

        String sql = "SELECT * FROM events ORDER BY event_date";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Event event = new Event();

                event.setId(rs.getInt("id"));
                event.setTitle(rs.getString("title"));
                event.setDescription(rs.getString("description"));
                event.setEventDate(rs.getDate("event_date"));
                event.setLocation(rs.getString("location"));
                event.setCapacity(rs.getInt("capacity"));
                event.setCreatedBy(rs.getInt("created_by"));
                event.setCreatedAt(rs.getTimestamp("created_at"));

                events.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return events;
    }
}