import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.orderDetails});

  final OrderModel orderDetails;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool isLoading = false;

  updateLoadingState(bool newIsloading) {
    setState(() {
      isLoading = newIsloading;
    });
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text("Order Details"),
          actions: [
            IconButton(
              onPressed: () async {
                updateLoadingState(true);
                await orderProvider
                    .deleteOrder(widget.orderDetails.id.toString());
                updateLoadingState(false);

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.delete),
            )
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  ListTile(
                    title: const Text("Order ID"),
                    subtitle: Text(widget.orderDetails.id.toString()),
                  ),
                  ListTile(
                    title: const Text("Shipped to"),
                    subtitle: Text(widget.orderDetails.address.toString()),
                  ),
                  ListTile(
                    title: const Text("Order Date"),
                    subtitle: Text(widget.orderDetails.orderDate.toString()),
                  ),
                  ListTile(
                    title: const Text("Total Amount"),
                    subtitle: Text(widget.orderDetails.totalAmount.toString()),
                  ),
                  ListTile(
                    title: const Text("Order Status"),
                    subtitle: Text(widget.orderDetails.status.toString()),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "Products",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.orderDetails.products.length,
                    itemBuilder: (context, index) {
                      final product = widget.orderDetails.products[index];
                      return ListTile(
                        leading: Image.network(product.imageUrl),
                        title: Text(product.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Price: ${product.price.toString()} pkr'),
                            Text('Category: ${product.category}')
                          ],
                        ),
                      );
                    },
                  )
                ],
              ));
  }
}
