import 'package:e_commerce/providers/provider_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenCheckout extends StatelessWidget {
  const ScreenCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<ProviderCart>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Checkout", style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.white,
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: ListView(
            children: [
              const Text("shipping address",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Joe Doe',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Address',
                      hintText: '123 Main St',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Postal Code',
                      hintText: '123456',
                      hintStyle: TextStyle(color: Colors.grey),
                      
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Payment method",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(
                width: 300,
                height: 100,
                child: TabBar(tabs: [
                  Tab(
                    icon: Icon(Icons.credit_card),
                    text: "Credit Card",
                  ),
                  Tab(
                    icon: Icon(Icons.payment),
                    text: "PayPal",
                  ),
                  Tab(
                    icon: Icon(Icons.account_balance_wallet),
                    text: "Google Pay",
                  ),
                ]),
              ),
              const SizedBox(
                height: 200,
                child: TabBarView(children: [
                  Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Name on Card',
                          hintText: 'Joe Doe',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Card Number',
                          hintText: '1234 5678 9012 3456',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Exp Date',
                          hintText: 'MM/YY',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Center(child: Text("PayPal")),
                  Center(child: Text("Google Pay")),
                ]),
              ),
              const Text("TOTAL AMOUNT", style: TextStyle(color: Colors.grey)),
              Text("\$${cartProvider.totalAmount}",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  // Handle place order action
                },
                child:
                    const Text("PLACE ORDER", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddressField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget buildPaymentMethodOption(String method, {bool isSelected = false}) {
    return Column(
      children: [
        Text(
          method,
          style: TextStyle(
            color: isSelected ? Colors.red : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (isSelected)
          Container(
            height: 2,
            width: 60,
            color: Colors.red,
            margin: const EdgeInsets.only(top: 5),
          ),
      ],
    );
  }

  Widget buildPaymentField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
