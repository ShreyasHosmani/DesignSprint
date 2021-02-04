import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/EmpathizeScreens/emphatize_inside_sections_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Ideation/ideation_inside_sections_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/design_sprint_sections_screen3.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/design_sprint_sections_screen5.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/input_sprint_goal.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_team_by_sprints_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/User%20Testing/User%20Testing%20Screens/user_testing_inside_sections1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;

class StatusDrawerUserTesting extends StatefulWidget {
  @override
  _StatusDrawerUserTestingState createState() => _StatusDrawerUserTestingState();
}

class _StatusDrawerUserTestingState extends State<StatusDrawerUserTesting> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20.0,
      child: Container(
        child: Drawer(
          elevation: 10,
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  color: Color(0xff787CD1),
                  child: Center(
                    child: Text(home.savedSprintName,
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => InputSprintGoal(),
                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 25),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 8,
                        width: 8,
                        child: Divider(color: Colors.grey,),
                      ),
                      SizedBox(width: 10,),
                      Text("Sprint Goal",
                        style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => EmphatizeInsideSections(),
                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 25),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 8,
                        width: 8,
                        child: Divider(color: Colors.grey,),
                      ),
                      SizedBox(width: 10,),
                      Text("Empathize",
                        style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => IdeationInsideSections(),
                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 25),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 8,
                        width: 8,
                        child: Divider(color: Colors.grey,),
                      ),
                      SizedBox(width: 10,),
                      Text("Ideation",
                        style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => EmphatizeSections3(),
                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 25),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 8,
                        width: 8,
                        child: Divider(color: Colors.grey,),
                      ),
                      SizedBox(width: 10,),
                      Text("Prototype",
                        style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => UserTestingInsideSections1(),
                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 25),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 8,
                        width: 8,
                        child: Divider(color: Colors.grey,),
                      ),
                      SizedBox(width: 10,),
                      Text("User Testing",
                        style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => EmphatizeSections5(),
                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 25),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            border: Border.all(color: Colors.grey)
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 8,
                        width: 8,
                        child: Divider(color: Colors.grey,),
                      ),
                      SizedBox(width: 10,),
                      Text("Re - Iterate",
                        style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => ViewTeamBySprints(home.sprintID),
                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 25),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        height: 8,
                        width: 8,
                        child: Divider(color: Colors.grey,),
                      ),
                      SizedBox(width: 10,),
                      Text("Team",
                        style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
