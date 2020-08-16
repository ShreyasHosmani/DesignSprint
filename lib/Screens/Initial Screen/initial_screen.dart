import 'package:design_sprint/Screens/Initial%20Screen/splash_one.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InitialScreen extends StatefulWidget {

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
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
        height: 123,//MediaQuery.of(context).size.height/7,
        width: 123,//MediaQuery.of(context).size.width/3.5,
        decoration: BoxDecoration(
          color: Color(0xff787CD1),
            borderRadius: BorderRadius.all(Radius.circular(25))
        ),
        child: Center(child: Text("Dt",
          style: GoogleFonts.arimo(
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 54,
                fontWeight: FontWeight.bold,
            ),
          ),
        )),
      ),
    );
  }

  Widget buildProgressIndicator(BuildContext context){
    return CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
    );
  }

  void jumpScreen(BuildContext context){
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashOne()),
      );
    });
  }
}
