-- tables

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    category_id INT REFERENCES categories(id) ON DELETE SET NULL
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(id) ON DELETE CASCADE,
    quantity INT,
    purchase_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE statistics (
    id SERIAL PRIMARY KEY,
    category_id INT REFERENCES categories(id) ON DELETE CASCADE,
    total_quantity INT DEFAULT 0,
    stat_date DATE DEFAULT CURRENT_DATE,
    UNIQUE (category_id, stat_date)
);



-- data inserts

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




-- function

CREATE FUNCTION update_statistics() RETURNS trigger AS $order_insert_trigger$
	DECLARE 
		category INT;
	BEGIN
		SELECT category_id 
		INTO category 
		FROM products 
		WHERE id = NEW.product_id;

		UPDATE statistics
		SET total_quantity = total_quantity + NEW.quantity
		WHERE category_id = category AND stat_date = CURRENT_DATE;

		IF NOT FOUND THEN
			INSERT INTO statistics (category_id, total_quantity, stat_date)
			VALUES (category, NEW.quantity, CURRENT_DATE);
		END IF;

		RETURN NEW;
	END
$order_insert_trigger$ LANGUAGE plpgsql;




-- trigger 

CREATE TRIGGER order_insert_trigger 
	AFTER INSERT ON orders
	FOR EACH ROW
	EXECUTE FUNCTION  update_statistics();