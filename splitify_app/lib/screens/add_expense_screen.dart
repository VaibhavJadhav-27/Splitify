import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String? _selectedPayer;
  String _splitOption = 'equally';
  Map<String, bool> selectedMembers = {
    'Alice': false,
    'Bob': false,
    'Charlie': false,
  };
  Map<String, TextEditingController> amountControllers = {
    'Alice': TextEditingController(),
    'Bob': TextEditingController(),
    'Charlie': TextEditingController(),
  };

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    for (var controller in amountControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Paid by',
                border: OutlineInputBorder(),
              ),
              value: _selectedPayer,
              items:
                  ['Alice', 'Bob', 'Charlie']
                      .map(
                        (name) =>
                            DropdownMenuItem(value: name, child: Text(name)),
                      )
                      .toList(),
              onChanged: (value) => setState(() => _selectedPayer = value),
            ),
            const SizedBox(height: 24),
            const Text(
              'Split options',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            RadioListTile(
              title: const Text('Split equally'),
              value: 'equally',
              groupValue: _splitOption,
              onChanged:
                  (value) => setState(() => _splitOption = value as String),
            ),
            RadioListTile(
              title: const Text('Split among'),
              value: 'among',
              groupValue: _splitOption,
              onChanged:
                  (value) => setState(() => _splitOption = value as String),
            ),
            if (_splitOption == 'among')
              Column(
                children:
                    selectedMembers.keys.map((member) {
                      return Row(
                        children: [
                          Checkbox(
                            value: selectedMembers[member],
                            onChanged: (value) {
                              setState(() => selectedMembers[member] = value!);
                            },
                          ),
                          Expanded(child: Text(member)),
                          if (selectedMembers[member] == true)
                            SizedBox(
                              width: width * 0.4,
                              child: TextField(
                                controller: amountControllers[member],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'Amount',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                        ],
                      );
                    }).toList(),
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Save logic here
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
