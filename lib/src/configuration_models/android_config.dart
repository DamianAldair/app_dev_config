class AndroidConfiguration {
  final bool apply;
  final dynamic compileSdk;
  final dynamic minSdk;
  final dynamic targetSdk;
  final dynamic ndk;

  AndroidConfiguration({
    this.apply = false,
    this.compileSdk,
    this.minSdk,
    this.targetSdk,
    this.ndk,
  });

  factory AndroidConfiguration.fromJson(Map<String, dynamic> json) =>
      AndroidConfiguration(
        apply: json["apply"] ?? false,
        compileSdk: json["compile_sdk"],
        minSdk: json["min_sdk"],
        targetSdk: json["target_sdk"],
        ndk: json["ndk"],
      );

  Map<String, dynamic> toJson(AndroidConfiguration androidConfiguration) => {
        "apply": androidConfiguration.apply,
        "compile_sdk": androidConfiguration.compileSdk,
        "min_sdk": androidConfiguration.minSdk,
        "target_sdk": androidConfiguration.targetSdk,
        "ndk": androidConfiguration.ndk,
      };

  @override
  String toString() => {
        "apply": apply,
        "compile_sdk": compileSdk,
        "min_sdk": minSdk,
        "target_sdk": targetSdk,
        "ndk": ndk,
      }.toString();
}
