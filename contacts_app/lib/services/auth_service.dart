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

  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_tokenKey);
    return prefs.getString(_tokenKey) != null ? false : true;
  }

  Future<bool> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/users/register"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> createContact(String name, String email, String phone) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final response = await http.post(
      Uri.parse("$BASE_URL/contacts/"),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"name": name, "email": email, "phone": phone}),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<List> getAllContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    if (token == null) {
      return [];
    }
    final response = await http.get(
      Uri.parse("$BASE_URL/contacts/"),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return [];
    }
  }

  Future<Map?> getOneContact(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final response = await http.get(
      Uri.parse("$BASE_URL/contacts/$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }

  Future<bool> updateContact(
    String id,
    String name,
    String email,
    String phone,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final response = await http.put(
      Uri.parse("$BASE_URL/contacts/$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"name": name, "email": email, "phone": phone}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteContact(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final response = await http.delete(
      Uri.parse("$BASE_URL/contacts/$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
