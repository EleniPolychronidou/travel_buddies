package main.findatrip;

import main.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TripService {

    public List<Trip> searchTrips(String destination, String start, String end) throws Exception {
        List<Trip> trips = new ArrayList<>();
        DB db = new DB();
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stmt = null;
        String sql = "SELECT * FROM trips "
                   + "WHERE destination LIKE ? "
                   + "AND (? IS NULL OR start_date >= ?) "
                   + "AND (? IS NULL OR end_date <= ?);";

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);

            if (destination == null || destination.trim().isEmpty()) {
                stmt.setString(1, "%"); 
            } else {
                stmt.setString(1, "%" + destination + "%");
            }

            if (start == null || start.trim().isEmpty()) {
                stmt.setString(2, null);
                stmt.setString(3, null);
            } else {
                stmt.setString(2, start);
                stmt.setString(3, start);
            }

            if (end == null || end.trim().isEmpty()) {
                stmt.setString(4, null);
                stmt.setString(5, null);
            } else {
                stmt.setString(4, end);
                stmt.setString(5, end);
            }

            rs = stmt.executeQuery();

            while (rs.next()) {
                trips.add(new Trip(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("destination"),
                        rs.getInt("start_date"),
                        rs.getInt("end_date"),
                        rs.getString("description"),
                        rs.getDouble("cost") 
                ));
            }

            return trips;

        } catch (Exception e) {
            throw new Exception("Error searching trips: " + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
            if (db != null) try { db.close(); } catch (Exception e) {}
        }
    }
}