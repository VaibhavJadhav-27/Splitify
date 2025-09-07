import 'dart:async';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
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

  // Google Sign-In instance
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // Sign in with Google and call backend
  static Future<LoginResponse?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? user =
          await GoogleSignIn.instance.authenticate();
      if (user == null) return null; // User cancelled

      final GoogleSignInAuthentication auth = await user.authentication;

      // Call your backend to login/register the user
      final url = Uri.parse('$baseUrl/google-login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'emailid': user.email,
          'name': user.displayName,
          'idToken': auth.idToken,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return LoginResponse.fromJson(data['data']);
      } else {
        print('Backend login failed: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Google Sign-In error: $e');
      return null;
    }
  }

  static Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
  }
}
