package strategy;

public class TitleSearchStrategy implements EventSearchStrategy {

    @Override
    public String getQuery() {
        return "SELECT * FROM events WHERE LOWER(title) LIKE LOWER(?) ORDER BY event_date";
    }

    @Override
    public boolean needsKeyword() {
        return true;
    }
}