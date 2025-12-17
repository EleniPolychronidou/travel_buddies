package main;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TravelerDAO {
    private Connection getConnection() throws SQLException {
        throw new UnsupportedOperationException(""); // το μνμ της βασης
    }

private static final String INSERT_TRAVELER = "INSERT INTO traveler (userId, gender, birth_date, interests, budget) VALUES (?, ?, ?, ?, ?)";

private static final String SELECT_TRAVELER_BY_ID= "SELECT travelerId, userId, gender, birth_date, interests, budget FROM traveler WHERE traveler_id=?";

private static final String SELECT_ALL_TRAVELERS = "SELECT travelerId, userId, gender, birth_date, interests, budget FROM traveler";

private static final String UPDATE_TRAVELER = "UPDATE traveler SET userId=?, gender=?, birth_date=?, interests=?, budget WHERE traveler_id=?";

private static final String DELETE_TRAVELER = "DELETE FROM traveler WHERE traveler_id = ?";

public boolean insertTraveler (Traveler traveler) {
    boolean rowInserted = false;
    try (Connection connection = getConnection();
    PreparedStatement preparedStatement = connection.prepareStatement(INSERT_TRAVELER)) {

        preparedStatement.setInt(1, traveler.getTravelerId());
        preparedStatement.setInt(1, traveler.getUserId());
        preparedStatement.setString(1, traveler.getGender());
        preparedStatement.setDate(1, traveler.getBirthDate());
        preparedStatement.setString(1, traveler.getInterests());
        preparedStatement.setDouble(1, traveler.getBudget());

        int rowAffected = preparedStatement.executeUpdate();
        rowInserted = rowAffected>0;

    }catch (SQLException e) {
        e.printStackTrace();
    }
    return rowInserted;
}

public Traveler selecTravelerById (int  travelerId) {
    Traveler traveler = null;
    try (Connection connection = getConnection();
    PreparedStatement preparedStatement = connection.prepareStatement(SELECT_TRAVELER_BY_ID)){

        preparedStatement.setInt (1, travelerId);
        try (ResultSet rs= preparedStatement.executeQuery()) {
            if (rs.next()){
                traveler = new Traveler(
                    rs.getInt("traveler_id"),
                    rs.getInt("user_id"),
                    rs.getString("gender"),
                    rs.getDate("birth_date"),
                    rs.getString("interests"),
                    rs.getDouble("budget")
                );
            }
        }
    }catch (SQLException e) {
        e.printStackTrace();
    }
    return traveler;
}

public List <Traveler> selectAllTravelers(){
    List<Traveler> travelers = new ArrayList<>();
    try (Connection connection = getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_TRAVELERS)){;
        
        while (rs.next()) {
            Traveler traveler = new Traveler(
                    rs.getInt("traveler_id"),
                    rs.getInt("user_id"),
                    rs.getString("gender"),
                    rs.getDate("birth_date"),
                    rs.getString("interests"),
                    rs.getDouble("budget")
            );
            traveler.add(traveler);

        }
    }catch (SQLException e) {
        e.printStackTrace();
    }
    return travelers;
}

public boolean updateTraveler (Traveler traveler) {
    boolean rowUpdated = false;
    try (Connection connection = getConnection()){;
        PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_TRAVELER);

        preparedStatement.setInt(1, traveler.getUserId());
        preparedStatement.setString(2, traveler.getGender());
        preparedStatement.setDate(3, traveler.getBirthDate());
        preparedStatement.setString(4, traveler.getInterests());
        preparedStatement.setDouble(5, traveler.getBudget());
        preparedStatement.setInt(6, traveler.getTravelerId());

        rowUpdated = preparedStatement.executeQuery() >0;
} catch (SQLException e) {
    e.printStackTrace();
}
return rowUpdated;

}

public boolean deleteTraveler (int traveler_id){
    boolean rowDeleted = false;
    try (Connection connection = getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(DELETE_TRAVELER));

        preparedStatement.setInt(1, traveler_id);
        rowDeleted = preparedStatement.executeUpdate() >0;
}catch (SQLException e) {
    e.printStackTrace();
}
return rowDeleted;
}


