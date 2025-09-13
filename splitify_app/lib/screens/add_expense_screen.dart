import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // <-- for date formatting

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String? selectedCategory;

  // Who paid
  String? paidBy;

  // Group dropdown
  String? selectedGroup;

  // Participants
  final List<String> participants = [
    "Sarah Chen",
    "Mike Johnson",
    "Emma Davis",
    "Alex Wilson",
    "John Doe",
  ];
  final List<String> selectedParticipants = [];

  // Split options
  String splitOption = "equal";

  final DateFormat dateFormatter = DateFormat("yyyy-MM-dd");

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Expense")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expense Details
            Text(
              "Expense Details",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: "Description",
                      ),
                    ),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Amount (\$)",
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Date: ${dateFormatter.format(selectedDate)}",
                          ),
                        ),
                        TextButton(
                          onPressed: _pickDate,
                          child: const Text("Select Date"),
                        ),
                      ],
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: const InputDecoration(labelText: "Category"),
                      items:
                          ["Food", "Travel", "Shopping", "Other"]
                              .map(
                                (cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(cat),
                                ),
                              )
                              .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedCategory = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Who Paid
            Text("Who Paid?", style: Theme.of(context).textTheme.titleLarge),
            Card(
              child: Column(
                children:
                    participants
                        .map(
                          (p) => RadioListTile<String>(
                            title: Text(p),
                            value: p,
                            groupValue: paidBy,
                            onChanged: (val) {
                              setState(() {
                                paidBy = val;
                              });
                            },
                          ),
                        )
                        .toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Split With
            Text("Split With", style: Theme.of(context).textTheme.titleLarge),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedGroup,
                      decoration: const InputDecoration(
                        labelText: "Select Group",
                      ),
                      items:
                          ["No group", "Trip to Goa", "Office Friends"]
                              .map(
                                (grp) => DropdownMenuItem(
                                  value: grp,
                                  child: Text(grp),
                                ),
                              )
                              .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedGroup = val;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    const Text("Participants:"),
                    Column(
                      children:
                          participants
                              .map(
                                (p) => CheckboxListTile(
                                  title: Text(p),
                                  value: selectedParticipants.contains(p),
                                  onChanged: (bool? checked) {
                                    setState(() {
                                      if (checked == true) {
                                        selectedParticipants.add(p);
                                      } else {
                                        selectedParticipants.remove(p);
                                      }
                                    });
                                  },
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Split Options
            Text(
              "Split Options",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Card(
              child: Column(
                children: [
                  RadioListTile(
                    title: const Text("Split equally"),
                    value: "equal",
                    groupValue: splitOption,
                    onChanged: (val) {
                      setState(() {
                        splitOption = val.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text("Split by shares"),
                    value: "shares",
                    groupValue: splitOption,
                    onChanged: (val) {
                      setState(() {
                        splitOption = val.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text("Enter exact amounts"),
                    value: "exact",
                    groupValue: splitOption,
                    onChanged: (val) {
                      setState(() {
                        splitOption = val.toString();
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Additional Details
            Text(
              "Additional Details",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      controller: locationController,
                      decoration: const InputDecoration(labelText: "Location"),
                    ),
                    TextField(
                      controller: notesController,
                      decoration: const InputDecoration(labelText: "Notes"),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Add Expense Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // handle save logic here
                  debugPrint("Expense Added");
                },
                child: const Text("Add Expense"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
