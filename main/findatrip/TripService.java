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
        String sql = "SELECT * FROM trips "
                + "WHERE (? IS NULL OR destination LIKE ?) "
                + "AND (? IS NULL OR start_date >= ?) "
                + "AND (? IS NULL OR end_date <= ?);";

        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setString(1, destination);
            stmt.setString(2, "%" + (destination != null ? destination : "") + "%");
            stmt.setString(3, start);
            stmt.setString(4, start);
            stmt.setString(5, end);
            stmt.setString(6, end);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                trips.add(new Trip(
                        rs.getInt("id"),
                        rs.getString("destination"),
                        rs.getString("start_date"),
                        rs.getString("end_date"),
                        rs.getString("description")
                ));
            }

            rs.close();
            stmt.close();
            db.close();
            return trips;

        } catch (Exception e) {
            throw e;
        } finally {
            try {
                db.close();
            } catch (Exception e) {
            }
        }
    }
}
