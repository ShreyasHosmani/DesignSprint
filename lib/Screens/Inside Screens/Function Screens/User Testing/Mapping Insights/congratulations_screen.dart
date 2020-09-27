import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Congratulations extends StatefulWidget {
  @override
  _CongratulationsState createState() => _CongratulationsState();
}

class _CongratulationsState extends State<Congratulations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildImage(context),
          SizedBox(height: 60,),
          buildText(context),
          SizedBox(height: 26,),
          buildInfoText(context),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context){
    return Container(
      width: 282.15,
      height: 192.54,
      child: Image.asset("assets/images/congratulations.png"),
    );
  }

  Widget buildText(BuildContext context){
    return Text(
      "Congratulations!",
          style: GoogleFonts.nunitoSans(
        textStyle: TextStyle(
          fontSize: 25,
          color: Color(0xff787CD1),
        )
      ),
    );
  }

  Widget buildInfoText(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35),
      child: Text(
        "On completing your design sprint, Please wait until your Decision maker reach out to you.",
        textAlign: TextAlign.center,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
              fontSize: 18,
              color: Color(0xff707070),
            )
        ),
      ),
    );
  }

}
