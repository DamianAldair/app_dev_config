# App Dev Config - Example

## In `pubspec.yaml` file.

```yaml
dev_dependencies:
  app_dev_config: any
```

## In `app_dev_config.yaml` file.

You must create this file if you want use it. Also you can use the `pubspec.yaml` file.

```yaml
app_dev_config:
  launcher_name: My Flutter App
  permissions:
    - internet
    - read_internal_storage
    - write_internal_storage
```

## In the terminal:

```
flutter pub get
```

```
flutter pub run app_dev_config
```

## Done 👍
