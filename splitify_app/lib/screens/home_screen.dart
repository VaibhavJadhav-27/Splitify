import 'package:flutter/material.dart';
import '../screens/groups_screen.dart';
import '../screens/add_expense_screen.dart';
import '../screens/settle_up_screen.dart';
import '../screens/dashboard_screen.dart';
import '../constants/app_strings.dart';
import 'package:splitify_app/components/custom_bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const GroupsScreen(),
    const AddExpenseScreen(),
    const SettleUpScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.appBarTitles[_currentIndex])),
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
