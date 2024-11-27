import 'package:e_commerce/globals.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/screens/main_screen/tabs/widgets_home/display_products_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({
    super.key,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late TextEditingController _searchController;
  List<ProductModel> _searchResults = [];
  String filter = '';

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

  void _filterByCategory(String category) {
    if (filter != category) {
      setState(() {
        filter = category;
      });
    } else {
      setState(() {
        filter = '';
      });
    }
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

  List<ProductModel> _displayProducts(List<ProductModel> listOfProducts) {
    if (filter == '') {
      if (_searchController.text.isEmpty) {
        return listOfProducts;
      } else {
        return _searchResults;
      }
    } else {
      if (_searchController.text.isEmpty) {
        return listOfProducts
            .where((element) => element.category == filter)
            .toList();
      } else {
        return _searchResults
            .where(
              (element) => element.category == filter,
            )
            .toList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> listOfProducts =
        Provider.of<ProductProvider>(context).totalProducts;

    List<ProductModel> displayProducts = _displayProducts(listOfProducts);

    List<String> categories = Globals.categories;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.search),

        // Search bar
        title: TextField(
          controller: _searchController,
          autofocus: false,
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
        actions: [
          IconButton(
            onPressed: () {
              
              showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                      title: const Text('Filter'),
                      children: List.generate(categories.length, (index) {
                          return ListTile(
                            title: Text(categories[index]),
                            onTap: () {
                              _filterByCategory(categories[index]);

                              Navigator.pop(context);
                            },
                            trailing: filter == categories[index]
                                ? const Icon(Icons.check)
                                : null,
                          );
                        })
                  );
                },
              );
            },
            icon: const Icon(Icons.filter_list),
          )
        ],
      ),
      body: DisplayProductsHome(products: displayProducts),
    );
  }
}
