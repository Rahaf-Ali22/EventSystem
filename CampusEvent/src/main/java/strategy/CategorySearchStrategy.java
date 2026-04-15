package strategy;

public class CategorySearchStrategy implements EventSearchStrategy {

    @Override
    public String getQuery() {
        return "SELECT * FROM events WHERE LOWER(category) LIKE LOWER(?) ORDER BY event_date";
    }

    @Override
    public boolean needsKeyword() {
        return true;
    }
}