import 'package:flutter/material.dart';
import 'package:splitify_app/components/group_card.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  final List<Map<String, dynamic>> groups = const [
    {"name": "Goa Trip", "youOwe": 120.0, "youAreOwed": 80.0},
    {"name": "Flatmates", "youOwe": 0.0, "youAreOwed": 150.0},
    {"name": "Project Team", "youOwe": 45.0, "youAreOwed": 0.0},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Groups",
              style: TextStyle(
                fontSize: size.width * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return GroupCard(
                    groupName: group["name"],
                    youOwe: group["youOwe"],
                    youAreOwed: group["youAreOwed"],
                    onTap: () {
                      // Navigate to group detail screen
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
