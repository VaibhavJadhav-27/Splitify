import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitify_app/constants/app_strings.dart';
import 'package:splitify_app/providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          // 🔘 Theme Toggle
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            value: themeProvider.isDarkMode,
            onChanged: (value) => themeProvider.toggleTheme(value),
          ),

          // 🌐 Language Option (Placeholder)
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Change Language'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Language Settings (optional)
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Coming soon...')));
            },
          ),

          // 🔔 Notifications Toggle (just as a demo)
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            value: true,
            onChanged: (value) {
              // You can use Provider for Notification settings too
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications toggled')),
              );
            },
          ),

          // ℹ️ About App
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Splitify'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Splitify",
                applicationVersion: "v1.0.0",
                applicationLegalese: "© 2025 Vaibhav Jadhav",
              );
            },
          ),

          const Divider(),

          // 🚪 Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              // TODO: Add logout logic
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Logged out')));
            },
          ),
        ],
      ),
    );
  }
}
