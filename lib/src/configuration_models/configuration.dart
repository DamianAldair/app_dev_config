import 'package:app_dev_config/src/configuration_models/android_config.dart';
import 'package:app_dev_config/src/configuration_models/permission.dart';

class Configuration {
  final String? launcherName;
  final List<Permission>? permissions;
  final AndroidConfiguration? androidConfiguration;

  Configuration({
    required this.launcherName,
    required this.permissions,
    required this.androidConfiguration,
  });

  factory Configuration.fromJson(Map<String, dynamic> json) {
    List<Permission>? p = [];
    if (json["permissions"] == null) {
      p = null;
    } else {
      for (String pp in json["permissions"]) {
        p.add(Permission(pp));
      }
    }
    return Configuration(
      launcherName: json["launcher_name"],
      permissions: p,
      androidConfiguration: json["android"] != null
          ? AndroidConfiguration.fromJson(json["android"])
          : null,
    );
  }

  Map<String, dynamic> toJson(Configuration configuration) => {
        "launcher_name": configuration.launcherName,
        "permissions": configuration.permissions,
        "android_configuration": configuration.androidConfiguration.toString(),
      };
}
