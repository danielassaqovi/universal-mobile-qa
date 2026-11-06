import '../config/config.dart';
import '../device/adb_client.dart';
import '../reporting/report_generator.dart';

class RunResult {
  final bool success;
  final String message;
  RunResult(this.success, this.message);
}

class TestRunner {
  final String root;
  TestRunner(this.root);
  Future<RunResult> run(AppConfig app, String suite) async {
    final sw = Stopwatch()..start();
    final d = await AdbClient().checkDevice();
    if (!d.available) {
      await ReportGenerator(root).write(
          app: app.name,
          suite: suite,
          status: 'skipped',
          error: d.message,
          duration: sw.elapsed,
          device: 'unavailable');
      return RunResult(false, 'SKIPPED: ${d.message}');
    }
    final ok = await AdbClient().launch(d.serial, app.packageName);
    await ReportGenerator(root).write(
        app: app.name,
        suite: suite,
        status: ok ? 'passed' : 'failed',
        error: ok ? '' : 'Aplikasi tidak dapat dibuka',
        duration: sw.elapsed,
        device: d.toString());
    return RunResult(ok, ok ? 'PASSED: app launch' : 'FAILED: app launch');
  }
}
