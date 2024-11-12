import 'package:e_commerce/models/model_product.dart';
import 'package:e_commerce/providers/provider_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _searchController;

  List<ProductModel> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  Future<void> _performSearch(String query, products) async {
    List<ProductModel> allProducts = products;
    setState(() {
      _searchResults = allProducts
          .where((product) =>
              product.title.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> getProducts(ProviderProduct product) async {
    await product.fetchProductData();
  }

  @override
  Widget build(BuildContext context) {
    final providerProduct = Provider.of<ProviderProduct>(context);

    List<ProductModel> listOfProducts = providerProduct.totalProducts;

    List<ProductModel> displayProducts =
        _searchController.text.isEmpty ? listOfProducts : _searchResults;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.search),
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          style: const TextStyle(color: Colors.black),
          onChanged: (value) {
            // Handle search input change
            _performSearch(value, listOfProducts);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GridView.count(
            physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: [
              for (var product in displayProducts)
                InkWell(
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.white,
                    elevation: 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/productDetails',
                            arguments: product);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: NetworkImage(product.imageUrl),
                            height: 120,
                            width: 130,
                          ),
                          Text(
                            product.title,
                            style: const TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 7.0, right: 7.0, top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${product.price.toString()}",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),
                                const SizedBox(width: 70),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ]),
      ),
    );
  }
}
