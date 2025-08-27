abstract class ConfigurationDbSource {
  Future<void> saveDarkMode(bool? darkMode);
  Future<bool?> getDarkMode();
}
