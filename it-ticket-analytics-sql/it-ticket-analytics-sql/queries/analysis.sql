-- ============================================================
-- IT Support Ticket Analytics - Key Queries
-- ============================================================
USE it_ticket_analytics;

-- 1. Average resolution time (in minutes) per category
SELECT
    tc.category_name,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, t.created_at, t.resolved_at)), 1) AS avg_resolution_minutes,
    COUNT(*) AS ticket_count
FROM tickets t
JOIN ticket_categories tc ON t.category_id = tc.category_id
WHERE t.resolved_at IS NOT NULL
GROUP BY tc.category_name
ORDER BY avg_resolution_minutes DESC;

-- 2. Technician performance: tickets resolved & average handling time
SELECT
    tech.full_name,
    COUNT(t.ticket_id) AS tickets_resolved,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, t.created_at, t.resolved_at)), 1) AS avg_resolution_minutes
FROM tickets t
JOIN technicians tech ON t.technician_id = tech.technician_id
WHERE t.resolved_at IS NOT NULL
GROUP BY tech.full_name
ORDER BY tickets_resolved DESC;

-- 3. Open / unresolved tickets right now (SLA risk)
SELECT
    t.ticket_id,
    e.full_name AS employee,
    tc.category_name,
    tc.priority_level,
    t.status,
    t.created_at,
    TIMESTAMPDIFF(HOUR, t.created_at, NOW()) AS hours_open
FROM tickets t
JOIN employees e ON t.employee_id = e.employee_id
JOIN ticket_categories tc ON t.category_id = tc.category_id
WHERE t.status IN ('Open', 'In Progress')
ORDER BY hours_open DESC;

-- 4. Most common issue categories (volume ranking)
SELECT
    tc.category_name,
    COUNT(*) AS total_tickets,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM tickets), 1) AS pct_of_all_tickets
FROM tickets t
JOIN ticket_categories tc ON t.category_id = tc.category_id
GROUP BY tc.category_name
ORDER BY total_tickets DESC;

-- 5. Daily ticket volume trend (spot spikes / network incidents)
SELECT
    DATE(created_at) AS ticket_date,
    COUNT(*) AS tickets_created
FROM tickets
GROUP BY DATE(created_at)
ORDER BY ticket_date;

-- 6. Critical/High priority tickets and whether they breached a 2-hour SLA
SELECT
    t.ticket_id,
    tc.category_name,
    tc.priority_level,
    t.created_at,
    t.resolved_at,
    TIMESTAMPDIFF(MINUTE, t.created_at, t.resolved_at) AS resolution_minutes,
    CASE
        WHEN TIMESTAMPDIFF(MINUTE, t.created_at, t.resolved_at) > 120 THEN 'SLA Breached'
        ELSE 'Within SLA'
    END AS sla_status
FROM tickets t
JOIN ticket_categories tc ON t.category_id = tc.category_id
WHERE tc.priority_level IN ('High', 'Critical')
  AND t.resolved_at IS NOT NULL
ORDER BY resolution_minutes DESC;

-- 7. Department raising the most tickets (helps target training/resources)
SELECT
    e.department,
    COUNT(*) AS total_tickets
FROM tickets t
JOIN employees e ON t.employee_id = e.employee_id
GROUP BY e.department
ORDER BY total_tickets DESC;
