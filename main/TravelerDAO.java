package 

import com.example.model.Traveler;
import java.sql.*;
import java.util.List;


public class TravelerDAO {
    private Connection getConnection() throws SQLException {
        throw new UnsupportedOperationException("");
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
        preparedStatement.setInt(1, traveler.getGender());
        preparedStatement.setInt(1, traveler.getBirthDate());
        preparedStatement.setInt(1, traveler.getInterests());
        preparedStatement.setInt(1, traveler.getBudget());

        int rowAffected = preparedStatement.executeUpdate();
        rowInserted = rowAffected>0;

    }catch (SQLException e) {
        e.printStackTrace();
    }
    return rowInserted;
}

public 
