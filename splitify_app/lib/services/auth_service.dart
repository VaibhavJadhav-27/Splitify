import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://localhost:8000/api/v1/users';

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
}
