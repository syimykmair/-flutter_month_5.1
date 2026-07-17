import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

abstract final class KeyPreferences {
  static const String onboardingSeen = 'onboarding_seen';
}

@LazySingleton()
class PreferencesService {
  PreferencesService(this._preferences);

  final SharedPreferences _preferences;

  bool get onboardingSeen {
    return _preferences.getBool(KeyPreferences.onboardingSeen) ?? false;
  }

  Future<void> setOnboardingSeen() async {
    await _preferences.setBool(KeyPreferences.onboardingSeen, true);
  }
}
