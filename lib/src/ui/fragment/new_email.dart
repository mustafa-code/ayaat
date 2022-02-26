import 'package:flutter/material.dart';
import 'package:flutter_app/src/ui/general/send.dart';
import 'package:flutter_app/src/widgets/custom_button.dart';

class NewEmail extends StatefulWidget {
  const NewEmail({Key? key}) : super(key: key);

  @override
  _NewEmailState createState() => _NewEmailState();
}

class _NewEmailState extends State<NewEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
          child: Column(
            children: [
              Row(
                children: [
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
              SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(

                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "email text",
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
                    child: TextFormField(
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
                  const SizedBox(height: 16),
                  Text(
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
                        SizedBox(width: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Column(
                                    children: [
                                      Icon(Icons.add_circle, size: 42, color: Colors.black45),
                                      Text(
                                        "New",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]..addAll(List<Widget>.generate(8, (index) {
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
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                              })),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right, color: Colors.black45),
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
                      SizedBox(width: 16),
                      CustomButton(
                        label: "Send",
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Send(),
                            ),
                          );
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
