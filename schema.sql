CREATE DATABASE IF NOT EXISTS fitnessdb;
USE fitnessdb;

-- Users table
CREATE TABLE users (
                       id BIGINT PRIMARY KEY AUTO_INCREMENT,
                       email VARCHAR(255) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL,
                       name VARCHAR(100),
                       age SMALLINT,
                       phone VARCHAR(15),
                       height SMALLINT,
                       gender ENUM('Male', 'Female', 'Other')
);

-- Workouts table
CREATE TABLE workouts (
                          id BIGINT PRIMARY KEY AUTO_INCREMENT,
                          user_id BIGINT,
                          start_time TIME,
                          end_time TIME,
                          date DATE,
                          FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Exercises table
CREATE TABLE exercises (
                           id BIGINT PRIMARY KEY AUTO_INCREMENT,
                           name VARCHAR(100),
                           type ENUM('Running', 'Cycling', 'Strength', 'Swimming', 'Other'),
                           `desc` TEXT
);

-- Workout_Exercises mapping table (many-to-many)
CREATE TABLE workout_exercise (
                                  workout_id BIGINT,
                                  exercise_id BIGINT,
                                  sets SMALLINT,
                                  reps SMALLINT,
                                  duration TIME,
                                  calories_burnt SMALLINT,
                                  PRIMARY KEY(workout_id, exercise_id),
                                  FOREIGN KEY (workout_id) REFERENCES workouts(id),
                                  FOREIGN KEY (exercise_id) REFERENCES exercises(id)
);

-- Progress table
CREATE TABLE progress (
                          id BIGINT PRIMARY KEY AUTO_INCREMENT,
                          user_id BIGINT,
                          weight_kg SMALLINT,
                          log_time DATETIME,
                          FOREIGN KEY (user_id) REFERENCES users(id)
);
