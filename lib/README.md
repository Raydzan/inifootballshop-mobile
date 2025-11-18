1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?

jawaban: supaya data JSON dari Django punya struktur dan tipe yang jelas di sisi Flutter. Dengan model, setiap field punya tipe yang tegas (String, int, bool, dst.) sehingga:

Validasi tipe & null-safety lebih aman
Kesalahan seperti mengakses field yang tidak ada atau salah tipe akan ketahuan di waktu kompilasi, bukan tiba-tiba error saat runtime.

Autocomplete & refactor lebih mudah
IDE bisa membantu auto-complete (product.name, product.price, dll.) dan kalau nama field diubah, semua referensi bisa dirapikan sekaligus.

Kode lebih rapi dan mudah dirawat
Logika pemetaan JSON (fromJson) dan serialisasi (toJson) terkumpul di satu tempat, tidak tercecer di banyak Map<String, dynamic>.

Kalau langsung pakai Map<String, dynamic> tanpa model:

Kita mudah salah ketik key ("name" vs "nama"), tapi errornya baru muncul di runtime.

Tipe data tidak jelas (semua dynamic), sehingga rawan TypeError.

Null-safety jadi lemah karena kita sering pakai cast manual (as String) atau operator !.

Seiring proyek membesar, kode jadi sulit dibaca dan maintenance jadi lebih berat.

2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.

jawaban: http adalah package HTTP umum untuk melakukan request (GET/POST) ke endpoint tanpa state khusus.
Ia cocok untuk web service biasa yang tidak butuh login atau cookie, misalnya fetch data publik.

CookieRequest (dari pbp_django_auth) adalah wrapper HTTP yang menyimpan dan mengirim cookie/session Django secara otomatis.
Perannya khusus untuk:

proses login/register/logout ke Django,

memanggil endpoint yang butuh session user (misalnya /json-user/ atau /create-flutter/),

meng-handle request dengan credentials (cookie) tanpa harus mengelola header sendiri.

Jadi perbedaannya:

http → klien HTTP biasa, stateless, tidak otomatis simpan cookie.

CookieRequest → klien HTTP dengan state autentikasi Django (session & cookie) yang dipakai bersama antar-request di aplikasi Flutter.

Dalam implementasi saya, semua komunikasi yang berkaitan dengan login, pengambilan data user-scope, dan create produk dari Flutter ke Django menggunakan CookieRequest.

3.  Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

jawaban: Karena CookieRequest menyimpan status login + cookie. Kalau tiap widget punya instance sendiri-sendiri:

Status login jadi tidak konsisten.

Harus oper objek ke banyak constructor (ribet).

Dengan Provider di root:

Semua widget bisa pakai instance CookieRequest yang sama.

Perubahan login/logout langsung konsisten di seluruh aplikasi.

4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?

jawaban: 10.0.2.2 di ALLOWED_HOSTS: supaya emulator bisa akses server Django di laptop.

CORS diaktifkan + CORS_ALLOW_CREDENTIALS: supaya browser / Flutter web boleh mengirim request lintas origin beserta cookie.

CSRF_COOKIE_SAMESITE dan SESSION_COOKIE_SAMESITE di-set None + *_SECURE = True: supaya cookie tetap terkirim di konteks cross-site.

Izin internet di Android: supaya app bisa melakukan request HTTP keluar.

Kalau konfigurasi ini salah, efeknya: request diblokir (CORS error), host tidak diizinkan, cookie tidak terkirim, dan aplikasi seakan-akan selalu belum login.

5.   Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.

jawaban: Pengguna mengisi data (di Django atau lewat form Flutter).

Django memproses dan menyimpan ke database (model Product).

Django menyediakan endpoint JSON (mis. /json/, /json-user/).

Flutter memanggil endpoint tersebut dengan CookieRequest.get().

JSON di-decode ke model Product dan ditampilkan lewat widget (ListView, detail page, dll.).

6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.

jawaban:Register: Flutter kirim username + password ke /auth/register/ → Django validasi → buat user baru → kirim status ke Flutter.

Login: Flutter kirim kredensial ke /auth/login/ pakai CookieRequest.login() → Django autentikasi dan membuat session → cookie disimpan di CookieRequest → Flutter mengarahkan ke halaman utama.

Logout: Flutter memanggil /auth/logout/ → Django menghapus session → Flutter menghapus state login dan kembali ke halaman login.

7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).

jawaban:

Menambah app authentication di Django, membuat view login/register/logout berbasis JSON, dan endpoint JSON produk (/json/, /json-user/, /create-flutter/).

Mengatur settings.py: ALLOWED_HOSTS, CORS, dan pengaturan cookie supaya Flutter bisa mengakses Django dengan session.

Menambah dependency provider dan pbp_django_auth, lalu membungkus MaterialApp dengan Provider<CookieRequest> dan menjadikan Login sebagai halaman awal.

Membuat halaman Login & Register di Flutter yang memanggil endpoint Django dan mengubah tampilan berdasarkan hasil autentikasi.

Membuat model Dart Product dari struktur JSON Django, lalu membuat halaman list (All Products & My Products) dan halaman detail.

Menghubungkan form ProductFormPage dengan endpoint create-flutter sehingga produk baru tersimpan di database dan muncul di list.

Mengintegrasikan semuanya dengan menu dan drawer (My Products, All Products, Tambah Produk, dan Logout).
