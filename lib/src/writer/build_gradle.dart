import 'dart:io';

import 'package:app_dev_config/src/configuration_models/configuration.dart';
import 'package:app_dev_config/src/constants.dart';

applyUserConfigToBuildGradle(Configuration configuration, String path) {
  stdout.writeln('Build.gradle');
  bool changed = false;
  try {
    final applyAndroid = configuration.androidConfiguration == null
        ? false
        : configuration.androidConfiguration!.apply;
    if (applyAndroid) {
      if (configuration.androidConfiguration!.compileSdk != null) {
        _replaceValue(path, 'compileSdkVersion',
            configuration.androidConfiguration!.compileSdk.toString());
        changed = true;
      }
      if (configuration.androidConfiguration!.minSdk != null) {
        _replaceValue(path, 'minSdkVersion',
            configuration.androidConfiguration!.minSdk.toString());
        changed = true;
      }
      if (configuration.androidConfiguration!.targetSdk != null) {
        _replaceValue(path, 'targetSdkVersion',
            configuration.androidConfiguration!.targetSdk.toString());
        changed = true;
      }
      if (configuration.androidConfiguration!.ndk != null) {
        _replaceValue(path, 'ndkVersion',
            configuration.androidConfiguration!.ndk.toString());
        changed = true;
      }
    }
    if (!changed) {
      stdout.writeln(nothingChanged);
    }
  } catch (e) {
    stdout.writeln(
        '=> $androidGradleFile not found. Maybe this app is not for Android.');
  }
}

void _replaceValue(String path, String key, String newValue) {
  final file = File(path);
  final text = file.readAsStringSync();
  final splitted = text.split('\n');
  final oldValue = splitted
      .where((element) => element.contains(key))
      .first
      .split('$key ')
      .last;
  final newText = text.replaceAll(oldValue, newValue);
  file.writeAsStringSync(newText);
  stdout.writeln('=> $key has changed to "$newValue"');
}
