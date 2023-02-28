import 'dart:io';

import 'package:app_dev_config/src/util/info_plist_xml_to_json.dart';
import 'package:args/args.dart';
import 'package:yaml/yaml.dart';

String? parseArgs(List<String> arguments) {
  const String option = 'config_file';
  final ArgParser parser = ArgParser()..addOption(option, abbr: 'f');
  final ArgResults argResult = parser.parse(arguments);
  return argResult[option];
}

Map<String, dynamic> parseYaml(String path) {
  final File file = File(path);
  final String yamlString = file.readAsStringSync();
  final Map yamlMap = loadYaml(yamlString);
  return parseMap(yamlMap as YamlMap);
}

Map<String, dynamic> parseInfoPlist(String path) {
  final File file = File(path);
  final String xmlString = file.readAsStringSync();
  return loadInfoPlist(xmlString);
}

Map<String, dynamic> parseMap(YamlMap yamlMap) {
  Map<String, dynamic> map = {};
  final keys = yamlMap.keys.toList();
  final values = yamlMap.values.toList();
  for (int i = 0; i < yamlMap.length; i++) {
    final dynamic value;
    if (values[i] is YamlMap) {
      value = parseMap(values[i]);
    } else if (values[i] is YamlList) {
      value = (values[i] as YamlList).toList();
    } else {
      value = values[i];
    }
    map.putIfAbsent(keys[i], () => value);
  }
  return map;
}
