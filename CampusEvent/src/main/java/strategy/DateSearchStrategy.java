package strategy;

public class DateSearchStrategy implements EventSearchStrategy {

    @Override
    public String getQuery() {
        return "SELECT * FROM events WHERE CAST(event_date AS TEXT) LIKE ? ORDER BY event_date";
    }

    @Override
    public boolean needsKeyword() {
        return true;
    }
}