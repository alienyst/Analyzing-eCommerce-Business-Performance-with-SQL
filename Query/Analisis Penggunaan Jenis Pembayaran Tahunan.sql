-- Langkah 1 : Menampilkan jumlah penggunaan masing-masing tipe pembayaran secara all time diurutkan dari yang terfavorit

select payment_type, count(payment_type) as num_used from order_payments op join orders o on o.order_id = op.order_id group by payment_type order by count(payment_type) DESC;

-- Langkah 2 : Menampilkan detail informasi jumlah penggunaan masing-masing tipe pembayaran untuk setiap tahun

with payment_temp_table as ( select YEAR(order_purchase_timestamp) as year, payment_type, count(1) as num_used from order_payments op join orders o on o.order_id = op.order_id group by year, payment_type) select *, round((y_2018-y_2017)/y_2017,2) as pct_change from( select payment_type, sum(case when year = '2016' then num_used else 0 end) as y_2016, sum(case when year = '2017' then num_used else 0 end) as y_2017, sum(case when year = '2018' then num_used else 0 end) as y_2018 from payment_temp_table group by payment_type) pivot_payment order by pct_change desc;