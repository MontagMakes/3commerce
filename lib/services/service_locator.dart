import 'package:e_commerce/providers/provider_auth.dart';
import 'package:e_commerce/providers/provider_cart.dart';
import 'package:e_commerce/providers/provider_favourites.dart';
import 'package:e_commerce/providers/provider_order.dart';
import 'package:e_commerce/providers/provider_product.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.allowReassignment = true;
  
  getIt.registerSingleton<ProviderAuth>(ProviderAuth());
  getIt.registerSingleton<ProviderCart>(ProviderCart());
  getIt.registerSingleton<ProviderOrder>(ProviderOrder());
  getIt.registerSingleton<ProviderProduct>(ProviderProduct());
  getIt.registerSingleton<ProviderFavourites>(ProviderFavourites());
  
  
}