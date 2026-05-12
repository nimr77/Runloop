abstract interface class AppPreferencesRepository {
  Future<bool> getLaunchAtLogin();
  Future<void> setLaunchAtLogin(bool value);
}
