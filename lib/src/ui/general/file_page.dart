import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/resources/api_provider.dart';
import 'package:flutter_app/src/sec/encrypt_data.dart';
import 'package:flutter_app/src/utils/dialog_utils.dart';
import 'package:flutter_app/src/utils/utils.dart';
import 'package:flutter_app/src/widgets/custom_app_bar.dart';
import 'package:flutter_app/src/widgets/custom_button.dart';
import 'package:path_provider/path_provider.dart';

class FilePage extends StatefulWidget {
  final Map data;
  const FilePage({Key? key, required this.data}) : super(key: key);

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const RotationTransition(
                  turns: AlwaysStoppedAnimation(180 / 360),
                  child: Image(
                    image: AssetImage("assets/icons/icon_video.png"),
                    width: 32,
                  ),
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
                                widget.data["title"],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                widget.data["email"],
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Encrypted file size: ${getFileSize(int.tryParse("${widget.data["size_after"]}") ?? 0)}",
                                style: const TextStyle(
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
                        children: [
                          Text(
                            widget.data["message"],
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            widget.data["creation_date"],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 220),
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
                            onPressed: () async {
                              var api = ApiProvider();
                              showLoadingDialog(context);
                              Map<String, dynamic> response = await api.doRequest("delete.php", Method.get, request: {
                                "id": widget.data["id"],
                              });
                              log("response: ${json.encode(response)}");
                              Navigator.of(context).pop();
                              api.close();

                              if(response.containsKey("success") && response["success"]){
                                Navigator.of(context).pop();
                              } else if(response.containsKey("error_code") && response["error_code"] == 18){
                                List<String> errors = [];
                                for(var requestKey in response["errors"].keys.toList()){
                                  List errorList = response["errors"][requestKey];
                                  for(var errorItem in errorList){
                                    errors.add(errorItem["message"]);
                                  }
                                }
                                showCustomErrorDialog(context, response["message"], errors.join(".\n"), "OK");
                              } else {
                                showCustomErrorDialog(context, "Server Error", response["message"], "OK");
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 7,
                          child: CustomButton(
                            label: "Open",
                            onPressed: () async {
                              Directory appDocDir = await getApplicationDocumentsDirectory();

                              Directory dir = await getTemporaryDirectory();

                              String path = "${dir.path}/${widget.data["id"]}-${widget.data["file_name"]}.aes";
                              File file = File(path);
                              log("widget.data[\"enc_key\"]: ${widget.data["enc_key"]}");
                              if(await file.exists()){
                                log("file: ${await file.length()}");
                                String cry = EncryptData.decryptFile(path, widget.data["enc_key"]);
                                log("cry: $cry");
                                return;
                              }
                              log("path: $path");
                              String? result = await downloadFile(widget.data["file_url"], path);
                              if(result == null){
                                showCustomErrorDialog(context, "Permission", "Permissions not granted", "Ok");
                              } else {
                                log("result: $result");
                                log("widget.data[\"enc_key\"]: ${widget.data["enc_key"]}");
                                String cry = EncryptData.decryptFile(result, widget.data["enc_key"]);
                                log("cry: $cry");
                              }
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

  Future<String?> downloadFile(String url, String path) async {
    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = url;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if(response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$path';
        file = File(filePath);
        file = await file.create();
        await file.writeAsBytes(bytes);
        return filePath;
      }
    }
    catch(ex){
      log("ex: ${ex}");
    }

    return null;
  }

}
