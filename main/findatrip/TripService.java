package main.findatrip;

import main.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TripService {

    public List<Trip> searchTrips(String destination, String start, String end) throws Exception {
        List<Trip> trips = new ArrayList<>();
        DB db = new DB(); //Θα δουλέψει στον server όπου θα ανεβάσουμε και το DB.java αρχείο
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
                        rs.getDate("start_date").toString(),
                        rs.getDate("end_date").toString(),
                        rs.getString("description"),
                        rs.getDouble("cost"), 
                        rs.getInt("participants"),
                        rs.getString("created_by"),
                        rs.getString("img")
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
    public Trip findTripById(int tripId) throws Exception {

    DB db = new DB();
    Connection con = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String sql = "SELECT * FROM trips WHERE id = ?";

    try {
        con = db.getConnection();
        stmt = con.prepareStatement(sql);
        stmt.setInt(1, tripId);

        rs = stmt.executeQuery();

        if (rs.next()) {
            return new Trip(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("destination"),
                rs.getDate("start_date").toString(),
                rs.getDate("end_date").toString(),
                rs.getString("description"),
                rs.getDouble("cost"),
                rs.getInt("participants"),
                rs.getString("created_by"),
                rs.getString("img")
            );
        }

        return null;

    } catch (Exception e) {
        throw new Exception("Error finding trip: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        if (db != null) try { db.close(); } catch (Exception e) {}
    }
}
public Trip joinTrip(int tripId, int userId) throws Exception {

        DB db = new DB();
        Connection con = null;
        PreparedStatement stmt = null;

        String sql = "UPDATE trips SET participants = participants + 1 WHERE id = ?";

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, tripId);

            int rows = stmt.executeUpdate();

            if (rows == 0) {
                return null;
            }

            return findTripById(tripId);

        } finally {
            if (stmt != null) stmt.close();
            if (db != null) db.close();
        }
    }



}