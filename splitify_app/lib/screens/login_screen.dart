import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:splitify_app/components/common_button.dart';
import 'package:splitify_app/constants/app_enums.dart';
import 'package:splitify_app/constants/app_strings.dart';
import 'package:splitify_app/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Email validation regex
  final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  // Phone number validation regex (10 digits, can expand as needed)
  final RegExp phoneRegex = RegExp(r"^[0-9]{10}$");

  Future<void> handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return; // show validation errors
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    //call login
    // final userData = await AuthService.loginUser(email);
    // if (userData != null) {
    //   print(userData.toString());
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(const SnackBar(content: Text('Login successful!')));
    //   // TODO: Authenticate user here
    //   Navigator.pushReplacementNamed(context, '/home');
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Login failed. Please try again.')),
    //   );
    // }
    Navigator.pushReplacementNamed(context, '/home');
  }

  Future<void> _handleGoogleLogin() async {
    try {
      setState(() => _isLoading = true);
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      // Initialize if needed
      await googleSignIn.initialize(
        clientId: '<YOUR_CLIENT_ID>',
        serverClientId: '<YOUR_SERVER_CLIENT_ID>',
      );

      final GoogleSignInAccount? user = await googleSignIn.authenticate();

      if (user != null) {
        // Send user info to backend
        final loginResponse = await AuthService.loginUser(user.email);
        if (loginResponse != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Login successful!')));
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login failed on server. Please try again.'),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Google Sign-In error: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email or phone',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email or phone';
                      }
                      if (!emailRegex.hasMatch(value) &&
                          !phoneRegex.hasMatch(value)) {
                        return 'Please enter a valid email or phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CommonButton(
                    label: 'Log in',
                    onPressed: handleLogin,
                    variant: ButtonVariant.primary,
                    height: 48,
                    borderRadius: 12,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("OR"),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CommonButton(
                    label:
                        _isLoading
                            ? 'Signing in with Google...'
                            : AppStrings.signInWithGoogle,
                    onPressed: () {
                      _handleGoogleLogin();
                    },
                    icon: Icons.login,
                    variant: ButtonVariant.secondary,
                    height: 48,
                    borderRadius: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
