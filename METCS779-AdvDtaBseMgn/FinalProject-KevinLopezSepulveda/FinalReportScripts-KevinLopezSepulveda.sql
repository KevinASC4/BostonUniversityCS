SELECT * FROM inventory;
SELECT * FROM inventory ORDER BY inventory_id ASC LIMIT 10;   -- Top 10
SELECT * FROM inventory ORDER BY inventory_id DESC LIMIT 10;  -- Bottom 10

-- =====================================
-- 2. Menu
-- =====================================
SELECT * FROM menu;
SELECT * FROM menu ORDER BY menu_id ASC LIMIT 10;
SELECT * FROM menu ORDER BY menu_id DESC LIMIT 10;

-- =====================================
-- 3. Menu Ingredients
-- =====================================
SELECT * FROM menu_ingredients;
SELECT * FROM menu_ingredients ORDER BY menu_id, inventory_id ASC LIMIT 10;
SELECT * FROM menu_ingredients ORDER BY menu_id DESC, inventory_id DESC LIMIT 10;

-- =====================================
-- 4. Customers
-- =====================================
SELECT * FROM customers;
SELECT * FROM customers ORDER BY customer_id ASC LIMIT 10;
SELECT * FROM customers ORDER BY customer_id DESC LIMIT 10;

-- =====================================
-- 5. Employees
-- =====================================
SELECT * FROM employees;
SELECT * FROM employees ORDER BY employee_id ASC LIMIT 10;
SELECT * FROM employees ORDER BY employee_id DESC LIMIT 10;

-- =====================================
-- 6. Sales
-- =====================================
SELECT * FROM sales;
SELECT * FROM sales ORDER BY sale_id ASC LIMIT 10;
SELECT * FROM sales ORDER BY sale_id DESC LIMIT 10;

-- =====================================
-- 7. Sale Details
-- =====================================
SELECT * FROM sale_details;
SELECT * FROM sale_details ORDER BY sale_detail_id ASC LIMIT 10;
SELECT * FROM sale_details ORDER BY sale_detail_id DESC LIMIT 10;

-- =====================================
-- 8. Suppliers
-- =====================================
SELECT * FROM suppliers;
SELECT * FROM suppliers ORDER BY supplier_id ASC LIMIT 10;
SELECT * FROM suppliers ORDER BY supplier_id DESC LIMIT 10;

-- =====================================
-- 9. Purchase Orders
-- =====================================
SELECT * FROM purchase_orders;
SELECT * FROM purchase_orders ORDER BY purchase_order_id ASC LIMIT 10;
SELECT * FROM purchase_orders ORDER BY purchase_order_id DESC LIMIT 10;

-- =====================================
-- 10. Purchase Order Items
-- =====================================
SELECT * FROM purchase_order_items;
SELECT * FROM purchase_order_items ORDER BY purchase_order_id, inventory_id ASC LIMIT 10;
SELECT * FROM purchase_order_items ORDER BY purchase_order_id DESC, inventory_id DESC LIMIT 10;

-- =====================================
-- 11. Inventory Transactions
-- =====================================
SELECT * FROM inventory_transactions;
SELECT * FROM inventory_transactions ORDER BY transaction_id ASC LIMIT 10;
SELECT * FROM inventory_transactions ORDER BY transaction_id DESC LIMIT 10;