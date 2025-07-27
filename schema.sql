CREATE DATABASE IF NOT EXISTS fitnessdb;
USE fitnessdb;

-- Users table
CREATE TABLE users (
                       user_id INT AUTO_INCREMENT PRIMARY KEY,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       password VARCHAR(100) NOT NULL,
                       name VARCHAR(100),
                       age INT
);

-- Workouts table
CREATE TABLE workouts (
                          workout_id INT AUTO_INCREMENT PRIMARY KEY,
                          user_id INT,
                          workout_date DATE NOT NULL,
                          duration_minutes INT,
                          FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Exercises table
CREATE TABLE exercises (
                           exercise_id INT AUTO_INCREMENT PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           type VARCHAR(50)
);

-- Workout_Exercises mapping table (many-to-many)
CREATE TABLE workout_exercises (
                                   workout_id INT,
                                   exercise_id INT,
                                   PRIMARY KEY (workout_id, exercise_id),
                                   FOREIGN KEY (workout_id) REFERENCES workouts(workout_id) ON DELETE CASCADE,
                                   FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id) ON DELETE CASCADE
);

-- Weight entries table
CREATE TABLE weight_entries (
                                entry_id INT AUTO_INCREMENT PRIMARY KEY,
                                user_id INT,
                                entry_date DATE NOT NULL,
                                weight_kg DECIMAL(5,2),
                                FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
