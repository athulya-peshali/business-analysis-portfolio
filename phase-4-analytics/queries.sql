-- Phase 4: Executive BI Analytics & SQL Query Suite

-- Query 1: Calculate Order Cancellation Rate & Lost Revenue from Stockouts (Using CTE)
WITH OrderMetrics AS (
    SELECT 
        COUNT(order_id) AS total_orders,
        COUNT(CASE WHEN order_status = 'CANCELLED_STOCKOUT' THEN 1 END) AS cancelled_orders
    FROM orders
),
LostRevenue AS (
    SELECT 
        SUM(oi.quantity * oi.unit_price) AS total_lost_revenue
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_status = 'CANCELLED_STOCKOUT'
)
SELECT 
    om.total_orders,
    om.cancelled_orders,
    ROUND((om.cancelled_orders::DECIMAL / NULLIF(om.total_orders, 0)) * 100, 2) AS cancellation_rate_percentage,
    COALESCE(lr.total_lost_revenue, 0.00) AS total_lost_revenue_usd
FROM OrderMetrics om
CROSS JOIN LostRevenue lr;

-- Query 2: Inventory Delta Velocity & Stock Movement Tracking (Using Window Function)
SELECT 
    product_id,
    warehouse_id,
    available_qty,
    LAG(available_qty, 1) OVER (
        PARTITION BY product_id, warehouse_id 
        ORDER BY last_updated
    ) AS previous_available_qty,
    (available_qty - LAG(available_qty, 1) OVER (
        PARTITION BY product_id, warehouse_id 
        ORDER BY last_updated
    )) AS stock_change_delta,
    last_updated
FROM inventory_levels
ORDER BY product_id, last_updated DESC;
