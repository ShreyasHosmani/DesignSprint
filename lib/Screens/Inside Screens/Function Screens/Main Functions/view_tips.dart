import 'dart:io';
import 'package:design_sprint/APIs/get_profile.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/IdentifyPainPoints/identify_painpoint_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/JourneyMap/journey_mapping_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/Personas/persona_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Ideation/crazy_8_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Ideation/i_vs_f_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/edit_profile_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/team_data_and_manage_team.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/tutorial_sprint_goal.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_sprints_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Prototyping/prototyping_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Re%20Iterate/reiterate_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/User%20Testing/Mapping%20Insights/Mapping_insights_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/User%20Testing/User%20Interview/user_interview_tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;

class ViewTips extends StatefulWidget {
  @override
  _ViewTipsState createState() => _ViewTipsState();
}

class _ViewTipsState extends State<ViewTips> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProfileApiProvider profileApiProvider = ProfileApiProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      endDrawerEnableOpenDragGesture: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            Divider(thickness: 0.2,color: Colors.black,),
            buildTip1(context),
            Divider(thickness: 0.2,color: Colors.black,),
            buildTip2(context),
            Divider(thickness: 0.2,color: Colors.black,),
            buildTip3(context),
            Divider(thickness: 0.2,color: Colors.black,),
            buildTip4(context),
            Divider(thickness: 0.2,color: Colors.black,),
            buildTip5(context),
            Divider(thickness: 0.2,color: Colors.black,),
            buildTip6(context),
            Divider(thickness: 0.2,color: Colors.black,),
            buildTip7(context),
            Divider(thickness: 0.2,color: Colors.black,),
            buildTip8(context),
            Divider(thickness: 0.2,color: Colors.black,),
            buildTip9(context),
            Divider(thickness: 0.2,color: Colors.black,),
            buildTip10(context),
            Divider(thickness: 0.2,color: Colors.black,),
            buildTip11(context),
            Divider(thickness: 0.2,color: Colors.black,),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context){

    Container line = Container(height:1,color: Colors.black,child: Divider());
    void _openEndDrawer() {
      _scaffoldKey.currentState.openEndDrawer();
    }

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 35, top: 20),
        child: IconButton(
          onPressed: (){Navigator.of(context).pop();},
          icon: Icon(Icons.arrow_back_ios,size: 20, color: Colors.grey.shade700,),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text("Tips",
          style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTip1(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => SprintGoalTutorial(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Text("Define your Goal",
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
           ),
            Icon(Icons.lightbulb_outline, color: Colors.black,size: 20,),
          ],
        ),
      ),
    );
  }

  Widget buildTip2(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => PersonaTutorial(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Create Persona",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
            Icon(Icons.lightbulb_outline, color: Colors.black,size: 20,),
          ],
        ),
      ),
    );
  }

  Widget buildTip3(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => JourneyMappingTutorial(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Journey Mapping",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
            Icon(Icons.lightbulb_outline, color: Colors.black,size: 20,),
          ],
        ),
      ),
    );
  }

  Widget buildTip4(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => IdentifyPainPointTutorial(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Identify Pain Points",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
            Icon(Icons.lightbulb_outline, color: Colors.black,size: 20,),
          ],
        ),
      ),
    );
  }

  Widget buildTip5(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => Crazy8Tutorial(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Crazy 8",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
            Icon(Icons.lightbulb_outline, color: Colors.black,size: 20,),
          ],
        ),
      ),
    );
  }

  Widget buildTip6(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => IvsFTutorial(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Impact vs Feasibility Analysis",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
            Icon(Icons.lightbulb_outline, color: Colors.black,size: 20,),
          ],
        ),
      ),
    );
  }

  Widget buildTip7(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => PrototypingTutorial(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Prototyping",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
            Icon(Icons.lightbulb_outline, color: Colors.black,size: 20,),
          ],
        ),
      ),
    );
  }

  Widget buildTip8(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => UserInterviewTutorial(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("User Interviews",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
            Icon(Icons.lightbulb_outline, color: Colors.black,size: 20,),
          ],
        ),
      ),
    );
  }

  Widget buildTip9(BuildContext context){
    return InkWell(
      onTap: (){

      },
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Shadowing",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
            Icon(Icons.lightbulb_outline, color: Colors.black,size: 20,),
          ],
        ),
      ),
    );
  }

  Widget buildTip10(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => MappingInsightsTutorial(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Mapping Insights",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
            Icon(Icons.lightbulb_outline, color: Colors.black,size: 20,),
          ],
        ),
      ),
    );
  }

  Widget buildTip11(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => ReIterateTutorial(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Re - Ierate",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
            Icon(Icons.lightbulb_outline, color: Colors.black,size: 20,),
          ],
        ),
      ),
    );
  }

}
