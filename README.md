# Data Analysis E-Commerce Project: Menganalisis Performa Bisnis dengan SQL

Link Artikel : https://medium.com/@imransutee/data-analysis-for-e-commerce-menganalisis-performa-bisnis-dengan-sql-aa58ea86eaf8

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


## Analisis Pertumbuhan Aktivitas Pelanggan Tahunan

Melihat dan menganalisis apakah performa bisnis eCommerce dari sisi aktivitas customer mengalami pertumbuhan, stagnan atau bahkan mengalami penurunan dalam kurun waktu tahunan.

Adapun hasil dari query diatas dapat kita visualisasikan sebagai berikut:

![](https://miro.medium.com/max/830/1*9s04HWJia3KdSU-BZ_buQw.png)

Data dari tahun 2016 dimulai dari bulan September 2016 sedangkan data tahun 2017 dan 2018 semuanya tersedia 12 bulan, oleh sebab itu analisis terfokus pada tahun tersebut. Terlihat bahwa aktivitas customer bulanan dan juga customer baru mengalami peningkatan yang signifikan dengan persentase sekitar 44% dan 19%.

![](https://miro.medium.com/max/830/1*HLlL4ul4NWDQJBfuRr60gg.png)

Namun, untuk customer yang melakukan repeat order terjadi sebaliknya. Terlihat penurunan customer yang melakukan repeat order sekitar 7% hal ini menunjukkan ini tidak terlalu baik. Untuk rata-rata pemesanan sendiri tidak banyak berubah, customer hanya melakukan 1 kali pengorderan saja.

## Analisis Kualitas Kategori Produk Tahunan

Setelah selesai menganalisis aktivitas pertumbuhan pelanggan, pada tahap ini kita akan menganalisis produk yang memberikan pendapatan tertinggi dan juga melihat produk dengan pembatalan pemesanan terbanyak.

![](https://miro.medium.com/max/720/1*l3rGJbRnS3wiRXvAzTnyzw.png)

Dari grafik diatas diketahui bahwa **pendapatan perusahaan mengalami peningkatan** tiap tahun sebesar 22%.

![](https://miro.medium.com/max/1050/1*pE-hgJynuEeSC035L1FJDA.png)

Produk yang memberikan revenue terbanyak setiap tahunnya juga mengalami pergantian. Sejalan dengan peningkatan pendapatan, total pembatalan pemesanan juga mengalami peningkatan. Hal yang paling menarik adalah pada tahun 2018, produk _health&beauty_ yang merupakan memberikan revenue dan pembatalan terbanyak sekaligus.

## Analisis Penggunaan Jenis Pembayaran Tahunan

Setelah selesai menganalisis produk, pada tahap terakhir ini kita akan menganalisis jenis pembayaran yang menjadi favorit customer.

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
