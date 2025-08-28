-- 1. Create Database and Use It
CREATE DATABASE IF NOT EXISTS AjeenMock_db;
USE sql5794428;

-- 2. Inventory Table
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    quantity_in_stock DECIMAL(10,2) NOT NULL DEFAULT 0,
    unit_price DECIMAL(10,2) NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3. Menu Table
CREATE TABLE menu (
    menu_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL
);

-- 4. Menu to Ingredients Many-to-Many Table
CREATE TABLE menu_ingredients (
    menu_id INT NOT NULL,
    inventory_id INT NOT NULL,
    quantity_required DECIMAL(10,4) NOT NULL,
    PRIMARY KEY (menu_id, inventory_id),
    FOREIGN KEY (menu_id) REFERENCES menu(menu_id) ON DELETE CASCADE,
    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id) ON DELETE CASCADE
);

-- 5. Customers Table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100)
);

-- 6. Employees Table
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    role VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100)
);

-- 7. Sales Table with Order Status and Employee Handling
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    sale_datetime DATETIME NOT NULL,
    total_amount DECIMAL(10,2),
    order_status ENUM('Received', 'Preparing', 'Ready', 'Delivered', 'Cancelled') DEFAULT 'Received',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- 8. Sale Details Table
CREATE TABLE sale_details (
    sale_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT,
    menu_id INT,
    quantity INT NOT NULL,
    price_each DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id) ON DELETE CASCADE,
    FOREIGN KEY (menu_id) REFERENCES menu(menu_id)
);

-- 9. Suppliers Table
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    contact_info VARCHAR(255)
);

-- 10. Purchase Orders Table
CREATE TABLE purchase_orders (
    purchase_order_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT,
    employee_id INT,
    order_date DATETIME NOT NULL,
    expected_delivery DATETIME,
    status ENUM('Pending', 'Received', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- 11. Purchase Order Items Table
CREATE TABLE purchase_order_items (
    purchase_order_id INT,
    inventory_id INT,
    quantity_ordered DECIMAL(10,2),
    unit_cost DECIMAL(10,2),
    PRIMARY KEY (purchase_order_id, inventory_id),
    FOREIGN KEY (purchase_order_id) REFERENCES purchase_orders(purchase_order_id) ON DELETE CASCADE,
    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id)
);

-- 12. Inventory Transaction Log Table
CREATE TABLE inventory_transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    inventory_id INT,
    transaction_type ENUM('Sale', 'Purchase', 'Adjustment', 'Waste')  NOT NULL,
    quantity_change DECIMAL(10,2),
    transaction_date DATETIME NOT NULL,
    reference_id INT,
    notes TEXT,
    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id)
);

-- 13. Insert Sample Data into Inventory
INSERT INTO inventory (item_name, category, quantity_in_stock, unit_price) VALUES
('Flour', 'Ingredient', 100, 1.50),
('Cheese', 'Ingredient', 50, 5.00),
('Tomato Sauce', 'Ingredient', 30, 3.00),
('Olives', 'Ingredient', 20, 4.00),
('Beef Shawarma', 'Ingredient', 15, 8.00);

-- 14. Insert Sample Data into Menu
INSERT INTO menu (item_name, description, price) VALUES
('Cheese Manoushe', 'Flatbread with cheese', 5.00),
('Meat Pizza', 'Pizza with beef shawarma', 10.00),
('Olive Manoushe', 'Flatbread with olives', 6.00);

-- 15. Link Menu Items to Ingredients
INSERT INTO menu_ingredients (menu_id, inventory_id, quantity_required) VALUES
(1, 1, 0.2),  -- Cheese Manoushe needs 0.2 kg Flour
(1, 2, 0.1),  -- Cheese
(1, 3, 0.05), -- Tomato Sauce
(2, 1, 0.3),  -- Meat Pizza needs Flour
(2, 2, 0.15), -- Cheese
(2, 3, 0.08), -- Tomato Sauce
(2, 5, 0.2),  -- Beef Shawarma
(3, 1, 0.2),  -- Olive Manoushe needs Flour
(3, 4, 0.1);  -- Olives

-- 16. Insert Sample Customers
INSERT INTO customers (name, phone, email) VALUES
('Ali Hassan', '555-1234', 'ali@example.com'),
('Maya Khalil', '555-5678', 'maya@example.com');

-- 17. Insert Sample Employees
INSERT INTO employees (name, role, phone, email) VALUES
('Ahmed Saad', 'Cashier', '555-0001', 'ahmed@example.com'),
('Layla Nassar', 'Cook', '555-0002', 'layla@example.com');

-- 18. Stored Procedure to Process Sale (Adjust Inventory & Log Transactions)
DELIMITER $$

CREATE PROCEDURE ProcessSale(
    IN p_customer_id INT,
    IN p_employee_id INT,
    IN p_menu_id INT,
    IN p_quantity INT
)
BEGIN
    -- Declare variables first, before any statements
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_total DECIMAL(10,2);
    DECLARE v_inv_id INT;
    DECLARE v_qty_req DECIMAL(10,4);
    DECLARE done INT DEFAULT FALSE;

    -- Declare cursor
    DECLARE cur CURSOR FOR
        SELECT inventory_id, quantity_required FROM menu_ingredients WHERE menu_id = p_menu_id;

    -- Declare handler for end of cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Get menu item price
    SELECT price INTO v_price FROM menu WHERE menu_id = p_menu_id;

    -- Calculate total sale amount
    SET v_total = v_price * p_quantity;

    -- Insert new sale
    INSERT INTO sales (customer_id, employee_id, total_amount) VALUES (p_customer_id, p_employee_id, v_total);
    SET @sale_id = LAST_INSERT_ID();

    -- Insert sale details
    INSERT INTO sale_details (sale_id, menu_id, quantity, price_each)
    VALUES (@sale_id, p_menu_id, p_quantity, v_price);

    -- Open cursor and loop
    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_inv_id, v_qty_req;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Deduct ingredient stock
        UPDATE inventory
        SET quantity_in_stock = quantity_in_stock - (v_qty_req * p_quantity),
            last_updated = CURRENT_TIMESTAMP
        WHERE inventory_id = v_inv_id;

        -- Log transaction
        INSERT INTO inventory_transactions (inventory_id, transaction_type, quantity_change, reference_id, notes)
        VALUES (v_inv_id, 'Sale', -(v_qty_req * p_quantity), @sale_id, CONCAT('Used for sale_id: ', @sale_id));
    END LOOP;

    CLOSE cur;
END$$

DELIMITER ;


-- 19. Views for Reports

CREATE OR REPLACE VIEW v_top_selling_items AS
SELECT 
    m.menu_id,
    m.item_name,
    SUM(sd.quantity) AS total_sold,
    SUM(sd.quantity * sd.price_each) AS total_revenue
FROM sale_details sd
JOIN menu m ON sd.menu_id = m.menu_id
GROUP BY m.menu_id, m.item_name
ORDER BY total_sold DESC;

CREATE OR REPLACE VIEW v_daily_revenue AS
SELECT 
    DATE(s.sale_datetime) AS sale_date,
    SUM(s.total_amount) AS total_revenue,
    COUNT(s.sale_id) AS total_sales
FROM sales s
GROUP BY DATE(s.sale_datetime)
ORDER BY sale_date DESC;

CREATE OR REPLACE VIEW v_low_stock AS
SELECT 
    inventory_id,
    item_name,
    category,
    quantity_in_stock,
    unit_price
FROM inventory
WHERE quantity_in_stock < 10
ORDER BY quantity_in_stock ASC;

CREATE OR REPLACE VIEW v_customer_purchases AS
SELECT 
    c.customer_id,
    c.name AS customer_name,
    c.phone,
    c.email,
    s.sale_id,
    s.sale_datetime,
    m.item_name,
    sd.quantity,
    sd.price_each,
    (sd.quantity * sd.price_each) AS line_total
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
JOIN sale_details sd ON s.sale_id = sd.sale_id
JOIN menu m ON sd.menu_id = m.menu_id
ORDER BY c.customer_id, s.sale_datetime DESC;

-- 20. Indexes for performance optimization
CREATE INDEX idx_menu_name ON menu(item_name);
CREATE INDEX idx_inventory_name ON inventory(item_name);
CREATE INDEX idx_sales_date ON sales(sale_datetime);
CREATE INDEX idx_customer_name ON customers(name);

