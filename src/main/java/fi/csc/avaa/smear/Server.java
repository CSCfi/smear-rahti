/**
 * Undertow project which connect to SMEAR-database.
 * This project is licensed under the GNU License - see the LICENSE.md file for details
 */
package fi.csc.avaa.smear;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import io.undertow.Undertow;
import io.undertow.UndertowOptions;
import io.undertow.server.HttpHandler;
import io.undertow.server.HttpServerExchange;
import io.undertow.server.handlers.BlockingHandler;
import io.undertow.server.handlers.PathHandler;
import io.undertow.server.handlers.SetHeaderHandler;
import io.undertow.server.handlers.cache.DirectBufferCache;
import io.undertow.server.handlers.encoding.EncodingHandler;
import io.undertow.server.handlers.resource.CachingResourceManager;
import io.undertow.server.handlers.resource.ClassPathResourceManager;
import io.undertow.server.handlers.resource.ResourceHandler;
import org.xnio.BufferAllocator;

import javax.sql.DataSource;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Objects;
import java.util.stream.Collectors;

import static io.undertow.util.Headers.CONTENT_LENGTH;
import static io.undertow.util.Headers.CONTENT_TYPE;
import static io.undertow.util.MimeMappings.DEFAULT;
/**
 * @author pj
 *
 */
public class Server {

	private static final String AVAA = "fi/csc/avaa";
	private static final String IMAGES = "/static/";
	private static final String BODY = "<body>";
    private static String etusivu, search;

    private static String header = "Oops!";
    private static HikariDataSource db;

    private static HttpHandler mariahandler() {
		var config = new HikariConfig();

		String dbHost = System.getenv("DB_HOST");
		String dbPort = System.getenv("DB_PORT");
		String dbName = System.getenv("DB_NAME");
		String dbUser = System.getenv("DB_USER");
		String dbPassword = System.getenv("DB_PASSWORD");
		String openshiftUrl = "jdbc:mariadb://" + dbHost + ":" + dbPort + "/" + dbName;

		config.setJdbcUrl(openshiftUrl);
		config.setUsername(dbUser);
		config.setPassword(dbPassword);
        config.setMaximumPoolSize(30); // require the production value?? dbadm said that it should be small
        config.setReadOnly(true);
        config.setLeakDetectionThreshold(10000);
        config.addDataSourceProperty("autoReconnect", true);
        config.setLeakDetectionThreshold(24000);
        config.setConnectionTimeout(60000); // db service maintenance break

        db = new HikariDataSource(config);
		return new BlockingHandler(new PathHandler().addPrefixPath("/smear/api/", apiHandler(db))
				.addPrefixPath("/smear/csv/", csvHandler(db)).addPrefixPath(IMAGES, resourceHandler(AVAA + IMAGES))
                .addExactPath("/smear/etusivu", etusivuHandler())
                .addExactPath("/smear/search.html", tokasivuHandler()));
	}

    private static HttpHandler encodingHandler = new EncodingHandler.Builder().build(null).wrap(mariahandler());

	
	/**
     * @param args NOT in use
	 */
	public static void main(String[] args) {
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
		BufferedReader br = new BufferedReader(new InputStreamReader(
				cl.getResourceAsStream(AVAA+"/header.html")));
		header = br.lines().collect(Collectors.joining("\n"));
		br=new BufferedReader(new InputStreamReader(
				cl.getResourceAsStream(AVAA+"/smear/frontpage.html")));
		String alku =	br.lines().map(l -> header(l)).collect(Collectors.joining("\n"));
        br = new BufferedReader(new InputStreamReader(
                cl.getResourceAsStream(AVAA + "/smear/search.html")));
        String toka = br.lines().map(l -> header(l)).collect(Collectors.joining("\n"));
		br=new BufferedReader(new InputStreamReader(
				cl.getResourceAsStream(AVAA+"/footer.html")));
        String footer = br.lines().collect(Collectors.joining("\n"));
        etusivu = alku + footer;
        search = toka + footer;

        Undertow
                .builder()
                .addHttpListener(8888, "0.0.0.0")
                .setIoThreads(Runtime.getRuntime().availableProcessors() * 2)
                .setServerOption(UndertowOptions.ALWAYS_SET_KEEP_ALIVE, false)
                .setHandler(encodingHandler)
                .build()
                .start();
	}

    private static String header(String l) {
	    if (l.trim().equals(BODY)) {
	        return BODY + "\n" + header;
        } else {
	        return l;
        }
    }

    private static HttpHandler etusivuHandler() {
        return exchange -> {
            //exchange.getResponseHeaders().put(CONTENT_LENGTH, etusivu.length());
            exchange.getResponseHeaders().put(CONTENT_TYPE, "text/html; charset=utf-8");
            exchange.getResponseSender().send(etusivu);
        };
        //return sivuHandler(etusivu);
	}

    private static HttpHandler tokasivuHandler() {
        return exchange -> {
            //exchange.getResponseHeaders().put(CONTENT_LENGTH, search.length());
            exchange.getResponseHeaders().put(CONTENT_TYPE, "text/html; charset=utf-8");
            exchange.getResponseSender().send(search);
        };
        //return sivuHandler(search);
    }

    //@org.jetbrains.annotations.NotNull
    private static HttpHandler apiHandler(DataSource db) {
        Objects.requireNonNull(db);
        Cache cache = new Cache();
        TreeService tree = new TreeService(db);
        var metadatatree = tree.metaDataTree();
        return exchange -> {
            var param = new ParameterParser();
            var from = param.datetime(exchange.getQueryParameters().get("from"));
            var to = param.datetime(exchange.getQueryParameters().get("to"));
            if (null == from || null == to) {
                if (param.tree(exchange.getRelativePath())) {
                    exchange.getResponseHeaders().put(CONTENT_TYPE, "application/json");
                    //exchange.getResponseHeaders().put(CONTENT_LENGTH, metadatatree.length());
                    exchange.getResponseSender().send(metadatatree);
                } else
                    virheilmoitus("Pakollinen from tai to parametri puuttui", exchange);
            } else {
                if (exchange.getRelativePath().contains("saatavuus")) {
                    var table = param.saatavuus(exchange.getRelativePath());
                    if (!table.equals("")) {
                        var saatavuus = new Saatavuus();
                        var quality = param.kl(exchange.getQueryParameters().get("quality"));
                        var variables = param.merkkijono(exchange.getQueryParameters().get("variables"));
                        exchange.getResponseHeaders().put(CONTENT_TYPE, "application/json");
                        exchange.getResponseSender().send(saatavuus.get(table, variables, from, to, quality));
                    } else { //puun oksia ei väritetä
                        exchange.getResponseHeaders().put(CONTENT_TYPE, "application/json");
                        exchange.getResponseSender().send("{}");
                    }
                } else {
                    var sql = new SQL(db);
                    var sv = param.stationvariable(exchange.getRelativePath());
                    exchange.getResponseHeaders().put(CONTENT_TYPE, "application/json");
                    if (sv.length < 2) {
                        exchange.getResponseSender().send(cache.get(sv[0], sql, from, to));
                    } else /*if (sv.length < 4)*/ {
                        var avg = param.kl(exchange.getQueryParameters().get("avg"));
                        var avgtype = param.kl(exchange.getQueryParameters().get("avgtype"));
                        var quality = param.kl(exchange.getQueryParameters().get("quality"));
                        exchange.getResponseSender().send(sql.query(sv[0], sv[1], from, to, avg, avgtype, quality));
                    }
                }
            }
        };
    }

    private static HttpHandler csvHandler(DataSource db) {
        Objects.requireNonNull(db);
        Cache cache = new Cache();
        return exchange -> {
            var param = new ParameterParser();
            var from = param.datetime(exchange.getQueryParameters().get("from"));
            var to = param.datetime(exchange.getQueryParameters().get("to"));
            if (null == from || null == to)
                virheilmoitus("CSV Pakollinen from tai to parametri puuttui", exchange);
            else {
                var sql = new SQL(db);
                var sv = exchange.getRelativePath();
                exchange.getResponseHeaders().put(CONTENT_TYPE, "text/csv");
                exchange.getResponseSender().send(cache.csv(sv, sql, from, to));

            }
        };
    }

	 private static ResourceHandler resourceHandler(String path) {
         final int  METADATA_MAX_AGE = 40000; //s or ms???
         final DirectBufferCache dataCache = new DirectBufferCache(1000, 10, 1000 * 10 * 1000, BufferAllocator.DIRECT_BYTE_BUFFER_ALLOCATOR, METADATA_MAX_AGE);
         final int metadataCacheSize = 100;
         final long maxFileSize = 10000;
		ResourceHandler rh =
		 new ResourceHandler(new CachingResourceManager(metadataCacheSize,maxFileSize, dataCache,
		         new ClassPathResourceManager(Thread.currentThread()
					.getContextClassLoader(),path), METADATA_MAX_AGE));
		//rh.setCachable()
         //MimeMapping mm = new MimeMapping("png","image/png");
         rh.setMimeMappings(DEFAULT);
         SetHeaderHandler dummy = new SetHeaderHandler(rh, "Cache-Control", "max-age=86400");
		try {
		if (null != rh.getResourceManager().getResource("images/AVAA.png")) {

			return rh;
		} else {
			System.out.println("Heyena");
			return null;
		}
		} catch (IOException e) {
			System.err.println("IOException: "+e.getLocalizedMessage());
			return null;
		}
	 }
	
	private static void virheilmoitus(String string, HttpServerExchange exchange) {
		exchange.setResponseCode(400);
		exchange.getResponseHeaders().put(CONTENT_TYPE, "text/plain");
		exchange.getResponseSender().send(string);
		
	}

    /**
     * why this is not workong
     *
     * @param sisältö
     * @return
     */
    private static HttpHandler sivuHandler(String sisältö) {
        return exchange -> {
            exchange.getResponseHeaders().put(CONTENT_LENGTH, sisältö.length());
            exchange.getResponseHeaders().put(CONTENT_TYPE, "text/html; charset=utf-8");
            exchange.getResponseSender().send(sisältö);
        };
    }

    public static HikariDataSource getDataSource() {
        return db;
    }
}
