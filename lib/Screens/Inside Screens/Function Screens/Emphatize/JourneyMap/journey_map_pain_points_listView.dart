import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/EmpathizeScreens/emphatize_inside_sections_scree3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JourneyMapPainPointsListView extends StatefulWidget {
  @override
  _JourneyMapPainPointsListViewState createState() => _JourneyMapPainPointsListViewState();
}

class _JourneyMapPainPointsListViewState extends State<JourneyMapPainPointsListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Pending...",
            style: GoogleFonts.nunitoSans(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 40,),
          buildNextButton(context),
        ],
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => EmphatizeInsideSections3(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Center(
        child: Container(
          height: 50,
          width: MediaQuery
              .of(context)
              .size
              .width / 2.0,
          decoration: BoxDecoration(
              color: Color(0xff7579cb),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          child: Center(
            child: Text("Next",
              style: TextStyle(
                  color: Colors.white, letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

}
