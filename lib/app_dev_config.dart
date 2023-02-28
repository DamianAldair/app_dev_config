import 'dart:io';

import 'package:app_dev_config/src/configuration_models/configuration.dart';
import 'package:app_dev_config/src/constants.dart';
import 'package:app_dev_config/src/parser.dart';
import 'package:app_dev_config/src/util.dart';
import 'package:app_dev_config/src/writer/android_manifest_xml.dart';
import 'package:app_dev_config/src/writer/build_gradle.dart';
import 'package:app_dev_config/src/writer/info_plist.dart';

void applyUserConfig(String configFile) {
  try {
    stdout.writeln(warning);
    final json = parseYaml(configFile)["app_dev_config"];
    final conf = Configuration.fromJson(json);
    applyUserConfigToInfoPlist(conf, infoPlistFile);
    stdout.writeln('');
    applyUserConfigToAndroidManifest(conf, androidManifestFile);
    stdout.writeln('');
    applyUserConfigToBuildGradle(conf, androidGradleFile);
    stdout.writeln('');
  } catch (e) {
    stdout.writeln('==> Configuration data not found');
  }
}
