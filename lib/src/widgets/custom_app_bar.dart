import 'package:flutter/material.dart';
import 'package:flutter_app/src/ui/fragment/main_page.dart';

class CustomAppBar extends StatelessWidget {
  final Widget leading;

  const CustomAppBar({Key? key, required this.leading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 32),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(250),
          ),
        ),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 24),
            Expanded(
              child: Row(
                children: [
                  const Image(
                    image: AssetImage("assets/images/user_image.png"),
                    width: 42,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          authUser!["name"],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          authUser!["email"],
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
