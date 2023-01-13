-- Langkah 1 : Pembuatan database beserta tabel, dapat menggunakan CREATE statement, dengan memperhatikan tipe data dari setiap kolom.

-- pembuatan tabel product
CREATE TABLE IF NOT EXISTS product( col_index INT, product_id VARCHAR(250) PRIMARY KEY, product_category_name VARCHAR(250), product_name_length INT, product_description_lenght INT, product_photos_qty INT, product_weight_g INT, product_length_cm INT, product_height_cm INT, product_width_cm INT );

-- pembuatan table geolocation
CREATE TABLE IF NOT EXISTS geolocation( geolocation_zip_code_prefix VARCHAR(250), geolocation_lat VARCHAR(250), geolocation_lng VARCHAR(250), geolocation_city VARCHAR(250), geolocation_state VARCHAR(250) );

-- pembuatan table customers
CREATE TABLE IF NOT EXISTS customers( customer_id VARCHAR(250) PRIMARY KEY, customer_unique_id VARCHAR(250), customer_zip_code_prefix INT, customer_city VARCHAR(250), customer_state VARCHAR(250) );
 
-- pembuatan tabel seller
CREATE TABLE IF NOT EXISTS seller( seller_id VARCHAR(250) PRIMARY KEY, seller_zip_code_prefix INT, seller_city VARCHAR(250), seller_state VARCHAR(250) );

-- pembuatan tabel orders
CREATE TABLE IF NOT EXISTS orders( order_id VARCHAR(250) PRIMARY KEY, customer_id VARCHAR(250), order_status VARCHAR(250), order_purchase_timestamp DATETIME, order_approved_at DATETIME, order_delivered_carrier_date DATETIME, order_delivered_customer_date DATETIME, order_estimated_delivery_date DATETIME );

-- pembuatan table order_items
CREATE TABLE IF NOT EXISTS order_items( order_id VARCHAR(250), order_item_id INT, product_id VARCHAR(250), seller_id VARCHAR(250), shipping_limit_date DATETIME, price FLOAT, freight_value FLOAT );

-- pembuatan tabel order_payments
CREATE TABLE IF NOT EXISTS order_payments( order_id VARCHAR(250), payment_sequential INT, payment_type VARCHAR(250), payment_installments INT, payment_value FLOAT );

-- pembuatan table order_reviews
CREATE TABLE IF NOT EXISTS order_reviews( review_id VARCHAR(250), order_id VARCHAR(250), review_score INT, review_comment_title TEXT, review_comment_message TEXT, review_creation_date DATETIME, review_answer_timestamp DATETIME );


-- Langkah 2 : Importing data csv ke dalam database menggunakan LOAD DATA INFILE statement. Dalam mengimpor data csv ke database

-- import product_dataset.csv
LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/product_dataset.csv' INTO TABLE product FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- import customers_dataset.csv
LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/customers_dataset.csv' INTO TABLE customers FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- import geolocation_dataset.csv
LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/geolocation_dataset.csv' INTO TABLE geolocation FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- import orders_dataset.csv
LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/orders_dataset.csv' INTO TABLE orders FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- import sellers_dataset.csv
LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/sellers_dataset.csv' INTO TABLE seller FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- import order_items_dataset.csv
LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/order_items_dataset.csv' INTO TABLE order_items FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- import order_payments_dataset.csv
LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/order_payments_dataset.csv' INTO TABLE order_payments FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- import order_reviews_dataset.csv
LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/order_reviews_dataset.csv' INTO TABLE order_reviews FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- Langkah 3 : Memodifikasi data dengan menambahkan foreign key untuk menunjukkan hubungan antar tabel

-- drop col_index pada tabel product karena tidak dibutuhkan
ALTER TABLE product DROP COLUMN col_index;

-- menghubungkan orders dan customers berdasarkan customer_id
ALTER TABLE orders ADD CONSTRAINT fk_orders FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE;

-- menghubungkan order_item dan orders berdasarkan order_id
ALTER TABLE order_items ADD CONSTRAINT fk_order_items FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE;

-- menghubungkan order_items dengan product_id berdasarkan product_id
ALTER TABLE order_items ADD CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE ON UPDATE CASCADE;

-- menghubungkan order_payments dengan order berdasarkan order_id
ALTER TABLE order_payments ADD CONSTRAINT fk_order_payments FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE;

-- menghubungkan order_reviews dengan order berdasarkan order_id
ALTER TABLE order_reviews ADD CONSTRAINT fk_order_reviews FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE;