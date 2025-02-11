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

CREATE TRIGGER order_insert_trigger 
	AFTER INSERT ON orders
	FOR EACH ROW
	EXECUTE FUNCTION  update_statistics();
