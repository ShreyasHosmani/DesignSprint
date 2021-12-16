import 'package:design_sprint/APIs/get_profile.dart';
import 'package:design_sprint/Screens/Initial%20Screen/splash_page_view_builder.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/home_screen.dart';
import 'package:design_sprint/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:design_sprint/utils/profile_data.dart' as profile;

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
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
      body: Center(
        child: buildLogo(context),
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tempID = prefs.getString("userID");
    //setString("userID", profile.userID);
    print(tempID);
    profile.userID = tempID;
    profileApiProvider.getProfile(context);
    Future.delayed(const Duration(seconds: 2), () {
      profileApiProvider.getSideBarProfile();
    });
    Future.delayed(const Duration(seconds: 5), () {
      if(tempID == null || tempID == "null"){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SplashPageViewBuilder()),
        );
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Load()),
        );
      }
    });
  }
}
