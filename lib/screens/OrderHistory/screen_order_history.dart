import 'package:e_commerce/providers/provider_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenOrderHistory extends StatelessWidget {
  const ScreenOrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderOrder providerOrder = Provider.of<ProviderOrder>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const BackButton(),
          title: const Text("Order History"),
        ),
        body: providerOrder.orders.isEmpty
            ? const Center(child: Text("No Orders Yet"))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: providerOrder.orders.length,
                        itemBuilder: (context, index) {
                          final element = providerOrder.orders[index];
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
                                    Navigator.pushNamed(context, '/orderDetails',
                                        arguments: index);
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
