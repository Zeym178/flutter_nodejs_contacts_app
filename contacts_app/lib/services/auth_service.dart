import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String BASE_URL = "http://10.0.2.2:5000/api";
  final String _tokenKey = "tokenKey";

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey);
    if (token != null && !JwtDecoder.isExpired(token)) {
      return true;
    }
    if (token == null) {
      print("there's no token");
    } else {
      print("token has expired");
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/users/login"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      final data = jsonDecode(response.body);
      prefs.setString(_tokenKey, data['loginToken']);
      return true;
    }

    return false;
  }
}
