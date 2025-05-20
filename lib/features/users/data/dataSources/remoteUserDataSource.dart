import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/userModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRemoteDataSource {
  final http.Client client;
  static const String _baseUrl = 'https://novatask-server.onrender.com';

  final _secureStorage = FlutterSecureStorage();

  String? _token;
  String? get token => _token;

  AuthRemoteDataSource(this.client);

  Future<void> signUp(String name, String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/register');
    print("url for signup $url");

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final newAccessToken = jsonBody['newAccessToken'];
      if (newAccessToken == null) {
        throw Exception("Token not found in response");
      }

      _token = "Bearer $newAccessToken";
      await _secureStorage.write(key: 'authToken', value: _token);

      print("✅ Signup success, token saved.");
    } else {
      throw Exception('Failed to sign up: ${response.body}');
    }

    // adjust if response structure differs
  }

  Future<void> login(String email, String password) async {
    try {
      final url = Uri.parse('$_baseUrl/auth/login');

      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode != 200) {
        
        throw Exception('Failed to login: ${response.body}');
      }

      final jsonBody = json.decode(response.body);
      print(jsonBody);
      _token = "Bearer ${jsonBody['newAccessToken']}";

      await _secureStorage.write(key: 'authToken', value: _token);
      // You can optionally persist this token using SharedPreferences or Secure Storage

      print("✅ Login success, token saved.");
    } catch (e) {
      print('Failed to login: ${e}');
    }
  }
}
