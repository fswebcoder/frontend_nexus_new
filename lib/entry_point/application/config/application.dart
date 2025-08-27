import 'package:frontend_nexus/entry_point/application/config/app_setings.dart';

class Application {
  static Application? _singleton;
  AppSettings? appSettings;

  factory Application() {
    _singleton ??= Application._();
    return _singleton!;
  }

  Application._();
}
