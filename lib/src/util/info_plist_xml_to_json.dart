Map<String, dynamic> loadInfoPlist(String infoPlistAsString) {
  List<String> stringList = infoPlistAsString.split('\n');
  _cleanInfoPlist(stringList);
  return _convertListToMap(stringList);
}

_cleanInfoPlist(List<String> stringList) {
  stringList.removeWhere((element) => element.contains('<?xml'));
  stringList.removeWhere((element) => element.contains('<!DOCTYPE'));
  stringList.removeWhere(
      (element) => element.contains('<plist') || element.contains('plist>'));
  stringList.removeWhere((element) => element.contains('dict>'));
}

String _getValue(String tag, String string) {
  final String tag1 = '<$tag>';
  final String tag2 = '</$tag>';
  return string.split(tag1).last.split(tag2).first;
}

String _getKey(String string) => _getValue('key', string);

String _getString(String string) => _getValue('string', string);

bool? _getBool(String string) {
  final v = string.split('<').last.split('/>').first;
  return v == 'true'
      ? true
      : v == 'false'
          ? false
          : null;
}

Map<String, dynamic> _convertListToMap(List<String> stringList) {
  bool isArray = false;
  Map<String, dynamic> map = {};
  String key = '';
  List<String> array = [];
  for (int i = 0; i < stringList.length; i++) {
    final string = stringList[i];
    if (!isArray) {
      if (string.contains('key')) {
        key = _getKey(string);
      } else if (string.contains('string')) {
        map.putIfAbsent(key, () => _getString(string));
      } else if (string.contains('<true/>') || string.contains('<false/>')) {
        map.putIfAbsent(key, () => _getBool(string));
      } else if (string.contains('<array>') || string.contains('</array>')) {
        isArray = !isArray;
      }
    } else {
      if (string.contains('<array>') || string.contains('</array>')) {
        isArray = !isArray;
        map.putIfAbsent(key, () => array.toList());
        array.clear();
      } else {
        array.add(_getString(string));
      }
    }
  }
  return map;
}
