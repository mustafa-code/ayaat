import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String label;
  final String image;
  final VoidCallback? onTap;
  const DrawerItem({Key? key, required this.label, required this.image, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      onTap: onTap,
      leading: Image(
        image: AssetImage(image),
        width: 18,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
