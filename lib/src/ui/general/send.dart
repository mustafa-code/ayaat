import 'package:flutter/material.dart';
import 'package:flutter_app/src/widgets/custom_app_bar.dart';
import 'package:flutter_app/src/widgets/custom_button.dart';

import 'home.dart';

class Send extends StatelessWidget {
  const Send({Key? key}) : super(key: key);

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
                    const SizedBox(height: 32),
                    const Image(
                      image: AssetImage("assets/icons/icon_check.png"),
                      width: 220,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "File sent successfully",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 42),
                    CustomButton(
                      label: "OK",
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                          builder: (context) => const Home(
                            homeStatus: HomeStatus.sent,
                          ),
                        ), (route) => false);
                      },
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
