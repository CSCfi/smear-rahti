package fi.csc.avaa.smear;


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Junnun koodia Liferay SmartSMEARin DB-luokasta.
 */
public class Saatavuus {

    public static final int QUALITYCHECKED = 2;
    private static final Logger log = LogManager.getLogger(Saatavuus.class);

    private Connection conn = null; // see the open method

    private int getTotalValue(String query, long startDate, long endDate) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            rs = getAvailabilityQueryResults(query, startDate, endDate, ps);
            if (rs != null) {
                rs.next();
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            ;
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            ;
        }
        return -1;
    }

    private Map<String, Double> getVariableAvailabilityValues(String query, long startDate, long endDate, List<String> variableNames, boolean considerQuality) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        Map<String, Double> varAvailabilities = new HashMap<>();
        HashMap<String, Integer> varExistCounts = new HashMap<>();
        variableNames.stream().forEach(varName -> {
            varExistCounts.put(varName, 0);
            varAvailabilities.put(varName, 0.0d);
        });
        try {
            rs = getAvailabilityQueryResults(query, startDate, endDate, ps);
            if (rs != null) {
                ResultSetMetaData rsmd = rs.getMetaData();
                int totCount = 0;
                if (considerQuality) {
                    while (rs.next()) {
                        totCount++;
                        int queryIdx = 1;
                        for (int varIdx = 0; varIdx < variableNames.size(); varIdx++) {
                            try {
                                String varName = variableNames.get(varIdx);
                                String emepColName = varName + "_EMEP";
                                while (!emepColName.equals(rsmd.getColumnName(queryIdx))) {
                                    queryIdx++;
                                }
                                if (rs.getInt(queryIdx) == 2) {
                                    varExistCounts.put(varName, (varExistCounts.get(varName) + 1));
                                }
                                queryIdx++;
                            } catch (Exception e) {
                                continue;
                            }
                        }
                    }
                } else {
                    while (rs.next()) {
                        totCount++;
                        for (int i = 0; i < variableNames.size(); i++) {
                            try {
                                String varName = variableNames.get(i);

                                if (!rsmd.getColumnTypeName(i + 1).equalsIgnoreCase("CHAR")) {
                                    rs.getFloat(varName);
                                }

                                if (!rs.wasNull()) {
                                    varExistCounts.put(varName, (varExistCounts.get(varName) + 1));
                                }
                            } catch (Exception e) {
                                continue;
                            }
                        }
                    }
                }

                final int temp = totCount;
                varExistCounts.forEach((k, v) -> {
                    varAvailabilities.put(k, temp == 0 ? 0.0d : (double) varExistCounts.get(k) / temp);
                });
            }
            this.conn.close();
            this.conn = null;
            return varAvailabilities;
        } catch (Exception e) {
            log.error(e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return varAvailabilities;
    }

    /**
     * Get the amount of rows in the given time period
     *
     * @param tableName
     * @param startDate
     * @param endDate
     * @return total number of rows
     * @author jmlehtin
     */
    public int getTotalRowsInPeriod(String tableName, long startDate, long endDate) {
        String query = "SELECT COUNT(samptime) AS total FROM " + tableName + " WHERE samptime >= ? AND samptime <= ?";
        return getTotalValue(query, startDate, endDate);
    }

    /**
     * Get the amount of non null variable rows in the given time period
     *
     * @param tableName
     * @param variableName
     * @param startDate
     * @param endDate
     * @return total number of non null variable rows
     * @author jmlehtin
     */
    public int getNonNullVariableRowAmountInPeriod(String tableName, String variableName, long startDate, long endDate) {
        String query = "SELECT COUNT(samptime) AS total FROM " + tableName + " WHERE " + variableName + " IS NOT NULL AND samptime >= ? AND samptime <= ?";
        return getTotalValue(query, startDate, endDate);
    }

    public int getNonNullAndQualityVariableRowAmountInPeriod(String tableName, String variableName, long startDate, long endDate) {
        String query = "SELECT COUNT(samptime) AS total FROM " + tableName + " WHERE " + variableName + " IS NOT NULL AND " + variableName + "_EMEP = 2 AND samptime >= ? AND samptime <= ?";
        return getTotalValue(query, startDate, endDate);
    }

    /**
     * Get Map of
     *
     * @param tableGroupedVariables
     * @param startDate
     * @param endDate
     * @param considerQuality
     * @return
     */
    public Map<String, Double> getVariableAvailabilitiesInPeriod(Map<String, List<String>> tableGroupedVariables, long startDate, long endDate, boolean considerQuality) {
        Map<String, Double> varExistCounts = new HashMap<>();
        for (Map.Entry<String, List<String>> tableAndVariables : tableGroupedVariables.entrySet()) {
            String table = tableAndVariables.getKey();
            List<String> varNames = tableAndVariables.getValue();

            String query;
            if (considerQuality) {
                query = "SELECT ".concat(varNames.stream().map(varName -> varName + "_EMEP").collect(Collectors.joining(", "))).concat(" FROM " + table + " WHERE samptime >= ? AND samptime <= ?");
            } else {
                query = "SELECT ".concat(varNames.stream().collect(Collectors.joining(", "))).concat(" FROM " + table + " WHERE samptime >= ? AND samptime <= ?");
            }
            long startTime = System.nanoTime();
            varExistCounts.putAll(getVariableAvailabilityValues(query, startDate, endDate, varNames, considerQuality));
            long endTime = System.nanoTime();
        }
        return varExistCounts;
    }

    private ResultSet getAvailabilityQueryResults(String query, long startDate, long endDate, PreparedStatement ps) {
        ResultSet rs;
        open();
        String validQuery = getValidAvailabilityQuery(query, startDate, endDate);
        try {
            ps = this.conn.prepareStatement(validQuery, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
            ps.setTimestamp(1, new Timestamp(startDate));
            ps.setTimestamp(2, new Timestamp(endDate));
            ps.setFetchSize(Integer.MIN_VALUE);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            return null;
        }
        return rs;
    }

    /**
     * Since
     *
     * @param query
     * @param startDate
     * @param endDate
     * @return
     */
    private String getValidAvailabilityQuery(String query, long startDate, long endDate) {
        boolean success = false;
        ResultSet rs = null;
        PreparedStatement ps = null;
        String retVal = query;
        int counter = 0;
        while (!success && counter < 100) {
            counter++;
            try {
                ps = this.conn.prepareStatement(retVal + " LIMIT 1", ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
                ps.setTimestamp(1, new Timestamp(startDate));
                ps.setTimestamp(2, new Timestamp(endDate));
                ps.setFetchSize(10);
                rs = ps.executeQuery();
                success = true;
            } catch (SQLException ex) {
                retVal = improveQuery(ex, retVal);
                if (retVal == null) {
                    return null;
                }
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                try {
                    if (ps != null) {
                        ps.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return retVal;
    }

    private String improveQuery(SQLException ex, String query) {
        String retVal = query;
        int beg = ex.getMessage().indexOf('\'') + 1;
        int end = ex.getMessage().indexOf('\'', ex.getMessage().indexOf('\'') + 1);
        String missingCol = ex.getMessage().substring(beg, end);
        if (!retVal.contains(missingCol)) {
            return null;
        }
        if (retVal.contains(", " + missingCol)) {
            retVal = retVal.replace(String.valueOf(", " + missingCol), "");
        } else if (query.contains(missingCol + ", ")) {
            retVal = retVal.replace(String.valueOf(missingCol + ", "), "");
        } else {
            return null;
        }
        return retVal;
    }

    public void open() {
        try {
            if (isClosed()) {
                this.conn = Server.getDataSource().getConnection();
                this.conn.setAutoCommit(false);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean isClosed() {
        try {
            if (this.conn != null) {
                return this.conn.isClosed();
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return true;
    }

    /**
     * Main, sisääntulopiste, jota kutsutaan ulkopuolelta. Uusi koodi, joka käyttää vanhaa
     *
     * @param table        String database table
     * @param variableList String comma separated list of the database columns
     * @param from         Timestamp start of the period
     * @param to           Timestamp end of the period
     * @param quality      int 0 quality no matter or 2 quality matter
     * @return String JSON object with colors of the each column=variable
     */
    public String get(String table, String variableList, Timestamp from, Timestamp to, int quality) {
        Map<String, List<String>> dummy = new HashMap<>();
        dummy.put(table, Arrays.stream(variableList.split(",")).collect(Collectors.toList()));
        Boolean considerQuality = (QUALITYCHECKED == quality);
        Map<String, Double> saatavuus = getVariableAvailabilitiesInPeriod(dummy, from.getTime(), to.getTime(), considerQuality);
        StringBuilder sb = new StringBuilder("{");
        saatavuus.forEach((k, v) -> käsittele(k, v, sb));
        sb.deleteCharAt(sb.length() - 2); //,
        sb.append("}");
        return sb.toString();
    }

    /**
     * Tuottaa JSON rivin
     *
     * @param muuttuja String variable
     * @param v double  proportion of available values 0-1
     * @param sb StringBuilder JSON string
     */
    void käsittele(String muuttuja, double v, StringBuilder sb) {
        sb.append(CSV.LM);
        sb.append(muuttuja);
        sb.append(CSV.LM);
        sb.append(":");
        sb.append(väritä(v));
        sb.append(TreeService.NL);
    }

    /**
     * Varsinainen toiminnallisuus. Määrittää muuttujan värin saatavuuden (kuinka suuri osuus on muuta kuin NULL tietokannnassa)
     *
     * @param arvo double proportion of available values
     * @return String CSS color style of the variable text: color "red" "yellow" "green" or "gray"
     */
    String väritä(double arvo) {
        if (arvo == 0.0d) {
            return lainaa("red");
        } else if (arvo > 0.0d && arvo < 0.5d) {
            return lainaa("#CCCC00"); //yellow
        } else if (arvo >= 0.5d && arvo <= 1.0d) {
            return lainaa("green");
        } else {
            return lainaa("gray");
        }
    }

    String lainaa(String s) {
        return CSV.LM + s + CSV.LM + ",";
    }
}
