import 'package:flutter/material.dart';
import 'package:splitify_app/screens/login_screen.dart';
import 'package:splitify_app/screens/home_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => const LoginScreen(),
  '/home': (context) => const HomeScreen(),
};
