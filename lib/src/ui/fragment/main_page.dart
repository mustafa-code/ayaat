import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/resources/api_provider.dart';
import 'package:flutter_app/src/ui/general/file_page.dart';
import 'package:flutter_app/src/ui/general/home.dart';
import 'package:flutter_app/src/utils/utils.dart';
import 'package:flutter_app/src/widgets/custom_app_bar.dart';
import 'package:lottie/lottie.dart';

class MainPage extends StatefulWidget {
  final VoidCallback onOpenDrawer;
  final HomeStatus homeStatus;
  const MainPage({Key? key, required this.onOpenDrawer, required this.homeStatus}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final api = ApiProvider();

  @override
  void dispose() {
    api.close();
    super.dispose();
  }

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
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future: api.doRequest("get_files.php", Method.get),
                    builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      if(snapshot.hasData){
                        Map<String, dynamic>? response = snapshot.data;
                        log("response: ${response!.containsKey("success") && response["success"] &&
                            response["data"] is List && response["data"].isNotEmpty}");
                        if(response.containsKey("success") && response["success"] &&
                            response["data"] is List && response["data"].isNotEmpty){
                          List list = response["data"];
                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              var item = list[index];
                              List<String> images = [
                                "assets/images/file_apk.png",
                                "assets/images/file_docx.png",
                                "assets/images/file_ppt.png",
                                "assets/images/file_rar.png",
                              ];
                              return InkWell(
                                onTap: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => FilePage(
                                        data: item,
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Image(
                                            image: AssetImage(images[index%4]),
                                            width: 54,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            getFileSize(int.tryParse("${item["size_after"]}") ?? 0, 1),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item["title"],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              item["email"],
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              item["message"],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Lottie.asset(
                            "assets/anim/empty.json",
                          );
                        }
                      } else {
                        return Lottie.asset(
                          "assets/anim/loading.json",
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
