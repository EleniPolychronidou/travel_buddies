import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDateTime;

// αυτο πρεπει να αλλαξει
public class MessageDAO {
  private Connection getConnection() throws SQLException {
    String url = //to url;
    String user = // to username;
    String password =
    return 
  }

  public List<Message> getMessagesByTrip (int tripId) {
    List <Message> messages = new ArrayList <> ();
    String query = "SELECT * FROM messages WHERE trip_id = ? ORDER BY send_date ASC";

    try (Connection connection = getConnection();
        PreparedStatement pstmt = conn.prepareStatement(query)) {
      pstmt.setInt (1, tripId);
      ResultSet rs = pstmt.executeQuery();

      while (rs.next()) {
        Message msg = new Message ();
        msg.setMessage_id(rs.getInt("message_id"));
        msg.setSender_id(rs.getInt("sender_id"));
        msg.settrip_id(rs.getInt("trip_id"));
        msg.setContent(rs.getString("content"));


        Timestamp timestamp = rs.getTimestamp ("send_date");
        if (timestamp != null) {
          msg.setSend_date(timestamp.toLocalDateTime());
        }

        message.add(msg);
      }

    }catch (SQLException e) {
      e.printStackTrace();
    }
    return.messages;

  }




        


  
