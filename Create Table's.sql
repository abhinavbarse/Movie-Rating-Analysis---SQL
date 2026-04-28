DROP DATABASE IF EXISTS movies_rating;
CREATE DATABASE movies_rating;
USE movies_rating;

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    release_year INT
);

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    country VARCHAR(50)
);

CREATE TABLE ratings (
    rating_id INT PRIMARY KEY AUTO_INCREAMENT,
    user_id INT,
    movie_id INT,
    rating DECIMAL(2,1),
    rating_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);




