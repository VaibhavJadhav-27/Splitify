import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:splitify_app/models/login_response_model.dart';

class AuthService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/v1/users';

  static Future<bool> registerUser(Map<String, String> userData) async {
    final url = Uri.parse('$baseUrl/registeruser');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      //final token = data['data']['token'];
      // Save token if needed
      return true;
    } else {
      print('Error: ${response.body}');
      return false;
    }
  }

  static Future<LoginResponse?> loginUser(String email) async {
    final url = Uri.parse('$baseUrl/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'emailid': email}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Login successful: ${data}');
      return LoginResponse.fromJson(data['data']);
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }
}
