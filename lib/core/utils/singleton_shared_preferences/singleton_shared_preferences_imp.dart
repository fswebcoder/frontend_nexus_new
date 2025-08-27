import 'package:frontend_nexus/core/utils/singleton_shared_preferences/singleton_shared_preferences.dart';

class SingletonSharedPreferencesImp implements SingletonSharedPreferences {
  SingletonSharedPreferencesImp._internal();
  static final SingletonSharedPreferencesImp _singleton =
      SingletonSharedPreferencesImp._internal();
  factory SingletonSharedPreferencesImp() {
    return _singleton;
  }
  @override
  bool? darkMode;
}
