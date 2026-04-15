package strategy;

public interface EventSearchStrategy {
    String getQuery();
    boolean needsKeyword();
}