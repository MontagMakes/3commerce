import 'package:e_commerce/providers/provider_user.dart';
import 'package:e_commerce/screens/my_products_screen/my_products_screen.dart';
import 'package:e_commerce/screens/order_history_screen/order_history_screen.dart';
import 'package:e_commerce/screens/sign_in_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [_profileSection(userProvider), _accountOptions(context)],
      ),
    );
  }

  Container _accountOptions(context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          AccountOptionTile(
              icon: Icons.add_box,
              title: 'My products',
              ontap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyProductsScreen(),
                  ))),
          AccountOptionTile(
              icon: Icons.local_shipping,
              title: 'My Orders',
              ontap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrderHistoryScreen()))),
          AccountOptionTile(
            icon: Icons.logout,
            title: 'Sign Out',
            ontap: () async {
              await Provider.of<UserProvider>(context, listen: false).signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInScreen()));
            },
          ),
        ],
      ),
    );
  }

  Container _profileSection(UserProvider userProvider) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              userProvider.getUserName() ?? 'User',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userProvider.getUserEmail() ?? 'Email Address',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ));
  }
}

class AccountOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final GestureTapCallback? ontap;

  const AccountOptionTile(
      {super.key,
      required this.icon,
      required this.title,
      this.trailing,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title),
      trailing: trailing != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(trailing!),
            )
          : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: ontap,
    );
  }
}
