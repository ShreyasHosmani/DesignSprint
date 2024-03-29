import 'package:design_sprint/APIs/get_profile.dart';
import 'package:design_sprint/Screens/Initial%20Screen/splash_page_view_builder.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/home_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/LoginSignUp%20Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialScreen2 extends StatefulWidget {
  @override
  _InitialScreen2State createState() => _InitialScreen2State();
}

class _InitialScreen2State extends State<InitialScreen2> {
  ProfileApiProvider profileApiProvider = ProfileApiProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jumpScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff302b70),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildLogo(context),
          SizedBox(
            height: MediaQuery.of(context).size.height/15,
          ),
          buildProgressIndicator(context),
        ],
      ),
    );
  }

  Widget buildLogo(BuildContext context){
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 153,
        width: 153,
        decoration: BoxDecoration(
          color: Color(0xff302b70),
            borderRadius: BorderRadius.all(Radius.circular(25))
        ),
        child: Image.asset("assets/images/dezylogo.gif"),
      ),
    );
  }

  Widget buildProgressIndicator(BuildContext context){
    return CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
    );
  }

  Future<void> jumpScreen(BuildContext context) async {
    Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
    });
  }
}
