import 'package:e_commerce/providers/provider_favourites.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenFavourites extends StatefulWidget {
  const ScreenFavourites({super.key});

  @override
  State<ScreenFavourites> createState() => _ScreenFavouritesState();
}

class _ScreenFavouritesState extends State<ScreenFavourites> {
  @override
  Widget build(BuildContext context) {
    final favouritesProvider = Provider.of<ProviderFavourites>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(),
        title: const Text("Favourites"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            favouritesProvider.items.isEmpty
                ? const Center(
                  heightFactor: 30,
                    child: Text("List is empty"),
                  )
                : _favouritesList(favouritesProvider)
          ],
        ),
      ),
    );
  }

  Expanded _favouritesList(ProviderFavourites favouritesProvider) {
    return Expanded(
        child: ListView(
      children: List.generate(favouritesProvider.items.length, (index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/productDetails',
                arguments: favouritesProvider.items[index]);
          },
          child: Container(
            
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    constraints:
                        const BoxConstraints(maxHeight: 100, maxWidth: 100),
                    child: Image.asset(favouritesProvider.items[index].imageUrl,
                        fit: BoxFit.cover)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(favouritesProvider.items[index].title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('\$${favouritesProvider.itemsList[index].price}',
                          style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              favouritesProvider
                                  .removeItem(favouritesProvider.items[index]);
                            });
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    ));
  }
}
