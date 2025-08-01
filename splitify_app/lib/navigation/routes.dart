import 'package:flutter/material.dart';
import 'package:splitify_app/screens/add_expense_screen.dart';
import 'package:splitify_app/screens/groups_screen.dart';
import 'package:splitify_app/screens/login_screen.dart';
import 'package:splitify_app/screens/home_screen.dart';
import 'package:splitify_app/screens/profile_screen.dart';
import 'package:splitify_app/screens/settings_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => const LoginScreen(),
  '/home': (context) => const HomeScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/addExpense': (context) => const AddExpenseScreen(),
  '/groups': (context) => const GroupsScreen(),
  '/settings': (context) => const SettingsScreen(),
};
