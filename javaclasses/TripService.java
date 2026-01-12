package javaclasses;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TripService {

    public List<Trip> searchTrips(String destination, Date start, Date end) throws Exception {
        List<Trip> trips = new ArrayList<>();
        DB db = new DB(); //Θα δουλέψει στον server όπου θα ανεβάσουμε και το DB.java αρχείο
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stmt = null;
        String sql = "SELECT t.*, u.username FROM trip t JOIN agency a ON t.creator_id = a.agency_id JOIN user u ON a.user_id = u.user_id "
                + "WHERE t.destination LIKE ? "
                + "AND (? IS NULL OR t.start_date >= ?) "
                + "AND (? IS NULL OR t.end_date <= ?);";

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);

            if (destination == null || destination.trim().isEmpty()) {
                stmt.setString(1, "%");
            } else {
                stmt.setString(1, "%" + destination + "%");
            }

            if (start == null) {
                stmt.setNull(2, java.sql.Types.DATE);
                stmt.setNull(3, java.sql.Types.DATE);
            } else {
                stmt.setDate(2, start);
                stmt.setDate(3, start);
            }

            if (end == null) {
                stmt.setNull(4, java.sql.Types.DATE);
                stmt.setNull(5, java.sql.Types.DATE);
            } else {
                stmt.setDate(4, end);
                stmt.setDate(5, end);
            }

            rs = stmt.executeQuery();

            while (rs.next()) {
                trips.add(new Trip(
                        rs.getInt("trip_id"),
                        rs.getInt("creator_id"),
                        rs.getString("title"),
                        rs.getString("destination"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getString("purpose"),
                        rs.getString("description"),
                        rs.getDouble("avg_cost"),
                        rs.getString("username")));
            }

            return trips;

        } catch (Exception e) {
            throw new Exception("Error searching trips: " + e.getMessage());
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (Exception e) {
            }
            if (stmt != null) try {
                stmt.close();
            } catch (Exception e) {
            }
            if (db != null) try {
                db.close();
            } catch (Exception e) {
            }
        }
    }

    public List<Trip> searchTripsByPurpose(String purpose) throws Exception {
        List<Trip> trips = new ArrayList<>();
        DB db = new DB(); //Θα δουλέψει στον server όπου θα ανεβάσουμε και το DB.java αρχείο
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stmt = null;

        String sql = "SELECT t.*, u.username FROM trip t JOIN agency a ON t.creator_id = a.agency_id JOIN user u ON a.user_id = u.user_id  WHERE t.purpose = ?";

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setString(1, purpose);

            rs = stmt.executeQuery();

            while (rs.next()) {
                trips.add(new Trip(
                        rs.getInt("trip_id"),
                        rs.getInt("creator_id"),
                        rs.getString("title"),
                        rs.getString("destination"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getString("purpose"),
                        rs.getString("description"),
                        rs.getDouble("avg_cost"),
                        rs.getString("username")));
            }

            return trips;

        } catch (Exception e) {
            throw new Exception("Error searching trips: " + e.getMessage());
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (Exception e) {
            }
            if (stmt != null) try {
                stmt.close();
            } catch (Exception e) {
            }
            if (db != null) try {
                db.close();
            } catch (Exception e) {
            }
        }
    }

    public Trip findTripById(int tripId) throws Exception {

        DB db = new DB();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        String sql = "SELECT t.*, u.username FROM trip t JOIN agency a ON t.creator_id = a.agency_id JOIN user u ON a.user_id = u.user_id WHERE t.trip_id = ?";

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, tripId);

            rs = stmt.executeQuery();

            if (rs.next()) {
                return new Trip(
                        rs.getInt("trip_id"),
                        rs.getInt("creator_id"),
                        rs.getString("title"),
                        rs.getString("destination"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getString("purpose"),
                        rs.getString("description"),
                        rs.getDouble("avg_cost"),
                        rs.getString("username")
                );
            }

            return null;

        } catch (Exception e) {
            throw new Exception("Error finding trip: " + e.getMessage());
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (Exception e) {
            }
            if (stmt != null) try {
                stmt.close();
            } catch (Exception e) {
            }
            if (db != null) try {
                db.close();
            } catch (Exception e) {
            }
        }
    }

    public int createTrip(int creatorId, String title, String destination,
            Date startDate, Date endDate, String purpose,
            String description, double avgCost) throws Exception {

        DB db = new DB();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet keys = null;

        String sql = "INSERT INTO trip (creator_id, title, destination, start_date, end_date, purpose, description, avg_cost) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            stmt.setInt(1, creatorId);
            stmt.setString(2, title);
            stmt.setString(3, destination);

            if (startDate != null) {
                stmt.setDate(4, startDate);
            } else {
                stmt.setNull(4, Types.DATE);
            }

            if (endDate != null) {
                stmt.setDate(5, endDate);
            } else {
                stmt.setNull(5, Types.DATE);
            }

            stmt.setString(6, purpose);
            stmt.setString(7, description);
            stmt.setDouble(8, avgCost);

            int affected = stmt.executeUpdate();
            if (affected == 0) {
                throw new Exception("Trip insert failed.");
            }

            keys = stmt.getGeneratedKeys();
            if (keys.next()) {
                return keys.getInt(1);
            }
            throw new Exception("Trip insert succeeded but no ID returned.");

        } finally {
            if (keys != null) try {
                keys.close();
            } catch (Exception ignore) {
            }
            if (stmt != null) try {
                stmt.close();
            } catch (Exception ignore) {
            }
            if (db != null) try {
                db.close();
            } catch (Exception ignore) {
            }
        }
    }

    private Trip_memberService memberService = new Trip_memberService();

    public int joinTrip(int tripId, int userId) throws Exception {

        if (memberService.isMember(tripId, userId)) {
            return memberService.countMembers(tripId);
        }

        memberService.addMember(tripId, userId, false);

        return memberService.countMembers(tripId);
    }

}
