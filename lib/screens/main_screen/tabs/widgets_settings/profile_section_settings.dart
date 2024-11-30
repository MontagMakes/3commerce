import 'package:e_commerce/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSectionSettings extends StatelessWidget {
  const ProfileSectionSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              userProvider.currentUserData?.name ?? 'UserName',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userProvider.currentUserData?.email ?? 'UserEmail',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ));
  }
}
