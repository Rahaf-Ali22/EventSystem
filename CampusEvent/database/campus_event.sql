-- USERS TABLE
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    faculty VARCHAR(100),
    department VARCHAR(100),
    admission_year INT,
    role VARCHAR(50),
    is_blocked BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- EVENTS TABLE
CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    event_date DATE NOT NULL,
    location VARCHAR(200) NOT NULL,
    capacity INT NOT NULL,
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id)
);

-- RESERVATIONS TABLE
CREATE TABLE reservations (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    reservation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'reserved',
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (event_id) REFERENCES events(id)
);

-- SAMPLE DATA

INSERT INTO users (name, email, password, faculty, department, admission_year, role)
VALUES 
('Rahaf', 'rahaf@gmail.com', '123', 'IT', 'Software Engineering', 2022, 'student');

INSERT INTO events (title, description, event_date, location, capacity, created_by)
VALUES 
('AI Workshop', 'Intro to AI', '2026-05-10', 'Hall A', 50, 1),
('Cybersecurity Seminar', 'Security basics', '2026-05-15', 'Room B', 40, 1),
('Web Dev Bootcamp', 'Frontend & Backend', '2026-05-20', 'Lab 3', 30, 1);

-- Departments Table
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Categories Table
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Sample Data
INSERT INTO departments (name) VALUES
('Software Engineering'),
('Computer Science');

INSERT INTO categories (name) VALUES
('Educational'),
('Sports');