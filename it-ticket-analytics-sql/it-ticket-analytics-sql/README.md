# IT Support Ticket Analytics (SQL)

A relational database project that models an internal IT helpdesk system and uses SQL to analyze ticket volume, technician performance, and SLA compliance — the kind of data an IT engineer or system administrator would actually track day to day.

## Problem Statement
IT support teams handle a constant stream of tickets (password resets, VPN issues, hardware failures, network outages). Without structured tracking, it's hard to answer basic questions like:
- Which issue categories take the longest to resolve?
- Which technicians are handling the most tickets, and how fast?
- Are high-priority tickets breaching SLA targets?
- Which departments generate the most support load?

This project builds a normalized database to answer those questions with SQL.

## Tech Stack
- MySQL 8+ (or PostgreSQL 13+ with minor syntax adjustments — see Notes below)
- Standard SQL (joins, aggregation, window-free analytics, CASE logic)

## Schema
Five tables, normalized to 3NF:
- `technicians` — support staff
- `employees` — end users raising tickets
- `ticket_categories` — issue type + priority level
- `tickets` — core fact table linking employees, technicians, and categories
- `ticket_status_log` — status change history (for future SLA/timeline tracking)

![Schema Overview](docs/schema-diagram.png) <!-- optional: add an ER diagram image here -->

## Files
```
schema/
  01_schema.sql        -- table definitions + relationships
  02_sample_data.sql    -- sample dataset (15 tickets, 4 technicians, 6 employees)
queries/
  analysis.sql          -- 7 analysis queries (see below)
```

## Key Queries & Insights
| # | Query | Business Question |
|---|-------|-------------------|
| 1 | Avg resolution time by category | Which issue types take longest to fix? |
| 2 | Technician performance | Who's resolving the most tickets, and how fast? |
| 3 | Open/unresolved tickets | What's currently at SLA risk? |
| 4 | Ticket volume by category | What are our most common issues? |
| 5 | Daily ticket volume trend | Are there spikes tied to outages? |
| 6 | SLA breach check (High/Critical) | Are urgent tickets meeting a 2-hour SLA? |
| 7 | Tickets by department | Which teams need the most IT support? |

### Sample Insight
Running query #1 on the sample dataset shows **Hardware Issue** and **Active Directory Access** tickets take the longest to resolve on average, while **Password Reset** tickets are resolved in under 30 minutes — suggesting hardware ticket triage could be streamlined with better spare-parts availability.

## How to Run
1. Install MySQL (or use a free instance on [db-fiddle.com](https://www.db-fiddle.com) to test without installing anything).
2. Run `schema/01_schema.sql` to create the database and tables.
3. Run `schema/02_sample_data.sql` to load sample data.
4. Run any query from `queries/analysis.sql` to see results.

## Notes for PostgreSQL users
Replace `AUTO_INCREMENT` with `SERIAL`, and `TIMESTAMPDIFF(MINUTE, a, b)` with `EXTRACT(EPOCH FROM (b - a))/60`.

## Author
[Your Name] — IT Engineer with experience in Active Directory, VPN/WAN connectivity, and system administration. This project reflects real ticketing and troubleshooting workflows from hands-on IT support experience.
