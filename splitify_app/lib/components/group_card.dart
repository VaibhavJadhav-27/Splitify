import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final String groupName;
  final List<String> members;
  final double totalAmount;
  final String lastExpense;
  final String timeAgo;
  final double balance;
  final bool isSettled;
  final VoidCallback onTap;

  const GroupCard({
    super.key,
    required this.groupName,
    required this.members,
    required this.totalAmount,
    required this.lastExpense,
    required this.timeAgo,
    required this.balance,
    required this.isSettled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Color getBalanceColor() {
      if (isSettled) return Colors.grey;
      return balance < 0 ? Colors.red : Colors.green;
    }

    String getBalanceText() {
      if (isSettled) return "Settled";
      return (balance < 0 ? "- ₹" : "+ ₹") + balance.abs().toStringAsFixed(2);
    }

    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    groupName,
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: getBalanceColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      getBalanceText(),
                      style: TextStyle(
                        color: getBalanceColor(),
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.035,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Member avatars
              Row(
                children: [
                  const Icon(Icons.group, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text("${members.length} members"),
                  const SizedBox(width: 12),
                  ...members.take(5).map((name) {
                    return Container(
                      margin: const EdgeInsets.only(right: 4),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300,
                      ),
                      child: Text(name, style: const TextStyle(fontSize: 12)),
                    );
                  }).toList(),
                ],
              ),

              const SizedBox(height: 8),
              Divider(),
              const SizedBox(height: 8),
              // Bottom: Total + Last expense
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text("Total: ₹${totalAmount.toStringAsFixed(2)}"),
                    ],
                  ),
                  if (lastExpense.isNotEmpty)
                    Text(
                      "$lastExpense • $timeAgo",
                      style: const TextStyle(color: Colors.grey),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
