import 'package:flutter/material.dart';

import '../auth/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: Image(
            image: AssetImage("assets/images/logo.png"),
            width: 160,
          ),
        ),
      ),
    );
  }
}
