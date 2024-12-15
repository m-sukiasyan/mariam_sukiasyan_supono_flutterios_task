import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const String _appIsUnlockedKey = 'app_is_unlocked_key';
  static const String _languageKey = 'language_key';

  static const _storage = FlutterSecureStorage();

  static get storage => _storage;

  static Future<void> saveLanguageCode(String languageCode) async {
    await _storage.write(key: _languageKey, value: languageCode);
  }

  static Future<String?> readLanguageCode() async {
    return await _storage.read(key: _languageKey);
  }

  static Future<void> deleteByKey(String key) async {
    await _storage.delete(key: key);
  }

  static Future<void> saveValue(
      {required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> readValue({required String key}) async {
    return await _storage.read(key: key);
  }

  static Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  static Future<void> saveUnlockData() async {
    await _storage.write(key: _appIsUnlockedKey, value: 'true');
  }

  static Future<bool?> readUnlockData() async {
    return await _storage.read(key: _appIsUnlockedKey) == 'true' ? true : false;
  }
}
