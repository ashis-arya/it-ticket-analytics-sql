-- ============================================================
-- Sample Data for IT Support Ticket Analytics
-- ============================================================
USE it_ticket_analytics;

INSERT INTO technicians (full_name, department, hire_date) VALUES
('Ravi Kumar', 'IT Support', '2023-01-15'),
('Priya Sharma', 'IT Support', '2022-06-01'),
('Amit Das', 'Network Team', '2024-02-20'),
('Sara Iqbal', 'IT Support', '2023-09-10');

INSERT INTO ticket_categories (category_name, priority_level) VALUES
('Password Reset', 'Low'),
('VPN Connectivity', 'High'),
('Hardware Issue', 'Medium'),
('Software Installation', 'Low'),
('Network Outage', 'Critical'),
('Email/Outlook Issue', 'Medium'),
('Active Directory Access', 'High');

INSERT INTO employees (full_name, department, location) VALUES
('Neha Verma', 'Finance', 'Ahmedabad'),
('Karan Mehta', 'Sales', 'Mumbai'),
('Divya Nair', 'HR', 'Ahmedabad'),
('Rohit Singh', 'Operations', 'Delhi'),
('Anjali Rao', 'Finance', 'Ahmedabad'),
('Vikram Joshi', 'Sales', 'Mumbai');

INSERT INTO tickets (employee_id, category_id, technician_id, status, created_at, resolved_at, description) VALUES
(1, 1, 1, 'Resolved', '2026-05-01 09:15:00', '2026-05-01 09:45:00', 'Forgot AD password'),
(2, 2, 3, 'Resolved', '2026-05-01 10:00:00', '2026-05-01 12:30:00', 'VPN not connecting from home'),
(3, 3, 2, 'Resolved', '2026-05-02 08:30:00', '2026-05-02 14:00:00', 'Laptop not powering on'),
(4, 5, 3, 'Resolved', '2026-05-02 09:00:00', '2026-05-02 11:00:00', 'Branch network outage'),
(5, 6, 4, 'Resolved', '2026-05-03 13:20:00', '2026-05-03 13:50:00', 'Outlook not syncing'),
(6, 7, 1, 'Resolved', '2026-05-03 15:00:00', '2026-05-04 09:00:00', 'Cannot access shared drive'),
(1, 4, 2, 'Resolved', '2026-05-04 10:10:00', '2026-05-04 10:40:00', 'Needs Excel installed'),
(2, 2, 3, 'Resolved', '2026-05-05 08:45:00', '2026-05-05 09:15:00', 'VPN dropping intermittently'),
(3, 1, 4, 'Resolved', '2026-05-05 11:00:00', '2026-05-05 11:20:00', 'Locked out of account'),
(4, 3, 2, 'In Progress', '2026-05-06 09:30:00', NULL, 'Monitor flickering'),
(5, 5, 3, 'Resolved', '2026-05-06 07:50:00', '2026-05-06 10:20:00', 'Office network down'),
(6, 6, 4, 'Open', '2026-05-06 16:00:00', NULL, 'Emails bouncing back'),
(1, 7, 1, 'Resolved', '2026-05-07 09:00:00', '2026-05-07 09:30:00', 'AD group access needed'),
(2, 1, 1, 'Resolved', '2026-05-07 10:15:00', '2026-05-07 10:35:00', 'Password expired'),
(3, 2, 3, 'Resolved', '2026-05-08 08:00:00', '2026-05-08 08:40:00', 'VPN certificate error');
