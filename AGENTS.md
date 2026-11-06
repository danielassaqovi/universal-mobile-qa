# AGENT.md
# DEVELOPMENT RULES — UNIVERSAL MOBILE AUTOMATION TESTING FRAMEWORK

## 1. IDENTITAS PROJECT

Nama project: **Universal Mobile Automation Testing Framework**

Project ini bertujuan membangun framework automation testing untuk berbagai aplikasi mobile Android menggunakan pendekatan modular, reusable, configurable, dan extensible.

Framework harus dapat digunakan untuk menguji berbagai aplikasi Android, dengan prioritas dukungan terhadap aplikasi berbasis Flutter.

Project ini bukan aplikasi mobile untuk pengguna akhir, bukan platform monitoring, dan bukan layanan QA berbasis cloud.

## 2. TUJUAN UTAMA

Seluruh aktivitas development WAJIB berorientasi pada tujuan berikut:

1. Membangun core framework automation testing yang reusable.
2. Menyediakan generic test suite untuk pengujian aplikasi Android.
3. Menyediakan konfigurasi agar aplikasi baru dapat ditambahkan tanpa mengubah core framework.
4. Mengintegrasikan Flutter, Patrol, Integration Test, Android SDK, dan ADB.
5. Menjalankan automation testing melalui Docker.
6. Mendukung pengujian menggunakan perangkat Android fisik.
7. Menghasilkan laporan pengujian dalam format HTML dan JUnit XML.
8. Menyediakan CLI untuk menjalankan dan mengelola proses testing.
9. Menyediakan dokumentasi penggunaan framework.

**Setiap fitur yang dikembangkan harus mendukung setidaknya salah satu tujuan di atas.**

Jika suatu fitur tidak memiliki hubungan langsung dengan tujuan project, jangan implementasikan.

## 3. BATASAN SCOPE DEVELOPMENT

### 3.1 HAL YANG BOLEH DIKERJAKAN

Agent DIPERBOLEHKAN untuk:

- Membuat dan mengembangkan struktur core framework.
- Membuat modul device detection dan ADB management.
- Membuat modul app launching dan app termination.
- Membuat reusable UI interaction utilities.
- Membuat assertion dan validation utilities.
- Membuat generic test suite.
- Membuat mekanisme custom test suite.
- Membuat konfigurasi aplikasi menggunakan YAML atau JSON.
- Membuat konfigurasi environment testing.
- Membuat Dockerfile dan Docker Compose.
- Mengintegrasikan Flutter SDK, Dart, Patrol, dan Android SDK.
- Membuat CLI untuk menjalankan framework.
- Membuat screenshot dan log collection.
- Membuat report generator.
- Menghasilkan HTML report dan JUnit XML.
- Membuat contoh implementasi test suite aplikasi klasifikasi penyakit buah naga.
- Membuat unit test untuk memvalidasi fungsi internal framework.
- Membuat dokumentasi teknis dan panduan penggunaan.
- Melakukan refactoring apabila diperlukan untuk meningkatkan stabilitas, modularitas, dan maintainability.

### 3.2 HAL YANG TIDAK BOLEH DIKERJAKAN

Agent DILARANG untuk:

1. Mengubah tujuan utama project menjadi aplikasi QA dashboard atau aplikasi monitoring.
2. Membuat sistem SaaS atau layanan automation testing berbasis cloud.
3. Membuat website frontend atau dashboard admin yang tidak diperlukan untuk menjalankan framework.
4. Membuat sistem manajemen pengguna, autentikasi, registrasi, dan role management.
5. Menambahkan database server seperti MySQL, PostgreSQL, atau MongoDB tanpa kebutuhan teknis yang benar-benar diperlukan.
6. Menambahkan fitur AI untuk menganalisis screenshot atau memprediksi bug.
7. Mengembangkan sistem visual testing berbasis computer vision yang berada di luar kebutuhan awal.
8. Mengintegrasikan layanan berbayar atau API eksternal yang tidak diperlukan.
9. Membuat sistem remote device farm.
10. Menambahkan dukungan iOS atau platform lain pada tahap awal.
11. Membuat fitur deployment aplikasi ke Play Store.
12. Membuat aplikasi Android baru sebagai bagian dari core framework.
13. Mengubah framework menjadi tool khusus untuk aplikasi klasifikasi penyakit buah naga.
14. Menambahkan fitur yang hanya berguna untuk satu aplikasi ke dalam core framework.
15. Mengimplementasikan fitur tambahan hanya karena dianggap menarik atau modern.

Jika menemukan ide pengembangan di luar scope, cukup dokumentasikan sebagai rekomendasi pengembangan masa depan. Jangan langsung mengimplementasikannya.

## 4. ATURAN ARSITEKTUR

Gunakan prinsip modular architecture dan separation of concerns.

Komponen project harus memiliki tanggung jawab yang jelas.

### Core Framework

Core hanya berisi fungsi umum yang dapat digunakan oleh berbagai aplikasi.

Contohnya:
- Device management.
- ADB communication.
- Application management.
- UI interaction.
- Assertions.
- Screenshot management.
- Logging.
- Test execution.
- Reporting.

Core tidak boleh berisi nama package, halaman, tombol, maupun alur bisnis aplikasi tertentu.

### Generic Test Suite

Berisi skenario pengujian umum yang dapat digunakan kembali.

Contohnya:
- Application launch.
- Application stability.
- UI element validation.
- Navigation.
- Form input.
- Input validation.
- Permission.
- Lifecycle.
- Network handling.

Generic test harus menggunakan konfigurasi aplikasi dan tidak boleh bergantung pada satu aplikasi tertentu.

### Custom Test Suite

Berisi skenario pengujian khusus untuk aplikasi tertentu.

Setiap aplikasi harus memiliki folder, konfigurasi, dan test suite sendiri.

Contoh:

- Dragon Fruit Classification.
- E-Commerce Application.
- Education Application.
- Inventory Management Application.

Contoh tersebut tidak berarti seluruh aplikasi harus langsung dibuatkan implementasinya.

Cukup sediakan mekanisme agar aplikasi baru dapat ditambahkan dengan mudah.

## 5. ATURAN UNIVERSALITAS

Universalitas merupakan prinsip utama project.

Agent WAJIB memastikan:

- Tidak ada package name aplikasi yang di-hardcode dalam core.
- Tidak ada nama halaman atau tombol tertentu yang di-hardcode dalam core.
- Tidak ada alur bisnis aplikasi tertentu di dalam generic test.
- Konfigurasi aplikasi dipisahkan dari implementasi framework.
- Custom test tidak mengubah fungsi core.
- Penambahan aplikasi baru cukup melalui konfigurasi, adapter, dan test suite yang sesuai.

Gunakan abstraction atau adapter apabila terdapat perbedaan karakteristik antara aplikasi Flutter dan aplikasi Android non-Flutter.

Jangan mengklaim Patrol dapat menguji seluruh aplikasi Android secara langsung.

Untuk aplikasi non-Flutter, gunakan runner atau adapter yang sesuai dengan kemampuan teknologinya.

## 6. ATURAN TEKNOLOGI

Gunakan teknologi sesuai kebutuhan awal:

| Teknologi | Fungsi |
|---|---|
| Flutter SDK | Framework testing berbasis Flutter |
| Dart | Bahasa pemrograman |
| Patrol | UI automation dan native interaction |
| Flutter Integration Test | Integration testing |
| Android SDK | Android build dan testing |
| ADB | Komunikasi perangkat |
| Java JDK | Kebutuhan Android tooling |
| Docker | Environment testing |
| Docker Compose | Pengelolaan container |
| YAML / JSON | Konfigurasi aplikasi |
| JUnit XML | Hasil pengujian terstruktur |
| HTML | Laporan pengujian |

Agent tidak diperbolehkan mengganti teknologi utama tanpa alasan kompatibilitas yang kuat.

Jika terdapat dependency yang tidak kompatibel:
1. Identifikasi penyebabnya.
2. Periksa versi dependency.
3. Cari kombinasi versi yang kompatibel.
4. Dokumentasikan perubahan.
5. Jangan mengganti keseluruhan stack secara sepihak.

## 7. ATURAN DOCKER DAN ADB

Docker harus berfungsi sebagai environment automation testing.

ADB server tetap berjalan pada Linux host.

Container menggunakan koneksi ke ADB server host melalui port 5037.

Agent WAJIB:

- Memeriksa konektivitas ADB.
- Memeriksa status perangkat.
- Memeriksa device authorization.
- Memeriksa informasi perangkat.
- Memberikan error yang jelas jika perangkat tidak tersedia.
- Tidak menganggap perangkat berhasil terhubung sebelum pemeriksaan berhasil.

Agent DILARANG:

- Mengubah konfigurasi sistem Linux tanpa persetujuan.
- Menghentikan ADB server host secara otomatis tanpa alasan dan persetujuan.
- Melakukan factory reset perangkat.
- Menghapus data pengguna perangkat.
- Melakukan tindakan destruktif.
- Mengubah permission sistem secara sembarangan.

Semua konfigurasi Docker harus berada di dalam folder project.

## 8. BATASAN CONTOH APLIKASI

Aplikasi klasifikasi penyakit tanaman buah naga hanya digunakan sebagai contoh implementasi custom test suite.

Skenario yang diperbolehkan:

- Membuka aplikasi.
- Memilih gambar.
- Menjalankan klasifikasi.
- Memastikan hasil klasifikasi muncul.
- Menguji gambar tidak valid.
- Menguji tombol kembali.
- Menguji fitur coba lagi.

Kelas hasil klasifikasi:
- Black Rot.
- Fungi.
- Healthy Fruit.
- Healthy Leaf.
- Rust.
- Scab.
- Stem Canker.
- Sunburn.

Seluruh implementasi khusus tersebut wajib berada di folder:

`test_suites/examples/dragon_fruit/`

Jangan memasukkan logika klasifikasi buah naga ke dalam core framework.

Jangan membuat ulang model machine learning, dataset, atau backend klasifikasi karena bukan tanggung jawab project ini.

## 9. ATURAN CLI

CLI hanya digunakan untuk mengoperasikan framework.

Command utama:

- `mobileqa device-check`
- `mobileqa list-apps`
- `mobileqa add-app`
- `mobileqa test --app <nama_aplikasi>`
- `mobileqa test --app <nama_aplikasi> --suite generic`
- `mobileqa test --app <nama_aplikasi> --suite custom`
- `mobileqa report`

Setiap command harus memiliki fungsi nyata.

Jangan membuat command tambahan yang tidak diperlukan.

Jangan membuat CLI menjadi aplikasi interaktif yang kompleks jika command sederhana sudah mencukupi.

## 10. ATURAN REPORTING

Laporan hanya berisi informasi yang benar-benar diperoleh dari proses pengujian.

Informasi minimal:
- Nama aplikasi.
- Waktu pengujian.
- Informasi perangkat.
- Total test case.
- Passed.
- Failed.
- Skipped.
- Durasi.
- Detail error.
- Screenshot.
- Log.

Agent DILARANG:

- Membuat hasil pengujian palsu.
- Mengubah status failed menjadi passed.
- Membuat screenshot dummy seolah-olah hasil pengujian.
- Mengarang informasi perangkat.
- Menghasilkan laporan sukses ketika pengujian belum dijalankan.

Jika pengujian tidak dapat dilakukan karena perangkat tidak tersedia, tampilkan status yang sesuai dan jelaskan penyebabnya.

## 11. ATURAN WORKFLOW DEVELOPMENT

Sebelum mengembangkan fitur:

1. Periksa struktur project yang sudah tersedia.
2. Baca file konfigurasi dan dokumentasi terkait.
3. Identifikasi kebutuhan fitur.
4. Pastikan fitur masih berada dalam scope.
5. Gunakan kembali modul yang sudah tersedia jika memungkinkan.

Ketika mengembangkan fitur:

1. Utamakan implementasi sederhana.
2. Hindari duplikasi kode.
3. Pisahkan fungsi berdasarkan tanggung jawab.
4. Gunakan konfigurasi daripada hardcode.
5. Pastikan perubahan tidak merusak modul lain.
6. Tambahkan pengujian untuk fungsi penting.

Setelah implementasi:

1. Jalankan formatter.
2. Jalankan analyzer.
3. Jalankan unit test yang relevan.
4. Validasi konfigurasi Docker.
5. Validasi integrasi yang memungkinkan.
6. Dokumentasikan keterbatasan jika terdapat bagian yang belum dapat diuji.

Jangan mengklaim fitur berhasil apabila belum diverifikasi.

## 12. ATURAN PENGAMBILAN KEPUTUSAN

Jika menghadapi beberapa pilihan implementasi, prioritaskan:

1. Kesesuaian dengan tujuan awal.
2. Stabilitas framework.
3. Kompatibilitas teknologi.
4. Reusability.
5. Kemudahan konfigurasi.
6. Kemudahan pemeliharaan.
7. Kesederhanaan implementasi.

Jangan memilih teknologi atau arsitektur hanya karena sedang populer.

Jika terdapat kebutuhan yang belum jelas, jangan membuat asumsi besar. Pilih solusi paling sederhana yang masih sesuai dengan kebutuhan atau tanyakan terlebih dahulu jika keputusan tersebut berdampak pada arsitektur utama.

## 13. PRIORITAS PENGEMBANGAN

Kerjakan project berdasarkan urutan berikut:

**Prioritas 1 — Core Foundation**
- Struktur project.
- Konfigurasi aplikasi.
- Device detection.
- ADB integration.
- Application management.

**Prioritas 2 — Testing Engine**
- Generic test suite.
- UI interaction.
- Assertions.
- Test execution.
- Screenshot dan logging.

**Prioritas 3 — Docker Integration**
- Dockerfile.
- Docker Compose.
- Flutter dan Android SDK.
- Koneksi ADB host-container.

**Prioritas 4 — Reporting**
- JUnit XML.
- HTML report.
- Screenshot dan log attachment.

**Prioritas 5 — CLI**
- Device check.
- List apps.
- Add app.
- Test execution.
- Report generation.

**Prioritas 6 — Example Implementation**
- Dragon fruit custom test suite.
- Contoh konfigurasi aplikasi.
- Validasi penggunaan framework pada aplikasi nyata.

Jangan melompat ke pengembangan fitur tambahan sebelum fondasi utama berfungsi.

## 14. DEFINITION OF DONE

Suatu fitur hanya dianggap selesai apabila:

- Implementasi sesuai tujuan fitur.
- Tidak melanggar batasan scope.
- Tidak merusak arsitektur modular.
- Tidak menambahkan hardcode khusus aplikasi ke core.
- Kode dapat dianalisis dan diuji.
- Error ditangani dengan baik.
- Dokumentasi diperbarui jika diperlukan.

Project dianggap mencapai fondasi awal yang layak apabila:

1. Aplikasi dapat didaftarkan melalui konfigurasi.
2. Perangkat Android dapat dideteksi melalui ADB.
3. Docker dapat berkomunikasi dengan ADB host.
4. Framework dapat menjalankan generic test yang didukung.
5. Custom test dapat ditambahkan secara terpisah.
6. Hasil pengujian dapat menghasilkan JUnit XML dan HTML report.
7. CLI dapat menjalankan fungsi utamanya.
8. Contoh dragon fruit dapat diintegrasikan tanpa mengubah core.

Jika perangkat Android tidak tersedia, lakukan validasi komponen yang memungkinkan dan laporkan bagian yang belum dapat diverifikasi.

## 15. INSTRUKSI UTAMA UNTUK AGENT

Selalu jadikan file AGENT.md ini sebagai pedoman selama proses development.

Jangan memperluas scope project secara sepihak.

Jangan menambahkan fitur yang tidak diminta hanya untuk membuat project terlihat lebih kompleks.

Jangan membuat implementasi yang terlalu spesifik terhadap satu aplikasi.

Utamakan framework yang benar-benar dapat digunakan, bukan sekadar struktur folder atau prototype.

**PRINSIP UTAMA: Bangun satu framework automation testing Android yang modular, reusable, configurable, dan dapat digunakan untuk menguji berbagai aplikasi tanpa harus mengubah core framework.**

Jika sebuah perubahan tidak membantu mencapai tujuan tersebut, jangan implementasikan perubahan itu.
