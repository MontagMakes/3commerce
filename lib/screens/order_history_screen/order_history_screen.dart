import 'package:e_commerce/providers/order_provider.dart';
import 'package:e_commerce/screens/order_details_screen/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text("Order History"),
        ),
        body: orderProvider.orders.isEmpty
            ? const Center(child: Text("No Orders Yet"))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: orderProvider.orders.length,
                        itemBuilder: (context, index) {
                          final element = orderProvider.orders[index];
                          return Card(
                            elevation: 5,
                            color: Colors.white,
                            clipBehavior: Clip.hardEdge,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    'Order ID: ${element.id.toString()}',
                                  ),
                                  subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Total Cost: ${element.totalAmount}'),
                                        Text(
                                            'Order Date: ${element.orderDate}'),
                                        Text('Order Status: ${element.status}'),
                                      ]),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return OrderDetailsScreen(
                                          orderDetails: element);
                                    }));
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ));
  }
}
