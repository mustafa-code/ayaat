import 'package:flutter/material.dart';
import 'package:flutter_app/src/ui/general/home.dart';
import 'package:flutter_app/src/utils/dialog_utils.dart';
import 'package:flutter_app/src/widgets/custom_button.dart';

class AccountType extends StatefulWidget {

  const AccountType({Key? key}) : super(key: key);

  @override
  _AccountTypeState createState() => _AccountTypeState();
}

class _AccountTypeState extends State<AccountType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Column(
            children: [


              const SizedBox(height: 24),
              const Text(
                "Account type",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(hintText: "Student account"),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(hintText: "ID"),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: "E-mail confirmation"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                child: const Text("Resend code"),
                onPressed: () {

                },
              ),
              const SizedBox(height: 32),

              Text(
                "contact your department head for more info",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
              Text(
                "Please don't share your personal information like password and security questions with others",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 16),
              CustomButton(
                label: "Confirm",
                onPressed: () async {
                  showLoadingDialog(context);
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) => Home(),
                  ), (route) => false);
                },
              ),
              const SizedBox(height: 160),

              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Hero(
                    tag: "logo",
                    child: Image(
                      image: AssetImage("assets/images/logo_no_label.png"),
                      width: 96,
                    ),
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
