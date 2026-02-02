import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthException implements Exception {
  AuthException(this.message);
  final String message;
  @override
  String toString() => message;
}

class AuthRepository {
  static const _loginKey = 'auth_login';
  static const _passwordHashKey = 'auth_password_hash';
  static const _rememberKey = 'auth_remember';

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  String _hash(String password) {
    return sha256.convert(utf8.encode(password.trim())).toString();
  }

  Future<void> _saveCredentials(String login, String password) async {
    final prefs = await _prefs;
    await prefs.setString(_loginKey, login.trim());
    await prefs.setString(_passwordHashKey, _hash(password));
  }

  Future<void> setRemember(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(_rememberKey, value);
  }

  Future<bool> getRemember() async {
    final prefs = await _prefs;
    return prefs.getBool(_rememberKey) ?? true;
  }

  Future<bool> isLoggedIn() async {
    final prefs = await _prefs;
    final login = prefs.getString(_loginKey);
    final hash = prefs.getString(_passwordHashKey);
    final remember = prefs.getBool(_rememberKey) ?? true;
    return remember && login != null && hash != null && login.isNotEmpty && hash.isNotEmpty;
  }

  Future<void> logout() async {
    final prefs = await _prefs;
    await prefs.remove(_loginKey);
    await prefs.remove(_passwordHashKey);
    await prefs.remove(_rememberKey);
  }

  Future<void> register(String login, String password) async {
    final normalizedLogin = login.trim();
    if (normalizedLogin.isEmpty || password.trim().isEmpty) {
      throw AuthException('Логин и пароль не должны быть пустыми');
    }
    await _saveCredentials(normalizedLogin, password);
    await setRemember(true);
  }

  Future<void> login(String login, String password) async {
    final prefs = await _prefs;
    final storedLogin = prefs.getString(_loginKey);
    final storedHash = prefs.getString(_passwordHashKey);
    final normalizedLogin = login.trim();
    final hashed = _hash(password);

    if (storedLogin == null || storedHash == null) {
      // Авто-регистрация, если данных нет (например, кеш стёрся)
      await _saveCredentials(normalizedLogin, password);
      await setRemember(true);
      return;
    }

    if (normalizedLogin != storedLogin || hashed != storedHash) {
      throw AuthException('Неверный логин или пароль');
    }
    // обновляем remember и сохраняем, чтобы продлить "сессию"
    await setRemember(true);
  }

  Future<String?> getSavedLogin() async {
    final prefs = await _prefs;
    return prefs.getString(_loginKey);
  }
}
