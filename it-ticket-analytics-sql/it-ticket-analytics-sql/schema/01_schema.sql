-- ============================================================
-- IT Support Ticket Analytics - Database Schema
-- Compatible with MySQL 8+ / PostgreSQL 13+ (minor syntax tweaks noted)
-- ============================================================

CREATE DATABASE IF NOT EXISTS it_ticket_analytics;
USE it_ticket_analytics;

-- Technicians who resolve tickets
CREATE TABLE technicians (
    technician_id   INT PRIMARY KEY AUTO_INCREMENT,
    full_name       VARCHAR(100) NOT NULL,
    department      VARCHAR(50),
    hire_date       DATE
);

-- Categories of IT issues
CREATE TABLE ticket_categories (
    category_id     INT PRIMARY KEY AUTO_INCREMENT,
    category_name   VARCHAR(50) NOT NULL,
    priority_level  VARCHAR(20) DEFAULT 'Medium' -- Low, Medium, High, Critical
);

-- End users who raise tickets
CREATE TABLE employees (
    employee_id     INT PRIMARY KEY AUTO_INCREMENT,
    full_name       VARCHAR(100) NOT NULL,
    department      VARCHAR(50),
    location        VARCHAR(50)
);

-- Core tickets table
CREATE TABLE tickets (
    ticket_id       INT PRIMARY KEY AUTO_INCREMENT,
    employee_id     INT NOT NULL,
    category_id     INT NOT NULL,
    technician_id   INT,
    status          VARCHAR(20) DEFAULT 'Open', -- Open, In Progress, Resolved, Closed
    created_at      DATETIME NOT NULL,
    resolved_at     DATETIME,
    description     VARCHAR(255),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (category_id) REFERENCES ticket_categories(category_id),
    FOREIGN KEY (technician_id) REFERENCES technicians(technician_id)
);

-- Log of status changes per ticket (for downtime / SLA tracking)
CREATE TABLE ticket_status_log (
    log_id          INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id       INT NOT NULL,
    status          VARCHAR(20) NOT NULL,
    changed_at      DATETIME NOT NULL,
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id)
);
