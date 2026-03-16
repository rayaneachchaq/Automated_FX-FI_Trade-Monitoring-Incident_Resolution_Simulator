-- Schema creation for Incident Tracking
CREATE TABLE trade_incidents (
    incident_id SERIAL PRIMARY KEY,
    log_timestamp TIMESTAMP NOT NULL,
    severity_level VARCHAR(10) NOT NULL,
    component VARCHAR(50) NOT NULL,
    user_id VARCHAR(50) NOT NULL,
    product VARCHAR(20) NOT NULL,
    error_code VARCHAR(20),
    description TEXT
);

-- Query 1: Daily Incident Summary by Component
-- Goal: Identify which part of the trading system is the most unstable
SELECT 
    component, 
    COUNT(incident_id) as total_incidents,
    COUNT(CASE WHEN severity_level = 'ERROR' THEN 1 END) as critical_errors
FROM trade_incidents
WHERE DATE(log_timestamp) = CURRENT_DATE
GROUP BY component
ORDER BY total_incidents DESC;

-- Query 2: Identifying recurrent Functional Rejects per User
-- Goal: See if a specific trader (or bot) is repeatedly hitting their trading limits
SELECT 
    user_id, 
    product, 
    COUNT(incident_id) as reject_count
FROM trade_incidents
WHERE error_code = 'FUNC_401'
GROUP BY user_id, product
HAVING COUNT(incident_id) > 5
ORDER BY reject_count DESC;
