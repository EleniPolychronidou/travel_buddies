package javaclasses;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDateTime;

public class MessageDao {

    private Connection getConnection() throws Exception {
        DB db = new DB();
        return db.getConnection();
    }

    public List<Message> getMessagesByTrip(int tripId) throws Exception {
        List<Message> messages = new ArrayList<>();

        String sql = "SELECT message_id, sender_id, trip_id, content, send_date " +
                     "FROM messages " +
                     "WHERE trip_id = ? " +
                     "ORDER BY send_date ASC";

        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, tripId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Message msg = new Message();
                    msg.setMessage_id(rs.getInt("message_id"));
                    msg.setSender_id(rs.getInt("sender_id"));
                    msg.setTrip_id(rs.getInt("trip_id"));
                    msg.setContent(rs.getString("content"));

                    Timestamp ts = rs.getTimestamp("send_date");
                    if (ts != null) {
                        msg.setSend_date(ts.toLocalDateTime());
                    }

                    messages.add(msg);
                }
            }
        }

        return messages;
    }

    public void sendMessage(int tripId, int senderId, String content) throws Exception {
       
        if (content == null || content.trim().isEmpty()) {
            throw new IllegalArgumentException("Message content cannot be empty");
        }

        String sql = "INSERT INTO messages (trip_id, sender_id, content, send_date) " +
                     "VALUES (?, ?, ?, ?)";

        try (Connection con = getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, tripId);
            pstmt.setInt(2, senderId);
            pstmt.setString(3, content.trim()); // Αφαίρεση κενών
            pstmt.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));

            int rows = pstmt.executeUpdate();
            
            // Logging για debugging
            System.out.println("Message inserted. Rows affected: " + rows);
        }
    }
}