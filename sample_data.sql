INSERT INTO users (email, password, name, age, phone, height, gender)
VALUES ('john@example.com', 'pass123', 'John Doe', 25, '9876543210', 175, 'Male');

INSERT INTO exercises (name, type, `desc`)
VALUES
    ('Running', 'Running', 'Outdoor run'),
    ('Pushups', 'Strength', 'Bodyweight');

INSERT INTO workouts (user_id, start_time, end_time, date)
VALUES (1, '07:00:00', '08:00:00', CURDATE());

INSERT INTO workout_exercise (workout_id, exercise_id, sets, reps, duration, calories_burnt)
VALUES
    (1, 1, NULL, NULL, '00:30:00', 200),
    (1, 2, 3, 15, '00:15:00', 100);

INSERT INTO progress (user_id, weight_kg, log_time)
VALUES
    (1, 75, NOW() - INTERVAL 10 DAY),
    (1, 74, NOW() - INTERVAL 5 DAY),
    (1, 73, NOW());
