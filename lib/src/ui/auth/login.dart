import 'package:flutter/material.dart';
import 'package:flutter_app/src/resources/api_provider.dart';
import 'package:flutter_app/src/ui/auth/register.dart';
import 'package:flutter_app/src/ui/fragment/main_page.dart';
import 'package:flutter_app/src/ui/general/home.dart';
import 'package:flutter_app/src/utils/dialog_utils.dart';
import 'package:flutter_app/src/widgets/custom_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? emailError;
  String? passwordError;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Column(
            children: [
              const Hero(
                tag: "logo",
                child: Image(
                  image: AssetImage("assets/images/logo_no_label.png"),
                  width: 168,
                ),
              ),

              const SizedBox(height: 84),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "E-mail",
                        errorText: emailError,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                        errorText: passwordError,
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: const FaIcon(FontAwesomeIcons.eyeSlash, size: 18),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(
                label: "LOG IN",
                onPressed: () {
                  goHome();
                },
              ),
              const SizedBox(height: 42),
              TextButton(
                child: const Text(
                  "Forget your password click here",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () {

                },
              ),
              const SizedBox(height: 8),
              TextButton(
                child: const Text(
                  "Create account",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Register(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 84),
              const Text(
                "OR sign in with",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      goHome();
                    },
                    child: const Image(
                      image: AssetImage("assets/icons/login_google.png"),
                      width: 54,
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      goHome();
                    },
                    child: const Image(
                      image: AssetImage("assets/icons/login_dropbox.png"),
                      width: 54,
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

  goHome() async {
    setState(() {
      emailError = null;
      passwordError = null;
    });
    if(emailController.text.trim().isEmpty){
      setState(() {
        emailError = "Email is required";
      });
    } else if(passwordController.text.trim().isEmpty){
      setState(() {
        passwordError = "Password is required";
      });
    } else {
      final api = ApiProvider();
      showLoadingDialog(context);
      Map<String, dynamic> response = await api.doRequest("login.php", Method.post, request: {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });
      Navigator.of(context).pop();
      if(response.containsKey("success") && response["success"]){
        authUser = response["user"];
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) => const Home(),
        ), (route) => false);
      } else {
        showCustomErrorDialog(context, "Login Error", response["message"] ?? "Fail to login, check server IP address", "OK");
      }
    }
  }
}
