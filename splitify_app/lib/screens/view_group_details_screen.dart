import 'package:flutter/material.dart';

class GroupDetailsScreen extends StatelessWidget {
  const GroupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Roommates"),
        leading: const Icon(Icons.arrow_back),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(20),
        //   child: Padding(
        //     padding: const EdgeInsets.only(bottom: 8.0),
        //     child: Text(
        //       "3 members • Created Jan 2024",
        //       style: Theme.of(context).textTheme.bodySmall,
        //     ),
        //   ),
        // ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Total group spending card
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total group spending",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "\$405.14",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Divider(height: 20),
                  _buildBalanceRow("You", "owes \$45.60", Colors.red),
                  _buildBalanceRow("Sarah", "gets back \$23.40", Colors.green),
                  _buildBalanceRow("Mike", "gets back \$22.20", Colors.green),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text("Add Expense"),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Settle Up"),
                  onPressed: () {},
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Recent expenses
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Expenses",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_alt_outlined),
                    tooltip: "Filter expenses",
                  ),
                  Text("Filter", style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          ),

          _buildExpenseCard(
            title: "Utilities Bill - Electric",
            amount: 125.80,
            date: "Aug 21",
            category: "Utilities",
            paidBy: "Sarah",
            splits: const {"You": 41.93, "Sarah": 41.93, "Mike": 41.94},
          ),
          _buildExpenseCard(
            title: "Grocery Shopping - Whole Foods",
            amount: 89.45,
            date: "Aug 19",
            category: "Groceries",
            paidBy: "You",
            splits: const {"You": 29.82, "Sarah": 29.82, "Mike": 29.81},
          ),
        ],
      ),
    );
  }

  // Helper to build balance rows
  Widget _buildBalanceRow(String name, String balance, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          CircleAvatar(radius: 16, child: Text(name[0])),
          const SizedBox(width: 10),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(
            balance,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // Expense card widget
  Widget _buildExpenseCard({
    required String title,
    required double amount,
    required String date,
    required String category,
    required String paidBy,
    required Map<String, double> splits,
  }) {
    return Card(
      margin: const EdgeInsets.only(top: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with title and amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  "\$${amount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Subtitle (date + category)
            Row(
              children: [
                Text(
                  date,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(category, style: const TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Paid by $paidBy",
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const Divider(height: 18),

            // Splits
            Column(
              children:
                  splits.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Row(
                        children: [
                          CircleAvatar(radius: 14, child: Text(entry.key[0])),
                          const SizedBox(width: 10),
                          Text(entry.key),
                          const Spacer(),
                          Text("\$${entry.value.toStringAsFixed(2)}"),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
