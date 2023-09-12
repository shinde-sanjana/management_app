import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ssm_app/login/login_screen.dart';

import 'config.dart';

void main() {
  runApp(const SplashScreen());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    // print(AppConfig.offline);
    if (!AppConfig.offline) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const FormScreen()));
    } else {
      // work on offline process
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const FormScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  colors: [],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
          ),
          Center(
            child: Image.asset(
              "assets/images/Screenshot_from_2022-12-13_17-24-02_2-removebg-preview.png",
            ),
          ),
        ],
      ),
    );
  }
}
