package dao;

import model.Event;
import model.Reservation;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    // ✅ Create Reservation
    public boolean createReservation(int userId, int eventId) {
        String insertSql = "INSERT INTO reservations (user_id, event_id) VALUES (?, ?)";
        String updateSeatsSql = "UPDATE events SET seats_remaining = seats_remaining - 1 WHERE id = ? AND seats_remaining > 0";

        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // decrease seats
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSeatsSql)) {
                updateStmt.setInt(1, eventId);
                int rowsUpdated = updateStmt.executeUpdate();

                if (rowsUpdated == 0) {
                    conn.rollback();
                    return false;
                }
            }

            // insert reservation
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, eventId);
                insertStmt.executeUpdate();
            }

            conn.commit();
            return true;

        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;

        } finally {
            try {
                if (conn != null) conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // ✅ Prevent duplicate reservation
    public boolean isAlreadyReserved(int userId, int eventId) {
        String sql = "SELECT * FROM reservations WHERE user_id = ? AND event_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, eventId);

            ResultSet rs = stmt.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Cancel reservation
    public boolean cancelReservation(int userId, int eventId) {
        String deleteSql = "DELETE FROM reservations WHERE user_id = ? AND event_id = ?";
        String updateSeatsSql = "UPDATE events SET seats_remaining = seats_remaining + 1 WHERE id = ?";

        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // delete
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.setInt(1, userId);
                deleteStmt.setInt(2, eventId);

                int rowsDeleted = deleteStmt.executeUpdate();

                if (rowsDeleted == 0) {
                    conn.rollback();
                    return false;
                }
            }

            // increase seats
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSeatsSql)) {
                updateStmt.setInt(1, eventId);
                updateStmt.executeUpdate();
            }

            conn.commit();
            return true;

        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;

        } finally {
            try {
                if (conn != null) conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // ✅ Check event reservations
    public boolean eventHasReservations(int eventId) {
        String sql = "SELECT COUNT(*) FROM reservations WHERE event_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();

            return rs.next() && rs.getInt(1) > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ✅ Check user reservations
    public boolean userHasReservations(int userId) {
        String sql = "SELECT COUNT(*) FROM reservations WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            return rs.next() && rs.getInt(1) > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ✅ Attendance
    public boolean markAttendance(int reservationId, String status) {
        String sql = "UPDATE reservations SET attendance=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, reservationId);

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ✅ Get events reserved by user
    public List<Event> getUserReservations(int userId) {
        List<Event> reservedEvents = new ArrayList<>();

        String sql = "SELECT e.* FROM reservations r " +
                     "JOIN events e ON r.event_id = e.id " +
                     "WHERE r.user_id = ? ORDER BY r.id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

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
                event.setStatus(rs.getString("status"));
                event.setSeatsRemaining(rs.getInt("seats_remaining"));
                event.setDepartmentClub(rs.getString("department_club"));
                event.setCategory(rs.getString("category"));
                event.setEventType(rs.getString("event_type"));

                reservedEvents.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return reservedEvents;
    }

    // ✅ Count user reservations
    public int getUserReservationsCount(int userId) {
        String sql = "SELECT COUNT(*) FROM reservations WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            return rs.next() ? rs.getInt(1) : 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // 🔥 IMPORTANT: Get reservations by event (for organizer)
    public List<Reservation> getReservationsByEvent(int eventId) {

        List<Reservation> list = new ArrayList<>();

        String sql = "SELECT * FROM reservations WHERE event_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                Reservation r = new Reservation();

                r.setId(rs.getInt("id"));
                r.setUserId(rs.getInt("user_id"));
                r.setEventId(rs.getInt("event_id"));
                r.setStatus(rs.getString("status"));

                try {
                    r.setAttendance(rs.getString("attendance"));
                } catch (Exception ignored) {}

                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}