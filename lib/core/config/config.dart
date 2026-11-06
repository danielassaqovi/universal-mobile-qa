import 'dart:io';
import 'package:yaml/yaml.dart';

class AppConfig {
  final String id, name, packageName, type, projectPath, environment;
  final int timeout;
  final List<String> suites;
  final Map<String, dynamic> elements;
  AppConfig(
      {required this.id,
      required this.name,
      required this.packageName,
      required this.type,
      required this.projectPath,
      required this.environment,
      required this.timeout,
      required this.suites,
      required this.elements});
  factory AppConfig.fromYaml(Map m) => AppConfig(
      id: '${m['id']}',
      name: '${m['name']}',
      packageName: '${m['package_name']}',
      type: '${m['type'] ?? 'flutter'}',
      projectPath: '${m['project_path'] ?? ''}',
      environment: '${m['environment'] ?? 'default'}',
      timeout: (m['timeout_seconds'] ?? 60) as int,
      suites: List<String>.from(m['suites'] ?? const ['generic']),
      elements: Map<String, dynamic>.from(m['elements'] ?? {}));
}

class AppConfigStore {
  final String root;
  AppConfigStore(this.root);
  Future<List<AppConfig>> list() async {
    final d = Directory('$root/configs/apps');
    if (!await d.exists()) return [];
    final o = <AppConfig>[];
    await for (final f in d.list()) {
      if (f is File && f.path.endsWith('.yaml'))
        o.add(AppConfig.fromYaml(loadYaml(await f.readAsString()) as Map));
    }
    return o;
  }

  Future<AppConfig?> find(String id) async {
    for (final a in await list()) if (a.id == id) return a;
    return null;
  }
}
