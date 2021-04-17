import 'package:design_sprint/APIs/get_profile.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/User%20Testing/Mapping%20Insights/Mapping_insights_tutorial_screen.dart';
import 'package:design_sprint/Screens/Tool%20Tip%20Screens/Tool%20Tip%20Tutorials/crazy_8_tutorial_screen_2.dart';
import 'package:design_sprint/Screens/Tool%20Tip%20Screens/Tool%20Tip%20Tutorials/i_vs_f_tutorial_screen_2.dart';
import 'package:design_sprint/Screens/Tool%20Tip%20Screens/Tool%20Tip%20Tutorials/identify_painpoint_tutorial_screen_2.dart';
import 'package:design_sprint/Screens/Tool%20Tip%20Screens/Tool%20Tip%20Tutorials/journey_mapping_tutorial_screen_2.dart';
import 'package:design_sprint/Screens/Tool%20Tip%20Screens/Tool%20Tip%20Tutorials/persona_tutorial_screen_2.dart';
import 'package:design_sprint/Screens/Tool%20Tip%20Screens/Tool%20Tip%20Tutorials/prototyping_tutorial_screen_2.dart';
import 'package:design_sprint/Screens/Tool%20Tip%20Screens/Tool%20Tip%20Tutorials/reiterate_tutorial_screen_2.dart';
import 'package:design_sprint/Screens/Tool%20Tip%20Screens/Tool%20Tip%20Tutorials/shadowing_tutorial_screen_2.dart';
import 'package:design_sprint/Screens/Tool%20Tip%20Screens/Tool%20Tip%20Tutorials/tutorial_sprint_goal_2.dart';
import 'package:design_sprint/Screens/Tool%20Tip%20Screens/Tool%20Tip%20Tutorials/user_interview_tutorial_screen_2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewTips extends StatefulWidget {
  @override
  _ViewTipsState createState() => _ViewTipsState();
}

class _ViewTipsState extends State<ViewTips> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProfileApiProvider profileApiProvider = ProfileApiProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
            pageBuilder: (c, a1, a2) => SprintGoalTutorial2(),
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
            pageBuilder: (c, a1, a2) => PersonaTutorial2(),
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
            pageBuilder: (c, a1, a2) => JourneyMappingTutorial2(),
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
            pageBuilder: (c, a1, a2) => IdentifyPainPointTutorial2(),
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
            pageBuilder: (c, a1, a2) => Crazy8Tutorial2(),
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
            pageBuilder: (c, a1, a2) => IvsFTutorial2(),
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
            pageBuilder: (c, a1, a2) => PrototypingTutorial2(),
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
            pageBuilder: (c, a1, a2) => UserInterviewTutorial2(),
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
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => ShadowingTutorial2(),
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
            pageBuilder: (c, a1, a2) => ReIterateTutorial2(),
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
