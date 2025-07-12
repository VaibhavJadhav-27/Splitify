import 'package:flutter/material.dart';
import 'package:splitify_app/constants/app_strings.dart';

class SettleUpScreen extends StatefulWidget {
  const SettleUpScreen({super.key});

  @override
  State<SettleUpScreen> createState() => _SettleUpScreenState();
}

class _SettleUpScreenState extends State<SettleUpScreen> {
  String? _selectedMethod;

  // final List<String> _paymentMethods = [
  //   'UPI',
  //   'Cash',
  //   'Bank Transfer',
  //   'Other',
  // ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.05),

            Text(
              "You → Friend",
              style: TextStyle(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.height * 0.02),

            Text(
              "₹0",
              style: TextStyle(
                fontSize: size.width * 0.12,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.04),

            DropdownButtonFormField<String>(
              value: _selectedMethod,
              items:
                  AppStrings.paymentMethods
                      .map(
                        (method) => DropdownMenuItem(
                          value: method,
                          child: Text(method),
                        ),
                      )
                      .toList(),
              onChanged: (val) => setState(() => _selectedMethod = val),
              decoration: const InputDecoration(
                labelText: 'Payment method',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: size.height * 0.05),

            ElevatedButton(
              onPressed: () {
                if (_selectedMethod != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Settled via $_selectedMethod')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Select a payment method')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, size.height * 0.06),
              ),
              child: const Text("Settle up"),
            ),
          ],
        ),
      ),
    );
  }
}
