-- Phase 4: Database Schema Design (PostgreSQL Syntax)
-- Enterprise Inventory & Order Synchronization System

-- 1. Product Master Dimension Table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    sku VARCHAR(50) UNIQUE NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    reorder_threshold INT NOT NULL DEFAULT 10
);

-- 2. Real-Time Operational Inventory Table (OLTP)
CREATE TABLE inventory_levels (
    inventory_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    warehouse_id INT NOT NULL,
    available_qty INT NOT NULL CHECK (available_qty >= 0),
    reserved_qty INT NOT NULL DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Customer Orders Header Table (OLTP)
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_status VARCHAR(30) NOT NULL, -- 'FULFILLED', 'CANCELLED_STOCKOUT', 'PENDING'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    shipped_at TIMESTAMP
);

-- 4. Order Line Items Table (OLTP)
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL
);

-- 5. Executive Analytics Fact Table (OLAP Data Warehouse)
CREATE TABLE fact_order_fulfillment (
    fact_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    fulfillment_time_hours DECIMAL(5, 2),
    is_cancelled BOOLEAN DEFAULT FALSE,
    cancellation_reason VARCHAR(100),
    lost_revenue_amount DECIMAL(10, 2) DEFAULT 0.00
);
