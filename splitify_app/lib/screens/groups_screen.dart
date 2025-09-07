import 'package:flutter/material.dart';
import 'package:splitify_app/components/common_button.dart';
import 'package:splitify_app/components/group_card.dart';
import 'package:splitify_app/constants/app_enums.dart';
import 'package:splitify_app/constants/app_strings.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  final List<Map<String, dynamic>> groups = const [
    {
      "name": "Roommates",
      "members": ["JD", "SC", "MJ"],
      "total": 1250.80,
      "lastExpense": "Utilities Bill",
      "timeAgo": "2 days ago",
      "balance": -45.60,
      "settled": false,
    },
    {
      "name": "Weekend Trip",
      "members": ["JD", "SC", "MJ", "ED"],
      "total": 890.50,
      "lastExpense": "Hotel Stay",
      "timeAgo": "1 week ago",
      "balance": 23.40,
      "settled": false,
    },
    {
      "name": "Work Lunch",
      "members": ["JD", "ED", "AK", "TW", "+2"],
      "total": 320.75,
      "lastExpense": "Team Lunch",
      "timeAgo": "3 days ago",
      "balance": -12.30,
      "settled": false,
    },
    {
      "name": "Vacation Planning",
      "members": ["JD", "SC", "ED"],
      "total": 0.00,
      "lastExpense": "No expenses yet",
      "timeAgo": "",
      "balance": 0.0,
      "settled": true,
    },
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
            //
            Text(
              "Manage your expense groups",
              style: TextStyle(
                fontSize: size.width * 0.025,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            CommonButton(
              label: AppStrings.createNewGroup,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/createNewGroup');
              },
              icon: Icons.add,
              variant: ButtonVariant.primary,
              height: size.height * 0.06,
            ),
            SizedBox(height: size.height * 0.035),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return GroupCard(
                    groupName: group["name"],
                    members: group["members"],
                    totalAmount: group["total"],
                    lastExpense: group["lastExpense"],
                    timeAgo: group["timeAgo"],
                    balance: group["balance"],
                    isSettled: group["settled"],
                    onTap: () {
                      // Navigate to Group Details Screen
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => GroupDetailsScreen(group)));
                      Navigator.pushReplacementNamed(
                        context,
                        '/viewGroupDetails',
                      );
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
