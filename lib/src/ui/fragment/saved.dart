import 'package:flutter/material.dart';
import 'package:flutter_app/src/widgets/custom_app_bar.dart';
import 'package:flutter_app/src/widgets/custom_button.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              leading: RotationTransition(
                turns: AlwaysStoppedAnimation(180 / 360),
                child: Image(
                  image: AssetImage("assets/icons/icon_video.png"),
                  width: 32,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Image(
                          image: AssetImage("assets/images/file_apk.png"),
                          width: 64,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Application file.apk",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "asendner@gmail.com",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "text messages sent while the file is shown here",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "20/10/2021 14:21:32",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 220),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                          flex: 2,
                          child: CustomButton(
                            color: Colors.green,
                            label: "Open",
                            onPressed: () {
                            },
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Expanded(
                          flex: 7,
                          child: CustomButton(
                            color: Colors.red,
                            label: "Delete",
                            onPressed: () {
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 7,
                          child: CustomButton(
                            label: "Download",
                            onPressed: () {
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
