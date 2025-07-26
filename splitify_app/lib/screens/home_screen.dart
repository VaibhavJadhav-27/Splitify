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
      appBar: AppBar(
        title: Text(AppStrings.appBarTitles[_currentIndex]),
        leading: Builder(
          builder:
              (BuildContext innerBuildContext) => IconButton(
                onPressed: () {
                  Scaffold.of(innerBuildContext).openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                "Welcome Vaibhav 👋",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text(AppStrings.myGroups),
              onTap: () {
                // Navigate to Groups Screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(AppStrings.profile),
              onTap: () {
                // Navigate to Profile Screen
                Navigator.pushReplacementNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(AppStrings.logout),
              onTap: () {
                // Perform logout logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(AppStrings.settings),
              onTap: () {
                // Perform logout logic
              },
            ),
          ],
        ),
      ),
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
