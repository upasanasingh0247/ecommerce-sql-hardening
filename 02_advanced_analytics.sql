-- ====================================================================
-- FILE: 02_advanced_analytics.sql
-- DESCRIPTION: Complex window functions for live reporting.
-- ====================================================================

-- Live Running Revenue Calculation (Bank Passbook Style)
SELECT
    order_id, 
    created_at::DATE AS order_date, 
    total_amount,
    SUM(total_amount) OVER(ORDER BY created_at::DATE, order_id DESC) AS running_revenue 
FROM orders;
