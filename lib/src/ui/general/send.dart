import 'package:flutter/material.dart';
import 'package:flutter_app/src/utils/utils.dart';
import 'package:flutter_app/src/widgets/custom_app_bar.dart';
import 'package:flutter_app/src/widgets/custom_button.dart';

import 'home.dart';

class Send extends StatelessWidget {
  final Map data;
  const Send({Key? key, required this.data}) : super(key: key);

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
                            children: [
                              Text(
                                data["title"],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                data["email"],
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Encrypted file size: ${getFileSize(int.tryParse("${data["size_after"]}") ?? 0)}",
                                style: const TextStyle(
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data["message"],
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            data["creation_date"],
                            style: const TextStyle(
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
