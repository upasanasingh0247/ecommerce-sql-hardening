-- ====================================================================
-- FILE: 01_audit_triggers.sql
-- DESCRIPTION: Automated security cameras for tracking data changes.
-- ====================================================================

-- 1. ORDER STATUS AUDIT SYSTEM
CREATE TABLE order_status_history(
    history_id SERIAL PRIMARY KEY,
    order_id INT,
    user_id INT,
    old_status VARCHAR(50),
    new_status VARCHAR(50),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    changed_by_db_user VARCHAR(50) DEFAULT CURRENT_USER
);

CREATE FUNCTION log_order_status_change()
RETURNS TRIGGER AS $$
BEGIN 
    IF (OLD.status IS DISTINCT FROM NEW.status) THEN
        INSERT INTO order_status_history(order_id, user_id, old_status, new_status)
        VALUES (NEW.order_id, NEW.user_id, OLD.status, NEW.status);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_order_status_audit
AFTER UPDATE ON orders
FOR EACH ROW
EXECUTE FUNCTION log_order_status_change();


-- 2. INVENTORY AUDIT SYSTEM
ALTER TABLE products ADD COLUMN change_reason VARCHAR(50) DEFAULT 'Standard Update';

CREATE TABLE inventory_history(
    history_id SERIAL PRIMARY KEY,
    product_id INT,
    old_stock INT,
    new_stock INT,
    change_reason VARCHAR(255),
    change_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_inventory_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF (OLD.stock_quantity IS DISTINCT FROM NEW.stock_quantity) THEN 
        INSERT INTO inventory_history (product_id, old_stock, new_stock, change_reason)
        VALUES (NEW.product_id, OLD.stock_quantity, NEW.stock_quantity, NEW.change_reason);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_inventory_audit
AFTER UPDATE ON products 
FOR EACH ROW 
EXECUTE FUNCTION log_inventory_changes();
