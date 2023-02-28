import 'dart:io';

import 'package:app_dev_config/src/constants.dart';

String getConfigFile(String? file) {
  if (file == null) {
    return File(defaultConfigFilePath).existsSync()
        ? defaultConfigFilePath
        : pubspecFilePath;
  } else {
    if (!File(file).existsSync()) {
      throw Exception('Configuration file not found');
    }
    return file;
  }
}
