# Executive Power BI Dashboard Specification
**Project:** Real-Time Inventory & Order Sync Analytics  
**Target Audience:** Chief Operating Officer (COO) & Operations Directors  
**Tooling:** Power BI Desktop / DAX Engine  

---

## 📊 Dashboard Visual Hierarchy

```text
┌────────────────────────────────────────────────────────────────────────┐
│  [ Lost Revenue: $0 ]     [ Avg Cycle Time: 1.4h ]    [ Cancels: 1.2% ] │ <-- Top KPI Cards
├────────────────────────────────────────────────────────────────────────┤
│  📉 Line Chart: Weekly Cancellation Rate (Pre-Sync vs. Post-Sync)      │ <-- Executive Trend
├────────────────────────────────────────────────────────────────────────┤
│  📋 Table: Stockout SKU Breakdown by Warehouse Location                 │ <-- Detailed Action Table
└────────────────────────────────────────────────────────────────────────┘
```

---

## 🧮 DAX Measures Specification

### 1. Order Cancellation Rate (%)
```dax
Cancellation Rate % = 
DIVIDE(
    CALCULATE(COUNT(orders[order_id]), orders[order_status] = "CANCELLED_STOCKOUT"),
    COUNT(orders[order_id]),
    0
) * 100
```

### 2. Lost Revenue Amount ($)
```dax
Total Lost Revenue = 
CALCULATE(
    SUMX(order_items, order_items[quantity] * order_items[unit_price]),
    orders[order_status] = "CANCELLED_STOCKOUT"
)
```

### 3. Average Fulfillment Time (Hours)
```dax
Avg Fulfillment Cycle Hours = 
AVERAGEX(
    FILTER(orders, orders[order_status] = "FULFILLED"),
    DATEDIFF(orders[created_at], orders[shipped_at], HOUR)
)
```
