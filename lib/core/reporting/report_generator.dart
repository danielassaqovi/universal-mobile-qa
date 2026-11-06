import 'dart:io';
import 'package:path/path.dart' as p;

class ReportGenerator {
  final String root;
  ReportGenerator(this.root);
  Future<String> latest() async {
    final d = Directory('$root/reports');
    if (!await d.exists()) return 'Belum ada laporan.';
    final f = await d.list().where((e) => e.path.endsWith('.html')).toList();
    return f.isEmpty ? 'Belum ada laporan.' : f.map((e) => e.path).join('\n');
  }

  Future<void> write(
      {required String app,
      required String suite,
      required String status,
      required String error,
      required Duration duration,
      required String device}) async {
    final d = Directory('$root/reports');
    await d.create(recursive: true);
    final t = DateTime.now().toUtc().toIso8601String().replaceAll(':', '-');
    final fail = status == 'failed' ? '<failure message="${_e(error)}"/>' : '';
    await File(p.join(d.path, '$t.xml')).writeAsString(
        '<?xml version="1.0"?><testsuite name="$app" tests="1" failures="${status == 'failed' ? 1 : 0}" skipped="${status == 'skipped' ? 1 : 0}"><testcase classname="$suite" name="execution">$fail</testcase></testsuite>');
    await File(p.join(d.path, '$t.html')).writeAsString(
        '<html><body><h1>Mobile QA Report</h1><p>App: $app</p><p>Suite: $suite</p><p>Status: $status</p><p>Device: $device</p><p>Duration: ${duration.inMilliseconds} ms</p><pre>${_e(error)}</pre></body></html>');
  }

  String _e(String s) => s
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;');
}
