import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitify_app/components/common_button.dart';
import 'package:splitify_app/constants/app_enums.dart';
import 'package:splitify_app/constants/app_strings.dart';
import 'package:splitify_app/providers/bottom_nav_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<Map<String, String>> recentActivity = [
      {'name': 'Rohit - lunch', 'time': '3 days ago'},
      {'name': 'Amit - cab with 2 friends', 'time': '2 days ago'},
      {'name': 'Neha - dinner', 'time': '1 day ago'},
      {'name': 'Vaibhav - movie with 3 friends', 'time': '2 hours ago'},
    ];

    void handleAddExpense(BuildContext context) {
      // Navigate to Add Expense screen
      context.read<BottomNavProvider>().setIndex(2);
    }

    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text("You owe", style: TextStyle(fontSize: 16)),
            // Text("₹0.00", style: TextStyle(fontSize: size.width * 0.08)),

            // const SizedBox(height: 10),
            // const Text("You are owed", style: TextStyle(fontSize: 16)),
            // Text("₹0.00", style: TextStyle(fontSize: size.width * 0.08)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.arrow_downward,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                "You owe",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Text(
                            "₹0.00",
                            style: TextStyle(
                              fontSize: size.width * 0.08,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.arrow_upward,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                "You are owed",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),

                          Text(
                            "₹0.00",
                            style: TextStyle(
                              fontSize: size.width * 0.08,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 50),
            const Divider(),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CommonButton(
                label: AppStrings.addExpense,
                onPressed: () => handleAddExpense(context),
                variant: ButtonVariant.primary,
                height: 48,
                icon: Icons.add,
              ),
            ),

            const Text("Recent activity", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            ListView.builder(
              itemCount: recentActivity.length,
              shrinkWrap: true, // Important to avoid unbounded height
              physics:
                  const NeverScrollableScrollPhysics(), //Avoid nested scrolling
              itemBuilder: (context, index) {
                final activity = recentActivity[index];
                return ListTile(
                  leading: const CircleAvatar(radius: 5),
                  title: Text(activity['name'] ?? ''),
                  trailing: Text(activity['time'] ?? ''),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
