package main.traveler;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TravelerDAO {

        DB db = new DB(); //Θα δουλέψει στον server όπου θα ανεβάσουμε και το DB.java αρχείο
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stmt = null;                                             

    private static final String INSERT_TRAVELER = "INSERT INTO traveler (userId, gender, birth_date, interests) VALUES (?, ?, ?, ?)";
    private static final String SELECT_TRAVELER_BY_ID = "SELECT traveler_id, userId, gender, birth_date, interests FROM traveler WHERE traveler_id = ?";
    private static final String SELECT_ALL_TRAVELERS = "SELECT traveler_id, userId, gender, birth_date, interests FROM traveler";
    private static final String UPDATE_TRAVELER = "UPDATE traveler SET userId=?, gender=?, birth_date=?, interests=? WHERE traveler_id = ?";
    private static final String DELETE_TRAVELER = "DELETE FROM traveler WHERE traveler_id = ?";

    public boolean insertTraveler(Traveler traveler) {
        boolean rowInserted = false;
        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_TRAVELER)) {

            preparedStatement.setInt(1, traveler.getUserId());
            preparedStatement.setString(2, traveler.getGender());
            preparedStatement.setDate(3, traveler.getBirthDate());
            preparedStatement.setString(4, traveler.getInterests());

            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    }

    public Traveler selectTravelerById(int travelerId) {
        Traveler traveler = null;
        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_TRAVELER_BY_ID)) {

            preparedStatement.setInt(1, travelerId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    traveler = new Traveler(
                            rs.getInt("traveler_id"),
                            rs.getInt("userId"),
                            rs.getString("gender"),
                            rs.getDate("birth_date"),
                            rs.getString("interests"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return traveler;
    }

    public List<Traveler> selectAllTravelers() {
        List<Traveler> travelers = new ArrayList<>();
        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_TRAVELERS);
                ResultSet rs = preparedStatement.executeQuery()) {

            while (rs.next()) {
                Traveler traveler = new Traveler(
                        rs.getInt("traveler_id"),
                        rs.getInt("userId"),
                        rs.getString("gender"),
                        rs.getDate("birth_date"),
                        rs.getString("interests"));
                travelers.add(traveler);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return travelers;
    }

    public boolean updateTraveler(Traveler traveler) {
        boolean rowUpdated = false;
        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_TRAVELER)) {

            preparedStatement.setInt(1, traveler.getUserId());
            preparedStatement.setString(2, traveler.getGender());
            preparedStatement.setDate(3, traveler.getBirthDate());
            preparedStatement.setString(4, traveler.getInterests());
            preparedStatement.setInt(5, traveler.getTravelerId());

            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    public boolean deleteTraveler(int travelerId) {
        boolean rowDeleted = false;
        try (Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(DELETE_TRAVELER)) {

            preparedStatement.setInt(1, travelerId);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }
}
