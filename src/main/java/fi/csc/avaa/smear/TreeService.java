package fi.csc.avaa.smear;

import com.google.gson.Gson;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Tietokantakyselee JSON puun, jonka lehtiä ovat muuttujat
 *
 * Tämä EI toiminut javax.json:lla
 */
public class TreeService {

    static final String CHILDREN = "children";
    static final String NAME = "name";
    static final String ID = "id";
    static final String NL = "\n";
    static int[] tablestation = new int[Cache.SIZE]; // there is amount for new tables
    static String[] tablenames = new String[Cache.SIZE]; // there is amount for new tables
    String tree = "You should not see this tree"; // will be replased by real content!!!
    DataSource db;
    ArrayList<Category>[] stationchildren;
    Tree stations = new Tree();

    public TreeService(DataSource db) {
        this.db = db;
        try {
            var connection = db.getConnection();
            var statement = connection.prepareStatement("SELECT stationID, name FROM station");
            var resultSet = statement.executeQuery();
            resultSet.afterLast();
            stationchildren = new ArrayList[resultSet.getRow()];
            resultSet.beforeFirst();
            int i = 0;
            while (resultSet.next()) {
                ArrayList<Category> ja = new ArrayList<Category>();
                stations.add(new Category(resultSet.getString(2), resultSet.getInt(1), ja));
                stationchildren[i++] = ja;
            }
            statement.close();
            statement = connection.prepareStatement("SELECT  tableID, stationID, name FROM TableMetadata");
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                int sid = resultSet.getInt(2);
                if (!resultSet.wasNull() && (0 != sid)) {
                    tablestation[resultSet.getInt(1)] = sid;
                    tablenames[resultSet.getInt(1)] = resultSet.getString(3);
                }
            }
            statement.close();
            statement =
                    connection.prepareStatement(
                            "SELECT * FROM  VariableMetadata ORDER BY tableID, category, ui_sort_order");
            resultSet = statement.executeQuery();
            ArrayList<Leaf> jabc = null;
            String excategory = "";
            i = -1;
            int exsid = -1;
            while (resultSet.next()) {
                int sid = tablestation[resultSet.getInt(2)] - 1; //tableId
                String tablename = tablenames[resultSet.getInt(2)];
                if (!resultSet.wasNull()) {
                    String category = resultSet.getString(13);
                    if (!resultSet.wasNull())
                        if (category.equals(excategory) && (sid == exsid)) {
                            addNode(sid, jabc, category, resultSet, tablename);
                        } else { //new category
                            jabc = new ArrayList<Leaf>();
                            try {
                                stationchildren[sid].add(new Category(category, i--, jabc));

                            } catch (NullPointerException e) {
                                System.err.println("Sid: " + sid);
                                System.exit(3);
                            }
                            addNode(sid, jabc, category, resultSet, tablename);
                            excategory = category;
                            exsid = sid;
                        }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        /*for (int i = 0; i < stationchildren.length; i++) {
            if (null != stationchildren[i])
                stationchildren[i].build();
        }*/
        Gson gson = new Gson();
        this.tree = gson.toJson(stations.getTree()).toString();
    }

    public String metaDataTree() {
        return this.tree;
    }

    private void addNode(int sid, ArrayList<Leaf> jabc, String category, ResultSet rs, String table) {
        if (null == table || table.isEmpty()) {
            System.err.println("No table:" + sid);
        }
        try {
            jabc.add(new Leaf(rs.getString(7), //title
                    100 + rs.getInt(1), //variableID
                    rs.getString(4),
                    rs.getString(3),
                    rs.getString(6), //Unit
                    rs.getString(8),
                    table,
                    rs.getString(9)) //new Leaf

            );
            //System.out.println("lehti: "+rs.getString(7));
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NullPointerException e) {
            System.err.println("Sid: " + sid + e.getMessage() + " category: " + category);
        }
    }

}

