-- Langkah 1 : Melihat total pendapatan perusahaan untuk setiap tahunnya.

create table if not exists total_revenue_per_year as select year, round(sum(revenue),2) as revenue from( select YEAR(order_purchase_timestamp) as year, price+freight_value as revenue from orders as o join order_items as i on o.order_id = i.order_id where order_status = 'delivered' order by year, revenue ) revenue_table_temp group by year;

-- Langkah 2 : Melihat produk yang memberikan pendapatan tertinggi untuk masing-masing tahun

create table if not exists high_revenue_product_per_year as select year, product_category_name, round(revenue,2) as revenue from ( select YEAR(order_purchase_timestamp) as year, product_category_name, sum(price+freight_value) as revenue, rank() over(partition by YEAR(order_purchase_timestamp) order by sum(price + freight_value) desc) as rank from order_items i join orders o on o.order_id = i.order_id join product p on p.product_id = i.product_id where o.order_status = 'delivered' group by year,product_category_name) product_temp_table where rank = 1;

-- Langkah 3 : Melihat jumlah pembatalan pemesanan untuk masing-masing tahun

create table if not exists total_cancel_per_year select YEAR(order_purchase_timestamp) as year, count(1) as num_canceled_orders from orders where order_status = 'canceled' group by 1;

-- Langkah 4 : Melihat produk yang memiliki jumlah pembatalan pemesanan tertinggi untuk masing-masing tahun

create table if not exists most_canceled_product_order_per_year select year, product_category_name, num_of_canceled from ( select product_category_name, YEAR(order_purchase_timestamp) as year, count(2) as num_of_canceled, RANK() OVER ( PARTITION BY YEAR(order_purchase_timestamp) ORDER BY count(2) desc) as rank from orders as o join order_items as i on o.order_id = i.order_id join product as p on p.product_id = i.product_id where order_status = 'canceled' group by year, product_category_name ) as cancelled_product where rank = 1;

-- Langkah 5 : Menggabungkan informasi yang telah didapat ke dalam satu tabel
select a.year, a.revenue as revenue, b.product_category_name as product_high_revenue, b.revenue as total_revenue, d.num_canceled_orders as total_cancel_per_year, c.product_category_name as most_product_canceled, c.num_of_canceled as total_cancelled_order from total_revenue_per_year as a join high_revenue_product_per_year as b on a.year = b.year join most_canceled_product_order_per_year as c on b.year = c.year join total_cancel_per_year as d on c.year = d.year;