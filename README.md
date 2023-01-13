# Data Analysis E-Commerce Project: Menganalisis Performa Bisnis dengan SQL

Link : https://medium.com/@imransutee/data-analysis-for-e-commerce-menganalisis-performa-bisnis-dengan-sql-aa58ea86eaf8

## Latar Belakang

Sebagai seorang data analyst di sebuah perusahaan e-commerce diperlukan analisis pada metrik-metrik bisnis yang dianggap penting. Untuk membuat laporan performa bisnis, metrik-metrik bisnis tersebut berupa aktivitas pelanggan, kualitas produk dan tren pembayaran. Data yang digunakan adalah data historis pemesanan dari tahun 2016 hingga tahun 2018. Data tersebut berasal dari [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) dengan terdiri dari 8 tabel yaitu :

-   _Customers_ berisi tentang data pelanggan
-   _Geolocation_ berisi tentang lokasi pelanggan
-   _Order_items_ berisi tentang item yang dipesan
-   _Order_payments_ berisi tentang pembayaran pemesanan
-   _Order_reviews_ berisi tentang komentar tentang pemesanan
-   _Orders_ berisi tentang pesanan
-   _Product_ berisi tentang produk/barang
-   _Sellers_ berisi tentang data penjual

Adapun pertanyaan-pertanyaan yang harus dijawab antara lain:

-   Rata-rata jumlah customer aktif bulanan untuk masing-masing tahun beserta jumlah customer baru, jumlah customer yang melakukan pembelian lebih dari satu kali (_repeat order_) dan Rata-rata jumlah order yang dilakukan customer.
-   Pendapatan perusahaan total untuk masing-masing tahun beserta jumlah cancel order total, kategori produk yang memberikan pendapatan total tertinggi dan jumlah cancel order tertinggi.
-   Menampilkan jumlah penggunaan masing-masing tipe pembayaran dari yang tertinggi dan jumlah penggunaannya untuk setiap tahun.

Pada proyek kali ini tools yang saya gunakan adalah MySQL untuk mengolah data dan Excel sebagai visualisasi data.

## Tahap 1 : Persiapan Data

Sebelum melakukan pemrosesan data, tahap pertama yang harus dilakukan adalah membuat data mentah menjadi siap diolah.

**Langkah 1** : Pembuatan database beserta tabel, dapat menggunakan CREATE statement, dengan memperhatikan tipe data dari setiap kolom.

> `_create database ecommerce_db;_`  
> `_use ecommerce_db;_`

Terdapat 8 dataset yang berformat .csv, maka kita akan membuat 8 tabel beserta tipe data yang sesuai untuk menyimpan data tersebut.

> `_-- pembuatan tabel product  
> CREATE TABLE IF NOT EXISTS product( col_index INT, product_id VARCHAR(250) PRIMARY KEY, product_category_name VARCHAR(250), product_name_length INT, product_description_lenght INT, product_photos_qty INT, product_weight_g INT, product_length_cm INT, product_height_cm INT, product_width_cm INT );_`
> 
> `_-- pembuatan table geolocation  
> CREATE TABLE IF NOT EXISTS geolocation( geolocation_zip_code_prefix VARCHAR(250), geolocation_lat VARCHAR(250), geolocation_lng VARCHAR(250), geolocation_city VARCHAR(250), geolocation_state VARCHAR(250) );_`
> 
> `_-- pembuatan table customers  
> CREATE TABLE IF NOT EXISTS customers( customer_id VARCHAR(250) PRIMARY KEY, customer_unique_id VARCHAR(250), customer_zip_code_prefix INT, customer_city VARCHAR(250), customer_state VARCHAR(250) );_`
> 
> `_-- pembuatan tabel seller  
> CREATE TABLE IF NOT EXISTS seller( seller_id VARCHAR(250) PRIMARY KEY, seller_zip_code_prefix INT, seller_city VARCHAR(250), seller_state VARCHAR(250) );_`
> 
> `_-- pembuatan tabel orders  
> CREATE TABLE IF NOT EXISTS orders( order_id VARCHAR(250) PRIMARY KEY, customer_id VARCHAR(250), order_status VARCHAR(250), order_purchase_timestamp DATETIME, order_approved_at DATETIME, order_delivered_carrier_date DATETIME, order_delivered_customer_date DATETIME, order_estimated_delivery_date DATETIME );_`
> 
> `_-- pembuatan table order_items  
> CREATE TABLE IF NOT EXISTS order_items( order_id VARCHAR(250), order_item_id INT, product_id VARCHAR(250), seller_id VARCHAR(250), shipping_limit_date DATETIME, price FLOAT, freight_value FLOAT );_`
> 
> `_-- pembuatan tabel order_payments  
> CREATE TABLE IF NOT EXISTS order_payments( order_id VARCHAR(250), payment_sequential INT, payment_type VARCHAR(250), payment_installments INT, payment_value FLOAT );_`
> 
> `_-- pembuatan table order_reviews  
> CREATE TABLE IF NOT EXISTS order_reviews( review_id VARCHAR(250), order_id VARCHAR(250), review_score INT, review_comment_title TEXT, review_comment_message TEXT, review_creation_date DATETIME, review_answer_timestamp DATETIME );_`

**Langkah 2** : Importing data csv ke dalam database menggunakan LOAD DATA INFILE statement. Dalam mengimpor data csv ke database, tipe data dari kolom di database harus sama dan path folder penyimpanan dataset harus lengkap.

> `_-- import product_dataset.csv  
> LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/product_dataset.csv' INTO TABLE product FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;_`
> 
> `_-- import customers_dataset.csv  
> LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/customers_dataset.csv' INTO TABLE customers FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;_`
> 
> `_-- import geolocation_dataset.csv  
> LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/geolocation_dataset.csv' INTO TABLE geolocation FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;_`
> 
> `_-- import orders_dataset.csv  
> LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/orders_dataset.csv' INTO TABLE orders FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;_`
> 
> `_-- import sellers_dataset.csv  
> LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/sellers_dataset.csv' INTO TABLE seller FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;_`
> 
> `_-- import order_items_dataset.csv  
> LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/order_items_dataset.csv' INTO TABLE order_items FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;_`
> 
> `_-- import order_payments_dataset.csv  
> LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/order_payments_dataset.csv' INTO TABLE order_payments FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;_`
> 
> `_-- import order_reviews_dataset.csv  
> LOAD DATA INFILE 'D:/Raka/RDS/3 SQL 2/VIX/1/Dataset/order_reviews_dataset.csv' INTO TABLE order_reviews FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;_`

**Langkah 3** : Memodifikasi data dengan menambahkan foreign key untuk menunjukkan hubungan antar tabel, dapat menggunakan ALTER statement, kemudian membuat Entity Relationship Diagram (ERD).

> `_-- drop col_index pada tabel product karena tidak dibutuhkan  
> ALTER TABLE product DROP COLUMN col_index;_`
> 
> `_-- menghubungkan orders dan customers berdasarkan customer_id  
> ALTER TABLE orders ADD CONSTRAINT fk_orders FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE;_`
> 
> `_-- menghubungkan order_item dan orders berdasarkan order_id  
> ALTER TABLE order_items ADD CONSTRAINT fk_order_items FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE;_`
> 
> `_-- menghubungkan order_items dengan product_id berdasarkan product_id  
> ALTER TABLE order_items ADD CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE ON UPDATE CASCADE;_`
> 
> `_-- menghubungkan order_payments dengan order berdasarkan order_id  
> ALTER TABLE order_payments ADD CONSTRAINT fk_order_payments FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE;_`
> 
> `_-- menghubungkan order_reviews dengan order berdasarkan order_id  
> ALTER TABLE order_reviews ADD CONSTRAINT fk_order_reviews FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE;_`

Keterangan : untuk _geolocation_zip_prefix, order_items_id_, dan _review_id_ tidak bisa dibuat primary key karena terdapat data duplikat. sedangkan pada tabel order_payments tidak ada nilai unik yang dijadikan sebagai primary.

![](https://miro.medium.com/max/1050/1*Yiz6MpSD33OGY_Zqd6-lbQ.jpeg)

ERD dari Dataset

## Tahap 2 : Analisis Pertumbuhan Aktivitas Pelanggan Tahunan

Melihat dan menganalisis apakah performa bisnis eCommerce dari sisi aktivitas customer mengalami pertumbuhan, stagnan atau bahkan mengalami penurunan dalam kurun waktu tahunan.

**Langkah 1** : Melihat rata-rata jumlah customer aktif bulanan setiap tahun

> `SELECT year, ROUND(AVG(total_cust),2) as average_mau from( SELECT MONTH(order_purchase_timestamp) as month, YEAR(order_purchase_timestamp) as year, COUNT(DISTINCT customer_unique_id) as total_cust FROM orders as o JOIN customers as c ON o.customer_id = c.customer_id GROUP BY month, year ORDER BY year ) total_cust_temp_table group by year;`

![](https://miro.medium.com/max/234/1*rwynnf9DNDdjizjMgyVy5Q.png)

Rata-rata jumlah customer aktif bulanan tiap tahun

**Langkah 2** : Menampilkan jumlah customer baru pada masing-masing tahun. Diamsusikan bahwa customer baru adalah customer yang melakukan order pertama kali (dapat diambil menggunakan MIN statement pada kolom _order_purchase_timestamp_)

> `select YEAR(first_bought) as year, count(1) as new_cust from (select customer_unique_id, min(order_purchase_timestamp) as first_bought from orders as o join customers as c on o.customer_id = c.customer_id group by customer_unique_id ) first_bought_temp_table group by year;`

![](https://miro.medium.com/max/197/1*-x6yEcv29f6wDO1fWjujDw.png)

Customer baru tiap tahun

**Langkah 3** : Melihat jumlah customer yang melakukan pembelian lebih dari satu kali (_repeat order_) pada masing-masing tahun.

> `select year, count(distinct customer_unique_id) as repeat_cust from( select YEAR(order_purchase_timestamp) as year, customer_unique_id, count(1) as jumlah_pembelian from orders as o join customers as c on o.customer_id = c.customer_id group by customer_unique_id, year having count(jumlah_pembelian) > 1 ) as repeat_cust_temp group by year;`

![](https://miro.medium.com/max/215/1*vdqFBBEnuD6ucaRxS14HsQ.png)

Jumlah dari repeat order pada masing-masing tahun.

**Langkah 4** : Melihat rata-rata jumlah order yang dilakukan customer untuk masing-masing tahun.

> `select year, round(avg(jumlah_pembelian),2) as total_order from( select YEAR(order_purchase_timestamp) as year, customer_unique_id, count(1) as jumlah_pembelian from orders as o join customers as c on o.customer_id = c.customer_id group by customer_unique_id, year ) as total_order group by year;`

![](https://miro.medium.com/max/203/1*rJklZhee5YM-GeJNscxqIg.png)

Tabel Rata-rata Total Order Customer tiap Tahun

**Langkah 5** : Menggabungkan ketiga metrik yang telah berhasil ditampilkan menjadi satu tampilan tabel

> `WITH mau_table AS( [SELECT](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/select.html) [year](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html), ROUND([AVG](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_avg)(total_cust),2) as average_mau from ( [SELECT](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/select.html) MONTH(order_purchase_timestamp) as MONTH, [YEAR](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html)(order_purchase_timestamp) as [year](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html), [COUNT](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_count)(DISTINCT customer_unique_id) as total_cust FROM orders AS o JOIN customers as c ON o.customer_id = c.customer_id GROUP BY month, [year](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html) ) total_cust_temp_table group by [year](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html) ), new_cust AS( [select](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/select.html) [YEAR](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html)(first_bought) as [year](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html), [count](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_count)(1) as new_cust from ( [select](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/select.html) customer_unique_id, [min](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_min)(order_purchase_timestamp) as first_bought from orders AS o join customers as c on o.customer_id = c.customer_id group by customer_unique_id ) first_bought_temp_table group by [year](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html) ), repeat_cust AS( [select](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/select.html) [YEAR](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html), [count](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_count)(distinct customer_unique_id) as repeat_cust from ( [select](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/select.html) [YEAR](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html)(order_purchase_timestamp) as [year](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html), customer_unique_id, [count](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_count)(1) as jumlah_pembelian from orders as o join customers as c on o.customer_id = c.customer_id group by customer_unique_id, [year](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html) having [count](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_count)(jumlah_pembelian) > 1 ) repeat_cust_temp group by [year](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html) ), avg_order AS ( [select](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/select.html) [year](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html), round([avg](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_avg)(jumlah_pembelian),2) as avg_order from ( [select](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/select.html) [YEAR](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html)(order_purchase_timestamp) as [year](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html), customer_unique_id, [count](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html#function_count)(1) as jumlah_pembelian from orders as o join customers as c on o.customer_id = c.customer_id group by customer_unique_id, [year](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html) ) total_order group by [year](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html) ) [SELECT](http://localhost/phpmyadmin/url.php?url=https://dev.mysql.com/doc/refman/8.0/en/select.html) a.year, a.average_mau, b.new_cust, c.repeat_cust, d.avg_order FROM mau_table a JOIN new_cust b ON a.year = b.year JOIN repeat_cust c ON a.year = c.year JOIN avg_order d ON a.year = d.year;`

![](https://miro.medium.com/max/926/1*yl1lZ8OCKXK6ofzZdpVxgQ.png)

Aktivitas Pelanggan

Adapun hasil dari query diatas dapat kita visualisasikan sebagai berikut:

![](https://miro.medium.com/max/830/1*9s04HWJia3KdSU-BZ_buQw.png)

Grafik Peningkatan Rata-rata customer aktif bulanan dan customer baru

Data dari tahun 2016 dimulai dari bulan September 2016 sedangkan data tahun 2017 dan 2018 semuanya tersedia 12 bulan, oleh sebab itu analisis terfokus pada tahun tersebut. Terlihat bahwa aktivitas customer bulanan dan juga customer baru mengalami peningkatan yang signifikan dengan persentase sekitar 44% dan 19%.

![](https://miro.medium.com/max/830/1*HLlL4ul4NWDQJBfuRr60gg.png)

Penurunan customer yang melakukan repeat orders

Namun, untuk customer yang melakukan repeat order terjadi sebaliknya. Terlihat penurunan customer yang melakukan repeat order sekitar 7% hal ini menunjukkan ini tidak terlalu baik. Untuk rata-rata pemesanan sendiri tidak banyak berubah, customer hanya melakukan 1 kali pengorderan saja.

## Tahap 3 : Analisis Kualitas Kategori Produk Tahunan

Setelah selesai menganalisis aktivitas pertumbuhan pelanggan, pada tahap ini kita akan menganalisis produk yang memberikan pendapatan tertinggi dan juga melihat produk dengan pembatalan pemesanan terbanyak.

**Langkah 1** : Melihat total pendapatan perusahaan untuk setiap tahunnya.

> `create table if not exists total_revenue_per_year as select year, round(sum(revenue),2) as revenue from( select YEAR(order_purchase_timestamp) as year, price+freight_value as revenue from orders as o join order_items as i on o.order_id = i.order_id where order_status = 'delivered' order by year, revenue ) revenue_table_temp group by year;`

![](https://miro.medium.com/max/210/1*qbYCZOZZA_EDbF63RzrMAg.png)

Rata-rata pendapatan perusahaan tiap tahun.

**Langkah 2** : Melihat produk yang memberikan pendapatan tertinggi untuk masing-masing tahun

> `create table if not exists high_revenue_product_per_year as select year, product_category_name, round(revenue,2) as revenue from ( select YEAR(order_purchase_timestamp) as year, product_category_name, sum(price+freight_value) as revenue, rank() over(partition by YEAR(order_purchase_timestamp) order by sum(price + freight_value) desc) as rank from order_items i join orders o on o.order_id = i.order_id join product p on p.product_id = i.product_id where o.order_status = 'delivered' group by year,product_category_name) product_temp_table where rank = 1;`

![](https://miro.medium.com/max/501/1*JgSune1e5GL3Q3SGdZoILA.png)

Produk dengan pendapatan tertinggi tiap tahun

**Langkah 3** : Melihat jumlah pembatalan pemesanan untuk masing-masing tahun

> `create table if not exists total_cancel_per_year select YEAR(order_purchase_timestamp) as year, count(1) as num_canceled_orders from orders where order_status = 'canceled' group by 1;`

![](https://miro.medium.com/max/344/1*ebF5BQzC_HCIDVuXNaG75w.png)

Jumlah pembatalan pemesanan tertinggi tiap tahun

**Langkah 4** : Melihat produk yang memiliki jumlah pembatalan pemesanan tertinggi untuk masing-masing tahun

> `create table if not exists most_canceled_product_order_per_year select year, product_category_name, num_of_canceled from ( select product_category_name, YEAR(order_purchase_timestamp) as year, count(2) as num_of_canceled, RANK() OVER ( PARTITION BY YEAR(order_purchase_timestamp) ORDER BY count(2) desc) as rank from orders as o join order_items as i on o.order_id = i.order_id join product as p on p.product_id = i.product_id where order_status = 'canceled' group by year, product_category_name ) as cancelled_product where rank = 1;`

![](https://miro.medium.com/max/593/1*vxqsI-RyyWCfGiSgiPyidg.png)

Produk dengan pembatalan pemesanan tertinggi tiap tahun

**Langkah 5** : Menggabungkan informasi yang telah didapat ke dalam satu tabel

> `select a.year, a.revenue as revenue, b.product_category_name as product_high_revenue, b.revenue as total_revenue, d.num_canceled_orders as total_cancel_per_year, c.product_category_name as most_product_canceled, c.num_of_canceled as total_cancelled_order from total_revenue_per_year as a join high_revenue_product_per_year as b on a.year = b.year join most_canceled_product_order_per_year as c on b.year = c.year join total_cancel_per_year as d on c.year = d.year;`

![](https://miro.medium.com/max/1050/1*cIB2tpvlhcPiU8v7x7O-EA.png)

Tabel Produk dengan Revenue dan Pembatalan Tertinggi

![](https://miro.medium.com/max/720/1*l3rGJbRnS3wiRXvAzTnyzw.png)

Grafik pendapatan perusahaan tiap tahun

Dari grafik diatas diketahui bahwa **pendapatan perusahaan mengalami peningkatan** tiap tahun sebesar 22%.

![](https://miro.medium.com/max/1050/1*pE-hgJynuEeSC035L1FJDA.png)

Produk dengan revenue dan pembatalan tertinggi

Produk yang memberikan revenue terbanyak setiap tahunnya juga mengalami pergantian. Sejalan dengan peningkatan pendapatan, total pembatalan pemesanan juga mengalami peningkatan. Hal yang paling menarik adalah pada tahun 2018, produk _health&beauty_ yang merupakan memberikan revenue dan pembatalan terbanyak sekaligus.

## Tahap 4 : Analisis Penggunaan Jenis Pembayaran Tahunan

Setelah selesai menganalisis produk, pada tahap terakhir ini kita akan menganalisis jenis pembayaran yang menjadi favorit customer.

**Langkah 1** : Menampilkan jumlah penggunaan masing-masing tipe pembayaran secara all time diurutkan dari yang terfavorit

> `select payment_type, count(payment_type) as num_used from order_payments op join orders o on o.order_id = op.order_id group by payment_type order by count(payment_type) desc;`

![](https://miro.medium.com/max/341/1*Q165vsY2yGtBiHS-wOEXEA.png)

Jenis pembayaran terfavorit secara all time

**Langkah 2** : Menampilkan detail informasi jumlah penggunaan masing-masing tipe pembayaran untuk setiap tahun

> `with payment_temp_table as ( select YEAR(order_purchase_timestamp) as year, payment_type, count(1) as num_used from order_payments op join orders o on o.order_id = op.order_id group by year, payment_type) select *, round((y_2018-y_2017)/y_2017,2) as pct_change from( select payment_type, sum(case when year = '2016' then num_used else 0 end) as y_2016, sum(case when year = '2017' then num_used else 0 end) as y_2017, sum(case when year = '2018' then num_used else 0 end) as y_2018 from payment_temp_table group by payment_type) pivot_payment order by pct_change desc;`

![](https://miro.medium.com/max/644/1*A3MbOhYnZwoKgxrQIxt4og.png)

Jumlah dari masing-masing tipe pembayaran tiap tahun

Secara keseluruhan, tipe pembayaran yang paling terfavorit di kalangan customer adalah credit card dengan peningkatan pemakaian sekitar 21%. Yang menarik adalah penggunaan debit card meningkat secara signifikan 100% lebih. Dan alternatif lain adalah boleto, boleto adalah metode pembayaran tunai yang populer di Brazil. Customer yang tidak mempunyai rekening/kartu kredit biasanya akan memilih boleto. Di sisi lain penggunaan voucher menurun sebesar 10%, kemungkinan meningkatnya tren penggunakan jenis pembayaran lain, diperlukan analisis lebih lanjut untuk mengkonfirmasi hal ini.

## Kesimpulan

1.  Aktivitas customer bulanan mengalami peningkatan yang signifikan dengan persentase sebesar 44%.
2.  Peningkatan customer baru sebesar 19%.
3.  Penurunan customer yang melakukan repeat order sekitar 7% hal ini menunjukkan ini tidak terlalu baik.
4.  Rata-rata customer hanya melakukan 1 kali pengorderan saja.
5.  Pendapatan perusahaan mengalami peningkatan tiap tahun sebesar 22%.
6.  Produk yang memberikan revenue terbanyak setiap tahunnya mengalami pergantian.
7.  Hal yang paling menarik adalah pada tahun 2018, produk health&beauty yang merupakan memberikan revenue sekaligus pembatalan terbanyak
8.  Secara keseluruhan, tipe pembayaran yang paling terfavorit di kalangan customer adalah credit card dengan peningkatan pemakaian sekitar 21%.
9.  Di sisi lain penggunaan voucher menurun sebesar 10%.
