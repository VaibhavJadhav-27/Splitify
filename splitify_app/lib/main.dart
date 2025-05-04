import 'package:flutter/material.dart';
import 'package:splitify_app/constants/app_theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const SplitifyApp());
}

class SplitifyApp extends StatelessWidget {
  const SplitifyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splitify',
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
