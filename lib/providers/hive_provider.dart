import 'package:hive/hive.dart';

class HiveProvider {
  dynamic settingsBox;
  Future<void> initHiveBox() async {
    settingsBox = await Hive.openBox('settingsBox');
  }

  dynamic getSettingsValue(String name) {
    return settingsBox.get(name);
  }

  void setSettingsValue(String key, dynamic value) {
    settingsBox.put(key, value);
  }
}
