import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Token {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  // final SharedPreferences _sharedPreferences =  SharedPreferences.getInstance();

  Future<void> storeBearerToken(String token) async {
    // await _storage.write(key: 'bearerToken', value: token);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("Token", token);
    // print("Bearer Token Stored: $token");
  }

// Retrieve the token securely using flutter_secure_storage
  Future<String?> retrieveBearerToken() async {
    // final String? token = await _storage.read(key: 'bearerToken');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("Token");
    // print('Token: $token');
    return token;
  }

  //clear the token from the storage
  Future<void> clearBearerToken() async {
    await _storage.delete(key: 'bearerToken');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("Token");
    print("Bearer Token Cleared");
  }
}
