import 'dart:io';

import 'package:app_dev_config/src/configuration_models/configuration.dart';
import 'package:app_dev_config/src/configuration_models/permission.dart';
import 'package:app_dev_config/src/constants.dart';

void applyUserConfigToAndroidManifest(
    Configuration configuration, String path) {
  stdout.writeln('Android');
  try {
    bool changed = false;
    final name = configuration.launcherName;
    if (name != null) {
      _replaceAppName(path, name);
      changed = true;
    }
    if (configuration.permissions != null) {
      _removePermissions(path);
      _insertPermissions(path, configuration.permissions!);
      changed = true;
    }
    if (!changed) {
      stdout.writeln(nothingChanged);
    }
  } catch (e) {
    stdout.writeln(
        '=> $androidManifestFile not found. Maybe this app is not for Android.');
  }
}

void _replaceAppName(String path, String newName) {
  final file = File(path);
  final text = file.readAsStringSync();
  const key = 'android:label';
  final oldName = text.split(key)[1].split('"')[1];
  final oldValue = '$key="$oldName"';
  final newValue = '$key="$newName"';
  final newText = text.replaceAll(oldValue, newValue);
  file.writeAsStringSync(newText);
  stdout.writeln('=> $key has changed to "$newName"');
}

void _removePermissions(String path) {
  final file = File(path);
  String text = file.readAsStringSync();
  const key = '<uses-permission android:name';
  while (text.contains(key)) {
    final oldPer = text.split(key)[1].split('/>').first;
    final fullOldPer = '$key$oldPer/>';
    text = text.replaceAll('\n\t$fullOldPer', '').trim();
    text = text.replaceAll('\n    $fullOldPer', '').trim();
  }
  file.writeAsStringSync(text);
  stdout.writeln('=> Existing permissions removed');
}

void _insertPermissions(String path, List<Permission> permissions) {
  final file = File(path);
  String text = file.readAsStringSync();
  text = text.split('</manifest>').first.trim();
  for (Permission p in permissions) {
    text = '$text\n\t${p.getPermissionAsXml()}';
  }
  text = '$text\n</manifest>';
  file.writeAsStringSync(text);
  stdout.writeln('=> New permissions added:');
  for (Permission p in permissions) {
    stdout.writeln('   - ${p.getAndroidPermission()}');
  }
}
