import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: const [
                    Image(
                      image: AssetImage("assets/icons/icon_new_message.png"),
                      width: 42,
                    ),
                  ],
                ),
                const Image(
                  image: AssetImage("assets/images/user_image.png"),
                  width: 128,
                ),
                const SizedBox(height: 24),
                Text(
                  authUser!["name"],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  authUser!["email"],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email: ${authUser!["email"]}", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                const Text("Subscribed until: 2023", style: TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                const Text("Data usage: 1.5 GB (75%)", style: TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                const Text("About me", style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
