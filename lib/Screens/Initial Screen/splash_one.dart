import 'package:design_sprint/Screens/Initial%20Screen/splash_three.dart';
import 'package:design_sprint/Screens/Inside%20Screens/LoginSignUp%20Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashOne extends StatefulWidget {
  @override
  _SplashOneState createState() => _SplashOneState();
}

class _SplashOneState extends State<SplashOne> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildCenterCard(context),
              buildInfoText(context),
            ],
          ),
        //buildSkipButton(context),
      ],
    );
  }

  Widget buildSkipButton(BuildContext context){
    return GestureDetector(
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
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 50, right: 36),
          child: Text("SKIP",
            style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                  color: Color(0xff302b6f),
                  fontSize: 20,
                  letterSpacing: 0
              ),
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
        height: MediaQuery.of(context).size.height/3.5,
        width: MediaQuery.of(context).size.width/1.5,
        child: Image.asset("assets/images/initialscreen1.png"),
      ),
    );
  }

  Widget buildInfoText(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 35,),
        Text("WELCOME",
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
        Text("This is your personal assistant which", style: textStyle(),),
        Text("assists you to run successful design", style: textStyle(),),
        Text("sprints.", style: textStyle(),),
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
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: Color(0xff302b6f),
                borderRadius: BorderRadius.all(Radius.circular(50))
            ),
          ),
          SizedBox(width: 10.33,),
          buildEmptyPositionContainer(context),
          SizedBox(width: 10.33,),
          buildEmptyPositionContainer(context),
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
