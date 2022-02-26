import 'package:flutter/material.dart';
import 'package:flutter_app/src/ui/general/home.dart';
import 'package:flutter_app/src/widgets/custom_app_bar.dart';

class MainPage extends StatefulWidget {
  final VoidCallback onOpenDrawer;
  final HomeStatus homeStatus;
  const MainPage({Key? key, required this.onOpenDrawer, required this.homeStatus}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          leading: GestureDetector(
            child: const Image(
              image: AssetImage("assets/icons/icon_side_window.png"),
              width: 32,
            ),
            onTap: widget.onOpenDrawer,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.homeStatus.text,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 14,
                  itemBuilder: (context, index) {
                    List<String> images = [
                      "assets/images/file_apk.png",
                      "assets/images/file_docx.png",
                      "assets/images/file_ppt.png",
                      "assets/images/file_rar.png",
                    ];
                    return InkWell(
                      onTap: (){

                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage(images[index%4]),
                              width: 64,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Project NO.${index+1}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Text(
                                    "anexample@mailbox.com",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Text(
                                    "Hi sure, this is a new project for you send by Ayaat, please check and confirm.",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
