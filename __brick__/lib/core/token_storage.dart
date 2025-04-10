import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  final _bearerTokenKey = 'bearer_token';
  final SharedPreferences _sp;

  TokenStorage({required SharedPreferences sp}) : _sp = sp;

  String get bearerToken => _sp.getString(_bearerTokenKey) ?? "";

  Future<void> saveBearer(String token) async {
    await _sp.setString(_bearerTokenKey, token);
  }

  Future<void> deleteBearer() async {
    await _sp.remove(_bearerTokenKey);
  }
}
