import 'dart:html';

class IdRepository {
  static final Storage _localStorage = window.localStorage;

  static Future save(String key, String value) async {
    _localStorage[key] = value;
  }

  static Future<String> get(String key) async {
    return _localStorage[key] ?? "";
  }

  static Future remove(String key) async {
    _localStorage.remove(key);
  }
}
