import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final GestureTapCallback? ontap;

  const OptionTile(
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
