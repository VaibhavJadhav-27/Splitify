import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("You owe", style: TextStyle(fontSize: 16)),
          Text("₹0.00", style: TextStyle(fontSize: size.width * 0.08)),

          const SizedBox(height: 10),
          const Text("You are owed", style: TextStyle(fontSize: 16)),
          Text("₹0.00", style: TextStyle(fontSize: size.width * 0.08)),

          const SizedBox(height: 30),
          const Divider(),

          const Text("Recent activity", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          ListTile(
            leading: const CircleAvatar(radius: 5),
            title: const Text("Person - item"),
            trailing: const Text("3 days ago"),
          ),
          ListTile(
            leading: const CircleAvatar(radius: 5),
            title: const Text("Person - 2 friends"),
            trailing: const Text("3 days ago"),
          ),
          ListTile(
            leading: const CircleAvatar(radius: 5),
            title: const Text("Person - 2 friends"),
            trailing: const Text("2 days ago"),
          ),
        ],
      ),
    );
  }
}
