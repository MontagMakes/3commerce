import 'package:flutter/material.dart';

class CheckoutFormPayment extends StatelessWidget {
  const CheckoutFormPayment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
