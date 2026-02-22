import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:splitify_app/models/login_response_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
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

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    final credentails = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    notifyListeners();
    return credentails;
  }

  Future<UserCredential> createAccount({
    required String email,
    required String password,
  }) async {
    final credentails = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    notifyListeners();
    return credentails;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    notifyListeners();
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    notifyListeners();
  }

  Future<void> updateUsername({required String username}) async {
    await currentUser?.updateDisplayName(username);
    notifyListeners();
  }

  Future<void> resetPasswordFomCurrentPassword({
    required String currentPassword,
    required String newPassword,
    required String email,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
    notifyListeners();
  }
}
