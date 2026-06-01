-- ====================================================================
-- FILE: 03_indexing_optimization.sql
-- DESCRIPTION: Query optimization using composite indexing.
-- ====================================================================

-- Creating a Multi-Column Composite Index
CREATE INDEX idx_orders_user_amount ON orders(user_id, total_amount);

-- Diagnostic Test: Forcing Index Scan Verification
SET enable_seqscan = OFF;

EXPLAIN ANALYZE
SELECT * FROM orders WHERE user_id = 4 AND total_amount = 120.00;

SET enable_seqscan = ON;
