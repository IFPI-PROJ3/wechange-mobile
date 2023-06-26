import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wechange_mobile/src/modules/auth/models/refresh_token.dart';

class TokenService {
  // ignore: prefer_final_fields
  static FlutterSecureStorage _storage = const FlutterSecureStorage();

  static Future<void> saveTokens(RefreshToken refreshToken) async {
    await _storage.write(key: "accessToken", value: refreshToken.accessToken);
    await _storage.write(key: "refreshToken", value: refreshToken.refreshToken);
  }

  static Future<RefreshToken?> getTokens() async {
    String accessToken = await _storage.read(key: "accessToken") ?? '';
    String refreshToken = await _storage.read(key: "refreshToken") ?? '';

    if (accessToken == '' || refreshToken == '') {
      return null;
    }

    return RefreshToken(accessToken, refreshToken);
  }

  static Future<void> deleteTokens() async {
    await _storage.delete(key: "accessToken");
    await _storage.delete(key: "refreshToken");
  }
}
