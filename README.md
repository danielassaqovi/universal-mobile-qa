# Universal Mobile QA

Framework Dart modular untuk otomasi Android berbasis konfigurasi. Patrol dan Flutter Integration Test dipakai pada adapter Flutter; aplikasi native memerlukan adapter/runner native yang sesuai dan tidak diklaim dapat diuji langsung oleh Patrol.

## Mulai cepat
Install Flutter/Dart, JDK, Android SDK dan ADB. Hubungkan perangkat, aktifkan USB debugging dan izinkan RSA, lalu:

```bash
flutter pub get
dart run bin/mobileqa.dart device-check
dart run bin/mobileqa.dart list-apps
dart run bin/mobileqa.dart test --app dragon_fruit --suite generic
dart run bin/mobileqa.dart report
```

Isi `package_name` nyata pada YAML sebelum menjalankan test. Tanpa perangkat authorized, eksekusi dicatat sebagai `skipped`, bukan hasil palsu.

## Docker + ADB host
ADB server tetap di host: jalankan `adb start-server`, lalu `docker compose run --rm mobileqa device-check`. Compose meneruskan koneksi ke `host.docker.internal:5037`; tidak mengubah konfigurasi Linux.

## Arsitektur
`lib/core` berisi config, ADB/device, runner, dan reporting. `test_suites/generic` reusable. `test_suites/examples/dragon_fruit` adalah custom example dan tidak masuk core. Aplikasi baru cukup menambah YAML dan suite/adapter.

## Patrol / Integration Test
Suite UI nyata diletakkan pada project Flutter aplikasi yang diuji menggunakan Patrol dan `integration_test`; framework menyediakan konfigurasi, lifecycle, runner, dan artefak. Locator berada di konfigurasi aplikasi, bukan core.

## Troubleshooting
`unauthorized`: unlock perangkat dan terima dialog RSA. `offline`: cabut/pasang USB. Pastikan package name benar dan aplikasi terpasang. Akses USB langsung container bukan mode yang digunakan; ADB server host wajib aktif.
