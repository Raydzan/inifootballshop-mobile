1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. 
Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?

Navigator.push() menambahkan halaman baru ke atas stack navigasi. Halaman sebelumnya tetap 
ada sehingga pengguna bisa kembali dengan tombol back.Navigator.push() menambahkan halaman baru
ke atas stack navigasi. Halaman sebelumnya tetap ada sehingga pengguna bisa kembali dengan tombol back.

Navigator.pushReplacement() mengganti halaman yang sedang ditampilkan dengan halaman baru. 
Halaman sebelumnya di-remove dari stack sehingga tidak bisa kembali ke halaman lama dengan back.
contohnya, halaman tidak menumpuk ketika pengguna berpindah-pindah antara “Halaman Utama” dan “Tambah Produk”

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk 
membangun struktur halaman yang konsisten di seluruh aplikasi?

Saya menggunakan Scaffold sebagai kerangka utama setiap halaman agar struktur halaman konsisten. Di dalam Scaffold saya menambahkan:
appBar: AppBar() untuk menampilkan judul aplikasi dan identitas (misalnya nama/NPM/kelas),
drawer: const LeftDrawer() untuk menyediakan navigasi samping ke halaman-halaman penting (Halaman Utama dan Tambah Produk),
body: untuk isi halaman (misalnya grid menu atau form produk).

3. Bagaimana kamu memanfaatkan hierarchy widget seperti 
Scaffold, AppBar, dan Drawer untuk membangun struktur halaman 
yang konsisten di seluruh aplikasi?

Pada halaman form, saya membungkus isi form dengan SingleChildScrollView supaya form tetap bisa discroll ketika layar kecil atau keyboard muncul. 
Tanpa scroll, form bisa overflow dan muncul error. Setiap TextFormField saya bungkus dengan Padding agar jarak antar field rapi dan mudah dibaca. Jika nanti jumlah field makin banyak atau ingin menampilkan daftar dinamis, widget seperti ListView juga cocok karena otomatis bisa discroll dan mengatur anak-anaknya secara vertikal

4. Bagaimana kamu menyesuaikan warna tema agar 
aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

Saya mengatur tema di MaterialApp dengan memberikan ThemeData dan ColorScheme.fromSeed() 
menggunakan warna utama (misalnya biru/indigo) agar sesuai dengan identitas “Football Shop”

5. 



6. 

