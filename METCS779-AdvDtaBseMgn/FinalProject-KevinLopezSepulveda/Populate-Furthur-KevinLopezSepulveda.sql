-- Populate inventory with 20 items
INSERT INTO inventory (item_name, category, quantity_in_stock, unit_price) VALUES
('Lebanese Bread', 'Bakery', 150, 0.50),
('Hummus', 'Dip', 100, 4.00),
('Falafel', 'Snack', 200, 1.50),
('Tabbouleh', 'Salad', 120, 3.50),
('Kofta', 'Main Course', 80, 7.00),
('Lamb Shawarma', 'Main Course', 90, 8.50),
('Chicken Shawarma', 'Main Course', 110, 7.50),
('Baklava', 'Dessert', 70, 3.00),
('Mint Tea', 'Beverage', 300, 1.00),
('Pita Bread', 'Bakery', 180, 0.40),
('Garlic Sauce', 'Condiment', 130, 2.50),
('Labneh', 'Dairy', 90, 5.00),
('Pickled Turnips', 'Side', 75, 1.00),
('Fattoush', 'Salad', 100, 3.00),
('Kibbeh', 'Snack', 50, 6.00),
('Shish Tawook', 'Main Course', 85, 8.00),
('Rice Pilaf', 'Side', 120, 2.00),
('Sambousek', 'Appetizer', 140, 4.50),
('Arabic Coffee', 'Beverage', 200, 1.50),
('Cucumber Salad', 'Salad', 110, 2.50);

INSERT INTO menu (menu_id, item_name, description, price) VALUES
(4, 'Classic Hummus', 'Creamy chickpea dip', 5.50),
(5, 'Falafel Wrap', 'Falafel with garlic sauce in pita', 7.00),
(6, 'Chicken Shawarma Plate', 'Grilled chicken with rice and salad', 12.00),
(7, 'Baklava Slice', 'Sweet layered pastry', 4.00),
(8, 'Mint Tea Hot', 'Refreshing traditional mint tea', 2.00),
(9, 'Kofta Kebabs', 'Ground meat grilled skewers', 10.00),
(10, 'Tabbouleh Salad', 'Parsley, tomatoes, and bulgur', 6.00);


-- Populate customers
INSERT INTO customers (name, phone, email) VALUES
('Ali Hassan', '555-1234', 'ali.hassan@example.com'),
('Maya Khoury', '555-2345', 'maya.khoury@example.com'),
('Omar Saleh', '555-3456', 'omar.saleh@example.com'),
('Noura Haddad', '555-4567', 'noura.haddad@example.com'),
('Layla Samir', '555-5678', 'layla.samir@example.com');

-- Populate employees
INSERT INTO employees (name, role, phone, email) VALUES
('Ahmed Nasser', 'Chef', '555-1111', 'ahmed.nasser@example.com'),
('Sara Khalil', 'Cashier', '555-2222', 'sara.khalil@example.com'),
('Fadi Mansour', 'Manager', '555-3333', 'fadi.mansour@example.com');

-- Populate suppliers
INSERT INTO suppliers (name, contact_info) VALUES
('Fresh Farms', 'mo.saleem@freshfarms.com'),
('Mediterranean Goods','rana.majid@medgoods.com');

-- Insert some purchase orders (inventory inflow)
INSERT INTO purchase_orders (supplier_id, employee_id, order_date, expected_delivery, status) VALUES
(1, 3, '2025-08-01 10:00:00', '2025-08-03 15:00:00', 'Received'),
(2, 3, '2025-08-02 11:30:00', '2025-08-05 09:00:00', 'Pending');

-- Sales and sale_details with 10 sample sales
INSERT INTO sales (customer_id, employee_id, sale_datetime, total_amount) VALUES
(1, 2, '2025-08-04 12:15:00', 18.00),
(2, 2, '2025-08-04 12:45:00', 22.50),
(3, 2, '2025-08-04 13:10:00', 15.75),
(4, 2, '2025-08-04 13:30:00', 19.20),
(5, 2, '2025-08-04 14:00:00', 25.00),
(1, 2, '2025-08-05 12:05:00', 17.50),
(2, 2, '2025-08-05 12:40:00', 21.00),
(3, 2, '2025-08-05 13:20:00', 14.25),
(4, 2, '2025-08-05 13:45:00', 18.00),
(5, 2, '2025-08-05 14:10:00', 23.50);


INSERT INTO sale_details (sale_id, menu_id, quantity, price_each) VALUES
(1, 4, 2, 5.50),
(1, 8, 1, 2.00),
(2, 5, 3, 7.00),
(3, 6, 1, 12.00),
(4, 7, 2, 4.00),
(5, 9, 2, 10.00),
(6, 4, 1, 5.50),
(7, 10, 2, 6.00),
(8, 6, 1, 12.00),
(9, 5, 1, 7.00),
(10, 8, 2, 2.00);


-- Inventory transactions to reflect stock changes
INSERT INTO inventory_transactions (inventory_id, transaction_type, quantity_change, transaction_date, notes) VALUES
(2, 'Sale', -4, '2025-08-04 12:15:00', 'Sold hummus for sales 1'),
(9, 'Sale', -1, '2025-08-04 12:15:00', 'Sold mint tea for sales 1'),
(3, 'Sale', -3, '2025-08-04 12:45:00', 'Sold falafel for sales 2'),
(7, 'Sale', -1, '2025-08-04 13:10:00', 'Sold chicken shawarma for sales 3'),
(4, 'Sale', -2, '2025-08-04 13:30:00', 'Sold tabbouleh for sales 4'),
(6, 'Sale', -2, '2025-08-04 14:00:00', 'Sold kofta for sales 5'),
(2, 'Sale', -1, '2025-08-05 12:05:00', 'Sold hummus for sales 6'),
(7, 'Sale', -2, '2025-08-05 12:40:00', 'Sold chicken shawarma for sales 7'),
(3, 'Sale', -1, '2025-08-05 13:20:00', 'Sold falafel for sales 8'),
(2, 'Sale', -1, '2025-08-05 14:10:00', 'Sold hummus for sales 10');

