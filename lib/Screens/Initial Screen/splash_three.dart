import 'package:design_sprint/Screens/Inside%20Screens/LoginSignUp%20Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashThree extends StatefulWidget {
  @override
  _SplashThreeState createState() => _SplashThreeState();
}

class _SplashThreeState extends State<SplashThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: buildPositionWidget(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSkipButton(context),
            SizedBox(height: MediaQuery.of(context).size.height/15),
            buildCenterCard(context),
            buildInfoText(context),
          ],
        ),
      ),
    );
  }

  Widget buildSkipButton(BuildContext context){
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 68, right: 36),
        child: Text("",
          style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                color: Color(0xff302b6f),
                fontSize: 20,
                letterSpacing: 0
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCenterCard(BuildContext context){
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 194.1,
        width: 308,
        child: Image.asset("assets/images/initialscreen3.png"),
      ),
    );
  }

  Widget buildInfoText(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 35,),
        Text("USEFUL TIPS",
          style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                color: Color(0xff302b6f),
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: 0
            ),
          ),
        ),
        SizedBox(height: 15,),
        Text("Provides useful tips by assisting", style: textStyle(),),
        Text("you to right direction of sprints", style: textStyle(),),
        SizedBox(height: 30,),
        GestureDetector(
          onTap: (){
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => Login(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          },
          child: Container(
            height: 50, width: 100,
            child: Center(
              child: Text("Get Started",
                style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(fontSize: 18,color: Color(0xff787CD1),letterSpacing: 0),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  TextStyle textStyle(){
    return GoogleFonts.nunitoSans(
        textStyle: TextStyle(
            letterSpacing: 0,
            fontSize: 18
        )
    );
  }

  Widget buildPositionWidget(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildEmptyPositionContainer(context),
          SizedBox(width: 10.33,),
          buildEmptyPositionContainer(context),
          SizedBox(width: 10.33,),
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
                color: Color(0xff302b6f),
                borderRadius: BorderRadius.all(Radius.circular(50))
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyPositionContainer(BuildContext context){
    return Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xff302b6f)),
          borderRadius: BorderRadius.all(Radius.circular(50))
      ),
    );
  }


}
