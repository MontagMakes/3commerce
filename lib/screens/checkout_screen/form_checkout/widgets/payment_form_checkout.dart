import 'package:flutter/material.dart';

class PaymentFormCheckout extends StatelessWidget {
  const PaymentFormCheckout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Payment Method
        const Text("Payment method",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),

        // Credit Card
        const Text("Credit Card"),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Name on Card',
            hintText: 'Joe Doe',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Card Number',
            hintText: '1234 5678 9012 3456',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Expiry Date',
            hintText: '01/04/23',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
