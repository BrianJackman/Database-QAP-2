-- Create Tables
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert Data
INSERT INTO products (product_name, price, stock_quantity) VALUES
('Product A', 10.00, 100),
('Product B', 20.00, 150),
('Product C', 30.00, 200),
('Product D', 40.00, 250),
('Product E', 50.00, 300);

INSERT INTO customers (first_name, last_name, email) VALUES
('John', 'Doe', 'john.doe@example.com'),
('Jane', 'Smith', 'jane.smith@example.com'),
('Alice', 'Johnson', 'alice.johnson@example.com'),
('Bob', 'Brown', 'bob.brown@example.com');

INSERT INTO orders (customer_id, order_date) VALUES
(1, '2023-10-01'),
(2, '2023-10-02'),
(3, '2023-10-03'),
(4, '2023-10-04'),
(1, '2023-10-05');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 2, 3),
(2, 3, 1),
(2, 4, 2),
(3, 5, 1),
(3, 1, 1),
(4, 2, 2),
(4, 3, 3),
(5, 4, 1),
(5, 5, 2);

-- SQL queries
SELECT product_name, stock_quantity FROM products;


SELECT p.product_name, oi.quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.id
WHERE oi.order_id = 1;

SELECT o.id AS order_id, oi.product_id, oi.quantity
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
WHERE o.customer_id = 1;

-- Update data
UPDATE products p
JOIN order_items oi ON p.id = oi.product_id
SET p.stock_quantity = p.stock_quantity - oi.quantity
WHERE oi.order_id = 1;

-- Delete data
DELETE FROM order_items WHERE order_id = 1;
DELETE FROM orders WHERE id = 1;