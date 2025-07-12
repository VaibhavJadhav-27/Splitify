import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final String groupName;
  final double youOwe;
  final double youAreOwed;
  final VoidCallback onTap;

  const GroupCard({
    super.key,
    required this.groupName,
    required this.youOwe,
    required this.youAreOwed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Icon
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.blue.shade100,
                child: const Icon(Icons.groups, color: Colors.blue, size: 28),
              ),
              const SizedBox(width: 16),

              // Group Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupName,
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (youOwe > 0)
                      Text(
                        "You owe: ₹$youOwe",
                        style: const TextStyle(color: Colors.red),
                      ),
                    if (youAreOwed > 0)
                      Text(
                        "You are owed: ₹$youAreOwed",
                        style: const TextStyle(color: Colors.green),
                      ),
                  ],
                ),
              ),

              // Right Arrow
              const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
