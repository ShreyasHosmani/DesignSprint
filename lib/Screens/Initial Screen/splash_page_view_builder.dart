import 'package:design_sprint/Screens/Initial%20Screen/splash_one.dart';
import 'package:design_sprint/Screens/Initial%20Screen/splash_three.dart';
import 'package:design_sprint/Screens/Initial%20Screen/splash_two.dart';
import 'package:flutter/material.dart';

class SplashPageViewBuilder extends StatefulWidget {
  @override
  _SplashPageViewBuilderState createState() => _SplashPageViewBuilderState();
}

class _SplashPageViewBuilderState extends State<SplashPageViewBuilder> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          SplashOne(),
          SplashTwo(),
          SplashThree(),
        ],
      ),
    );
  }
}
