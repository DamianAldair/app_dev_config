import 'dart:io';

import 'package:app_dev_config/src/configuration_models/configuration.dart';
import 'package:app_dev_config/src/constants.dart';
import 'package:app_dev_config/src/parser.dart';

void applyUserConfigToInfoPlist(Configuration configuration, String path) {
  stdout.writeln('iOS');
  try {
    final name = configuration.launcherName;
    if (name != null) {
      _replaceDisplayName(path, name);
      _replaceBundleName(path, name);
    } else {
      stdout.writeln(nothingChanged);
    }
  } catch (e) {
    stdout
        .writeln('=> $infoPlistFile not found. Maybe this app is not for iOS.');
  }
}

void _replaceDisplayName(String path, String newName) =>
    _replaceStringValue(path, 'CFBundleDisplayName', newName);

void _replaceBundleName(String path, String newName) =>
    _replaceStringValue(path, 'CFBundleName', newName);

void _replaceStringValue(String path, String key, String newValue) {
  final file = File(path);
  final Map<String, dynamic> xmlMap = parseInfoPlist(path);
  final text = file.readAsStringSync();
  final oldValue = xmlMap[key];
  final xmlOldValue = '<string>$oldValue</string>';
  final xmlNewValue = '<string>$newValue</string>';
  final newText = text.replaceAll(xmlOldValue, xmlNewValue);
  file.writeAsStringSync(newText);
  stdout.writeln('=> $key has changed to "$newValue"');
}
