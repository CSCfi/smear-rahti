package fi.csc.avaa.smear;

import java.sql.Timestamp;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

/**
 * Yrittää suorittaa rinnakkain SQL-luokan kyselyitä
 */
public class QueryExecutor {
    private final ExecutorService executor = Executors.newFixedThreadPool(2);
    SQL sql;
    Timestamp from;
    Timestamp to;

    public QueryExecutor(SQL sql, Timestamp from, Timestamp to) {
        this.sql = sql;
        this.from = from;
        this.to = to;
    }

    Future<String> aerosols() {
        Callable<String> task = new Callable<String>() {
            public String call() {
                return sql.aerosolsize(from, to);
            }
        };
        return executor.submit(task);
    }

    /**
     * executor.shutdown()
     */
    public void close() {
        executor.shutdown();
    }
}
