import 'package:flutter/material.dart';
import 'package:splitify_app/constants/app_colors.dart';
import '../screens/groups_screen.dart';
import '../screens/add_expense_screen.dart';
import '../screens/settle_up_screen.dart';
import '../screens/dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 3;

  final List<Widget> _screens = [
    const GroupsScreen(),
    const AddExpenseScreen(),
    const SettleUpScreen(),
    const DashboardScreen(),
  ];

  final List<String> _titles = ['Groups', 'Add Expense', 'Settle Up', 'Home'];

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text(_titles[_currentIndex])),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (newIndex) => setState(() => _currentIndex = newIndex),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.accent,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Groups'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Expense'),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Settle Up',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        ],
      ),
    );
  }
}
