import 'dart:io';

import 'package:app_dev_config/app_dev_config.dart';
import 'package:app_dev_config/src/parser.dart';
import 'package:app_dev_config/src/util.dart';
import 'package:app_dev_config/src/util/config_file.dart';
import 'package:app_dev_config/src/version.dart';

/// Function to be executed when running the library from the command-line
void main(List<String> arguments) {
  stdout.writeln(introMessage(packageVersion));
  final String? file = parseArgs(arguments);
  final String configFile = getConfigFile(file);
  applyUserConfig(configFile);
  stdout.writeln('\n👍 Process finished 👍\n');
}
