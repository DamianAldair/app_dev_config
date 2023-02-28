# App Development Configuration

Make modifications that are normally made to a platform native files from the `pubspec.yaml`.

## 📖 Guide

### 1. Import this library in `pubspec.yaml`.

```yaml
dev_dependencies:
  app_dev_config: any
```

### 2. Setup de configuration

```yaml
app_dev_config:
  launcher_name: My Flutter App
  permissions:
    - internet
```

### 3. Run the package

```
flutter pub get
```

```
flutter pub run app_dev_config
```

### 4. Test

## ⚙️ Attributes

### Global

- `launcher_name`: The name that will be displayed in the app launcher.
- `permissions`: Permissions to be used by the app (Only for Android for now).

### Android

- `android`
  - `apply`: Specifies weather to apply config for Android platform or not.
  - `compile_sdk`: SDK to be used to compile de app.
  - `min_sdk`: Minimum SDK on which the app can be installed.
  - `target_sdk`: Target SDK on which the app can be installed.
  - `ndk`: NDK to be used to compile de app.

## ⏳ TODO

- iOS
