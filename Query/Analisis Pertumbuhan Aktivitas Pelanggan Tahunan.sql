-- Langkah 1 : Melihat rata-rata jumlah customer aktif bulanan setiap tahun

SELECT year, ROUND(AVG(total_cust),2) as average_mau from( SELECT MONTH(order_purchase_timestamp) as month, YEAR(order_purchase_timestamp) as year, COUNT(DISTINCT customer_unique_id) as total_cust FROM orders as o JOIN customers as c ON o.customer_id = c.customer_id GROUP BY month, year ORDER BY year ) total_cust_temp_table group by YEAR;

-- Langkah 2 : Menampilkan jumlah customer baru pada masing-masing tahun.

select YEAR(first_bought) as year, count(1) as new_cust from (select customer_unique_id, min(order_purchase_timestamp) as first_bought from orders as o join customers as c on o.customer_id = c.customer_id group by customer_unique_id ) first_bought_temp_table group by YEAR;

-- Langkah 3 : Melihat jumlah customer yang melakukan pembelian lebih dari satu kali (repeat order) pada masing-masing tahun.

select year, count(distinct customer_unique_id) as repeat_cust from( select YEAR(order_purchase_timestamp) as year, customer_unique_id, count(1) as jumlah_pembelian from orders as o join customers as c on o.customer_id = c.customer_id group by customer_unique_id, year having count(jumlah_pembelian) > 1 ) as repeat_cust_temp group by YEAR;

-- Langkah 4 : Melihat rata-rata jumlah order yang dilakukan customer untuk masing-masing tahun.

select year, round(avg(jumlah_pembelian),2) as total_order from( select YEAR(order_purchase_timestamp) as year, customer_unique_id, count(1) as jumlah_pembelian from orders as o join customers as c on o.customer_id = c.customer_id group by customer_unique_id, year ) as total_order group by YEAR;

-- Langkah 5 : Menggabungkan ketiga metrik yang telah berhasil ditampilkan menjadi satu tampilan tabel

WITH mau_table AS( SELECT year, ROUND(AVG(total_cust),2) as average_mau from ( SELECT MONTH(order_purchase_timestamp) as MONTH, YEAR(order_purchase_timestamp) as year, COUNT(DISTINCT customer_unique_id) as total_cust FROM orders AS o JOIN customers as c ON o.customer_id = c.customer_id GROUP BY month, year ) total_cust_temp_table group by year ), new_cust AS( select YEAR(first_bought) as year, count(1) as new_cust from ( select customer_unique_id, min(order_purchase_timestamp) as first_bought from orders AS o join customers as c on o.customer_id = c.customer_id group by customer_unique_id ) first_bought_temp_table group by year ), repeat_cust AS( select YEAR, count(distinct customer_unique_id) as repeat_cust from ( select YEAR(order_purchase_timestamp) as year, customer_unique_id, count(1) as jumlah_pembelian from orders as o join customers as c on o.customer_id = c.customer_id group by customer_unique_id, year having count(jumlah_pembelian) > 1 ) repeat_cust_temp group by year ), avg_order AS ( select year, round(avg(jumlah_pembelian),2) as avg_order from ( select YEAR(order_purchase_timestamp) as year, customer_unique_id, count(1) as jumlah_pembelian from orders as o join customers as c on o.customer_id = c.customer_id group by customer_unique_id, year ) total_order group by year ) SELECT a.year, a.average_mau, b.new_cust, c.repeat_cust, d.avg_order FROM mau_table a JOIN new_cust b ON a.year = b.year JOIN repeat_cust c ON a.year = c.year JOIN avg_order d ON a.year = d.year;

