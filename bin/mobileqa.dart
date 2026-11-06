import 'dart:io';
import 'package:args/args.dart';
import 'package:universal_mobile_qa/core/config/config.dart';
import 'package:universal_mobile_qa/core/device/adb_client.dart';
import 'package:universal_mobile_qa/core/reporting/report_generator.dart';
import 'package:universal_mobile_qa/core/runner/test_runner.dart';

Future<void> main(List<String> argv) async {
  final p = ArgParser()
    ..addCommand('device-check')
    ..addCommand('list-apps')
    ..addCommand(
        'add-app',
        ArgParser()
          ..addOption('id')
          ..addOption('name')
          ..addOption('package'))
    ..addCommand('report');
  p.addCommand(
      'test',
      ArgParser()
        ..addOption('app')
        ..addOption('suite', defaultsTo: 'generic'));
  final a = p.parse(argv), c = a.command;
  if (c == null) {
    print(p.usage);
    exitCode = 64;
    return;
  }
  final root = Directory.current.path;
  if (c.name == 'device-check') {
    final r = await AdbClient().checkDevice();
    print(r);
    if (!r.available) exitCode = 1;
    return;
  }
  if (c.name == 'list-apps') {
    for (final x in await AppConfigStore(root).list())
      print('${x.id}: ${x.name} (${x.packageName})');
    return;
  }
  if (c.name == 'add-app') {
    final id = c['id'] as String?;
    final name = c['name'] as String?;
    final packageName = c['package'] as String?;
    if (id == null || name == null || packageName == null) {
      print(
          'Gunakan: mobileqa add-app --id ID --name "Nama" --package PACKAGE');
      exitCode = 64;
      return;
    }
    final file = File('$root/configs/apps/$id.yaml');
    if (await file.exists()) {
      print('Konfigurasi sudah ada: ${file.path}');
      exitCode = 1;
      return;
    }
    await file.writeAsString('''id: $id
name: "$name"
package_name: $packageName
project_path: ""
type: flutter
environment: default
timeout_seconds: 60
suites: [generic]
elements: {}
''');
    print('Konfigurasi dibuat: ${file.path}');
    return;
  }
  if (c.name == 'report') {
    print(await ReportGenerator(root).latest());
    return;
  }
  final id = c['app'] as String?;
  if (id == null) {
    print('--app wajib diisi');
    exitCode = 64;
    return;
  }
  final app = await AppConfigStore(root).find(id);
  if (app == null) {
    print('Aplikasi tidak ditemukan: $id');
    exitCode = 1;
    return;
  }
  final r = await TestRunner(root).run(app, c['suite'] as String);
  print(r.message);
  if (!r.success) exitCode = 1;
}
