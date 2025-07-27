import java.sql.*;

public class FitnessDAO {
    // 1. Workouts in past month
    public void getUserWorkoutsPastMonth(long userId) throws SQLException {
        String query = "SELECT * FROM workouts WHERE user_id = ? AND date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH) ORDER BY date DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                System.out.println("Workout on: " + rs.getDate("date"));
            }
        }
    }

    // 2. Exercises in a workout
    public void getExercisesInWorkout(long workoutId) throws SQLException {
        String query = "SELECT e.name, e.type FROM workout_exercise we JOIN exercises e ON we.exercise_id = e.id WHERE we.workout_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setLong(1, workoutId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                System.out.println(rs.getString("name") + " - " + rs.getString("type"));
            }
        }
    }

    // 3. Weekly total workout duration
    public void getWeeklyWorkoutDuration(long userId) throws SQLException {
        String query = """
            SELECT YEARWEEK(date) AS week, 
                   SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(end_time, start_time)))) AS total_duration
            FROM workouts 
            WHERE user_id = ? AND date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
            GROUP BY YEARWEEK(date)
            """;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                System.out.println("Week: " + rs.getInt("week") + " - Duration: " + rs.getString("total_duration"));
            }
        }
    }

    // 4. Weight trend
    public void getWeightTrend(long userId) throws SQLException {
        String query = "SELECT log_time, weight_kg FROM progress WHERE user_id = ? ORDER BY log_time";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                System.out.println(rs.getTimestamp("log_time") + ": " + rs.getInt("weight_kg") + "kg");
            }
        }
    }

    // 5. Most frequent exercise type
    public void getMostFrequentExerciseType(long userId, String from, String to) throws SQLException {
        String query = """
            SELECT e.type, COUNT(*) AS cnt FROM workouts w
            JOIN workout_exercise we ON w.id = we.workout_id
            JOIN exercises e ON we.exercise_id = e.id
            WHERE w.user_id = ? AND w.date BETWEEN ? AND ?
            GROUP BY e.type ORDER BY cnt DESC LIMIT 1
            """;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setLong(1, userId);
            ps.setString(2, from);
            ps.setString(3, to);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println("Most frequent type: " + rs.getString("type"));
            }
        }
    }
}
