import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/resources/api_provider.dart';
import 'package:flutter_app/src/sec/encrypt_data.dart';
import 'package:flutter_app/src/ui/general/send.dart';
import 'package:flutter_app/src/utils/dialog_utils.dart';
import 'package:flutter_app/src/utils/utils.dart';
import 'package:flutter_app/src/widgets/custom_button.dart';

class NewEmail extends StatefulWidget {
  const NewEmail({Key? key}) : super(key: key);

  @override
  _NewEmailState createState() => _NewEmailState();
}

class _NewEmailState extends State<NewEmail> {
  var titleController = TextEditingController();
  var messageController = TextEditingController();
  var fileController = TextEditingController();
  var emailController = TextEditingController();
  var keyController = TextEditingController();
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
          child: Column(
            children: [
              Row(
                children: const [
                  Image(
                    image: AssetImage("assets/icons/icon_video.png"),
                    width: 32,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      "Create email",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: titleController,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Title",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: messageController,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Message text",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.all(24),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles();
                        if (result != null && result.files.single.path != null) {
                          file = File(result.files.single.path!);
                          String name = file!.path.split("/").last;
                          int bytes = await file!.length();
                          String size = getFileSize(bytes);
                          fileController.text = "${name.substring(0, name.indexOf("."))} ($size)";
                          String key = await EncryptData.generateFileHash(file!);
                          keyController.text = key;
                        } else {
                          file = null;
                          fileController.text = "";
                          keyController.text = "";
                        }
                      },
                      child: TextFormField(
                        enabled: false,
                        controller: fileController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.attach_file, color: Colors.black45),
                          hintText: "Attach file",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "To:",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Column(
                                    children: const [
                                      Icon(Icons.add_circle, size: 42, color: Colors.black45),
                                      Text(
                                        "New",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ), ...List<Widget>.generate(8, (index) {
                                List<String> images = [
                                  "assets/images/person_2.png",
                                  "assets/images/person_4.png",
                                  "assets/images/person_3.png",
                                  "assets/images/person.png",
                                ];
                                List<String> names = [
                                  "Mona",
                                  "Ahmed",
                                  "Ali",
                                  "Somaya",
                                ];
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  child: Column(
                                    children: [
                                      Image(
                                        image: AssetImage(images[index%4]),
                                        width: 42,
                                      ),
                                      Text(
                                        names[index%4],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: const Icon(Icons.chevron_right, color: Colors.black45),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: emailController,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "E-mail",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: keyController,
                      enabled: false,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Key",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        color: Colors.red,
                        label: "Cancel",
                        onPressed: () {},
                      ),
                      const SizedBox(width: 16),
                      CustomButton(
                        label: "Send",
                        onPressed: () async {
                          int sizeBefore = await file!.length();
                          log("file.length(): ${await file!.length()}");
                          String key = await EncryptData.generateFileHash(file!);
                          // log("key: {$key}");

                          String fileName = file!.path.split("/").last;
                          DateTime start = DateTime.now();
                          String encryptedPath = EncryptData.encryptFile(file!.path, key);
                          log("encryptedPath: {$encryptedPath}");
                          File encrypted = File(encryptedPath);
                          String fileContent = getBase64FormatFile(encrypted.path);
                          int sizeAfter = await encrypted.length();
                          log("encrypted.length(): ${await encrypted.length()}");
                          DateTime end = DateTime.now();

                          var apiProvider = ApiProvider();
                          Map<String, dynamic> request = {
                            "file_content": fileContent,
                            "start_enc": start.toString(),
                            "end_enc": end.toString(),
                            "size_before": sizeBefore,
                            "size_after": sizeAfter,
                            "email": emailController.text.trim(),
                            "title": titleController.text.trim(),
                            "message": messageController.text.trim(),
                            "file_name": fileName,
                            "file_type": fileName.substring(fileName.indexOf(".")+1),
                            "enc_key": key,
                          };
                          showLoadingDialog(context);
                          Map<String, dynamic> response = await apiProvider.doRequest("send_file.php", Method.post, request: request);
                          Navigator.of(context).pop();
                          log("response: ${json.encode(response)}");
                          if(response.containsKey("success") && response["success"]){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Send(
                                  data: response["data"],
                                ),
                              ),
                            );
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
                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
