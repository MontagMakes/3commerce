import 'package:e_commerce/providers/provider_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<ProviderAuth>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [_profileSection(authProvider), _accountOptions(context)],
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
          const AccountOptionTile(
            icon: Icons.local_shipping,
            title: 'Upcoming Orders',
            trailing: '0',
          ),
          AccountOptionTile(icon: Icons.favorite_sharp, title: "Favourites", ontap: () => Navigator.pushNamed(context, '/favourites'),),
          const AccountOptionTile(
            icon: Icons.location_on,
            title: 'Manage Address',
          ),
          const AccountOptionTile(
            icon: Icons.payment,
            title: 'Update payment',
          ),
          const AccountOptionTile(
            icon: Icons.chat_bubble_outline,
            title: 'My Chats',
          ),
        ],
      ),
    );
  }

  Container _profileSection(ProviderAuth authProvider) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              authProvider.currentUser?.name ?? 'User',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              authProvider.currentUser?.email ?? 'Email Address',
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
      {super.key, required this.icon, required this.title, this.trailing, this.ontap});

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
