CREATE DATABASE job_tracker_db;
USE job_tracker_db;

CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       full_name VARCHAR(100) NOT NULL,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL,
                       phone VARCHAR(15),
                       role ENUM('STUDENT', 'ADMIN') DEFAULT 'STUDENT',
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE job_applications (
                                  id INT AUTO_INCREMENT PRIMARY KEY,
                                  user_id INT NOT NULL,
                                  company_name VARCHAR(100) NOT NULL,
                                  job_role VARCHAR(100) NOT NULL,
                                  status ENUM('APPLIED', 'INTERVIEW', 'SELECTED', 'REJECTED') DEFAULT 'APPLIED',
                                  date_applied DATE NOT NULL,
                                  experience_years INT DEFAULT 0,
                                  job_description TEXT,
                                  notes TEXT,
                                  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE resumes (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         user_id INT NOT NULL,
                         file_name VARCHAR(255) NOT NULL,
                         file_path VARCHAR(500) NOT NULL,
                         uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE admin_actions (
                               id INT AUTO_INCREMENT PRIMARY KEY,
                               admin_id INT NOT NULL,
                               application_id INT NOT NULL,
                               action ENUM('SHORTLISTED', 'REJECTED') NOT NULL,
                               remarks TEXT,
                               action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               FOREIGN KEY (admin_id) REFERENCES users(id),
                               FOREIGN KEY (application_id) REFERENCES job_applications(id) ON DELETE CASCADE
);

INSERT INTO users (full_name, email, password, phone, role)
VALUES (
           'Admin',
           'admin@jobtracker.com',
           '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
           '9999999999',
           'ADMIN'
       );

select * from users;
