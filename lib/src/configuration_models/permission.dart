class Permission {
  final String name;

  Permission(this.name);

  /// Get full string of permission
  ///
  /// More info: https://developer.android.com/reference/android/Manifest.permission
  String getAndroidPermission([String org = 'android.permission']) {
    final p = name.toUpperCase();
    return '$org.$p';
  }

  /// Get line to add to XML manifest
  String getPermissionAsXml([String org = 'android.permission']) {
    final p = getAndroidPermission(org);
    return '<uses-permission android:name="$p" />';
  }

  @override
  String toString() => name;
}
