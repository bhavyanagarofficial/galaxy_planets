import 'dart:async';

import 'package:flutter/material.dart';
import 'package:space_app/view/components/my_text.dart';
import 'package:space_app/view/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(
      const Duration(seconds: 4
      ),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Galaxy\nGuide",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: size.width * 0.09,fontWeight: FontWeight.w700, fontFamily: "pop"),
        ),
      ),
    );
  }
}
