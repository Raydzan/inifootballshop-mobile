1. Jelaskan apa itu widget tree pada Flutter dan 
bagaimana hubungan parent-child (induk-anak) bekerja antar widget.

widget tree adalah susunan hierarki semua widget di layar. 
setiap widget (child) berada di dalam widget lain (parent).
constraint - down, size - up, paint - down.

2. Sebutkan semua widget yang kamu gunakan 
dalam proyek ini dan jelaskan fungsinya.

materialApp – root aplikasi Material Design
scaffold – kerangka halaman 
appBar – header judul
center / Padding / ConstrainedBox – memusatkan, memberi jarak, dan membatasi lebar konten
column & Wrap – menyusun widget secara vertikal
card – panel info dengan elevasi
text – menampilkan teks (judul, label)
sizedBox – mengatur lebar/tinggi tetap 
elevatedButton & Icon – tombol berikon
snackBar + ScaffoldMessenger – menampilkan pesan

3. Apa fungsi dari widget MaterialApp? 
Jelaskan mengapa widget ini sering digunakan sebagai widget root.

karena fungsi tersebut sebagai navigator dan route bawaan, tema Material (ThemeData), ikon, teks, animasi standar, dsb

4. Jelaskan perbedaan antara StatelessWidget 
dan StatefulWidget. Kapan kamu memilih salah satunya?

statelessWidget: tidak punya state internal yang berubah, 
UI murni dari input/konteks. cocok untuk kartu identitas, tombol menu statis
statefulWidget: punya objek state + setState() untuk memicu rebuild saat data berubah
pilih stateless kalau UInya tetap, pilih stateful kalau UI harus bereaksi terhadap perubahan data/waktu/interaksi

5. Apa itu BuildContext dan mengapa penting di Flutter? 
Bagaimana penggunaannya di metode build?

buildContext adalah address sebuah widget di dalam tree
Penting untuk lookup ke atas tree. di metode build(BuildContext context), 
kita menggunakan context itu untuk membaca tema, 
ukuran layar, navigator, hingga merender anak-anaknya

6. Jelaskan konsep "hot reload" di Flutter dan
bagaimana bedanya dengan "hot restart".

Hot reload: menyuntik perubahan kode ke VM tanpa reset state. 
cepat untuk ubah UI/teks/layout, initState tidak dipanggil ulang.
hot restart: reset seluruh state dan jalankan ulang dari main()
lebih lambat dari reload, tapi berguna saat perubahan butuh inisialisasi ulang
