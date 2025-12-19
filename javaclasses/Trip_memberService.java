package javaclasses;
import java.sql.*;

public class Trip_memberService {
    public boolean isMember(int tripId, int userId) throws Exception {

        DB db = new DB();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        String sql = "SELECT 1 FROM trip_members WHERE trip_id = ? AND user_id = ?";

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, tripId);
            stmt.setInt(2, userId);

            rs = stmt.executeQuery();
            return rs.next();

        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (db != null) db.close();
        }
    }


    public void addMember(int tripId, int userId, boolean isOrganiser) throws Exception {

        DB db = new DB();
        Connection con = null;
        PreparedStatement stmt = null;

        String sql =
            "INSERT INTO trip_members (trip_id, user_id, isOrganiser) VALUES (?, ?, ?)";

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, tripId);
            stmt.setInt(2, userId);
            stmt.setBoolean(3, isOrganiser);

            stmt.executeUpdate();

        } finally {
            if (stmt != null) stmt.close();
            if (db != null) db.close();
        }
    }
    public int countMembers(int tripId) throws Exception {

        DB db = new DB();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        String sql = "SELECT COUNT(*) FROM trip_members WHERE trip_id = ?";

        try {
            con = db.getConnection();
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, tripId);

            rs = stmt.executeQuery();
            rs.next();
            return rs.getInt(1);

        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (db != null) db.close();
        }
    }

    
}
