public class Main {
    public static void main(String[] args) {
        FitnessDAO dao = new FitnessDAO();
        try {
            dao.getUserWorkoutsPastMonth(1);
            dao.getExercisesInWorkout(1);
            dao.getWeeklyWorkoutDuration(1);
            dao.getWeightTrend(1);
            dao.getMostFrequentExerciseType(1, "2024-07-01", "2024-07-27");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
