INSERT INTO categories (name) VALUES
('Electronics'),
('Clothing'),
('Groceries');

INSERT INTO products (name, category_id) VALUES
('Laptop', 1),
('T-Shirt', 2),
('Milk', 3);

INSERT INTO orders (product_id, quantity) VALUES
(1, 2),  -- Покупка 2 ноутбуков
(2, 5),  -- Покупка 5 футболок
(3, 10); -- Покупка 10 пакетов молока