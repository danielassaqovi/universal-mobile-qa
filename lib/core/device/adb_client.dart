import 'dart:io';

class DeviceInfo {
  final bool available;
  final String message, serial, model, android;
  DeviceInfo(this.available, this.message,
      {this.serial = '', this.model = '', this.android = ''});
  @override
  String toString() =>
      available ? 'OK: $serial $model Android $android' : 'ERROR: $message';
}

class AdbClient {
  Future<ProcessResult> _run(List<String> a) => Process.run('adb', a);
  Future<DeviceInfo> checkDevice() async {
    try {
      final s = await _run(['start-server']);
      if (s.exitCode != 0)
        return DeviceInfo(false, 'ADB server gagal: ${s.stderr}');
      final r = await _run(['devices']);
      final l = r.stdout
          .toString()
          .split('\n')
          .skip(1)
          .where((x) => x.trim().isNotEmpty)
          .toList();
      if (l.isEmpty)
        return DeviceInfo(false, 'Tidak ada perangkat terdeteksi.');
      final q = l.first.split(RegExp(r'\s+'));
      if (q.length < 2 || q[1] != 'device')
        return DeviceInfo(false, 'Perangkat belum authorized: ${l.first}');
      final serial = q.first;
      final model =
          (await _run(['-s', serial, 'shell', 'getprop', 'ro.product.model']))
              .stdout
              .toString()
              .trim();
      final android = (await _run(
              ['-s', serial, 'shell', 'getprop', 'ro.build.version.release']))
          .stdout
          .toString()
          .trim();
      return DeviceInfo(true, 'connected',
          serial: serial, model: model, android: android);
    } catch (e) {
      return DeviceInfo(false, 'ADB tidak tersedia: $e');
    }
  }

  Future<bool> launch(String s, String p) async =>
      (await _run(['-s', s, 'shell', 'monkey', '-p', p, '1'])).exitCode == 0;
}
