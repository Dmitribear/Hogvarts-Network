import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/profile/domain/fan_profile.dart';

class LocalStorage {
  static const _profileKey = 'fan_profile';

  Future<FanProfile?> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_profileKey);
    if (raw == null) return null;
    return FanProfile.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> saveProfile(FanProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileKey, jsonEncode(profile.toJson()));
  }
}
