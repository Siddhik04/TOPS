create database saas_app;
USE saas_app;

CREATE TABLE users (
	user_id INT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    signup_date DATE NOT NULL
);
    
CREATE TABLE logins (
    user_id INT,
    login_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE feature_usage (
    user_id INT,
    feature_name VARCHAR(100) NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO users (user_id, email, signup_date) VALUES
(1, 'alice@example.com', '2026-02-01'),
(2, 'bob@example.com', '2026-02-02'),
(3, 'carol@example.com', '2026-02-03'),
(4, 'dave@example.com', '2026-02-04'),
(5, 'eve@example.com', '2026-02-05'),
(6, 'frank@example.com', '2026-02-06'),
(7, 'grace@example.com', '2026-02-07'),
(8, 'heidi@example.com', '2026-02-08'),
(9, 'ivan@example.com', '2026-02-09'),
(10, 'judy@example.com', '2026-02-10');

INSERT INTO logins (user_id, login_date) VALUES
(1, '2026-02-01'),
(1, '2026-02-02'),
(2, '2026-02-03'),
(3, '2026-02-04'),
(4, '2026-02-05'),
(5, '2026-02-06'),
(6, '2026-02-07'),
(7, '2026-02-08'),
(8, '2026-02-09'),
(9, '2026-02-10');

INSERT INTO feature_usage (user_id, feature_name, timestamp) VALUES
(1, 'Search', '2026-02-01 10:00:00'),
(1, 'Add to Cart', '2026-02-01 10:05:00'),
(2, 'Search', '2026-02-03 11:00:00'),
(3, 'Wishlist', '2026-02-04 12:00:00'),
(4, 'Search', '2026-02-05 09:00:00'),
(5, 'Add to Cart', '2026-02-06 14:00:00'),
(6, 'Checkout', '2026-02-07 15:00:00'),
(7, 'Search', '2026-02-08 16:00:00'),
(8, 'Wishlist', '2026-02-09 17:00:00'),
(9, 'Checkout', '2026-02-10 18:00:00');





#Q1 number of unique users who logged in that day
SELECT login_date, COUNT(DISTINCT user_id) AS daily_active_users
FROM logins
GROUP BY login_date
ORDER BY login_date;

#Q2 percentage of users who used a feature at least once
SELECT feature_name, 
       COUNT(DISTINCT user_id) * 100 / (SELECT COUNT(*) FROM users) AS adoppercent
FROM feature_usage
GROUP BY feature_name;

#Q3 how many days after signup a user first used a feature
SELECT user_id, MIN(timestamp) AS first_use,
       DATEDIFF(MIN(timestamp), signup_date) AS days_after_signup
FROM feature_usage
JOIN users USING(user_id)
WHERE feature_name = 'Search'
GROUP BY user_id, signup_date;

#Q4 
SELECT MONTH(signup_date) AS signup_month, feature_name, COUNT(*) AS usage_count
FROM feature_usage
JOIN users USING(user_id)
GROUP BY signup_month, feature_name;

#Q5
SELECT MONTH(signup_date) AS signup_month, feature_name, COUNT(*) AS usage_count
FROM feature_usage
JOIN users USING(user_id)
GROUP BY signup_month, feature_name;

#Q6
INSERT INTO feature_usage (user_id, feature_name, timestamp) VALUES
(1, 'Wishlist', '2026-02-01 10:10:00'),
(1, 'Checkout', '2026-02-01 10:15:00'),
(1, 'Profile', '2026-02-01 10:20:00'),
(1, 'Offers', '2026-02-01 10:25:00'),
(1, 'Settings', '2026-02-01 10:30:00');

SELECT user_id, DATE(timestamp) AS day, COUNT(DISTINCT feature_name) AS features_used
FROM feature_usage
GROUP BY user_id, DATE(timestamp)
HAVING features_used > 5;

#Q7
SELECT user_id, 
       (MAX(login_date) - MIN(login_date)) / (COUNT(*) - 1) AS avg_gap_days
FROM logins
GROUP BY user_id
HAVING COUNT(*) > 1;

#Q8
SELECT feature_name, COUNT(*) AS usage_count
FROM feature_usage
JOIN users USING(user_id)
WHERE timestamp <= signup_date + INTERVAL 7 DAY
GROUP BY feature_name
ORDER BY usage_count DESC
LIMIT 1;

#Q9
SELECT COUNT(*) AS never_logged_in
FROM users
LEFT JOIN logins USING(user_id)
WHERE logins.user_id IS NULL;

#Q10
SELECT COUNT(*) * 1.0 / (SELECT COUNT(*) FROM logins) AS avg_features_per_login
FROM feature_usage;