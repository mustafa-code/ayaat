import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: [
                    Image(
                      image: AssetImage("assets/icons/icon_new_message.png"),
                      width: 42,
                    ),
                  ],
                ),
                Image(
                  image: AssetImage("assets/images/user_image.png"),
                  width: 128,
                ),
                SizedBox(height: 24),
                Text(
                  "Ayaat Eihab",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Student account",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
          SizedBox(height: 32),
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email: anexample@mailbox.com", style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text("Subscribed until: 2023", style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text("Data usage: 1.5 GB (75%)", style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text("About me", style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
