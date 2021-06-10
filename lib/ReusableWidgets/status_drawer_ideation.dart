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
import 'package:design_sprint/utils/globals.dart' as globals;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/profile_data.dart' as profile;

var teamMemberStatuses1;
var teamMemberStatuses2;
var teamMemberStatuses3;
var teamMemberStatuses4;
var teamMemberStatuses5;
var teamMemberStatuses6;
var teamMemberStatuses7;
var teamMemberStatuses8;
var teamMemberStatuses9;
var teamMemberStatuses10;
var sprintCreatorId;

class StatusDrawerIdeation extends StatefulWidget {
  @override
  _StatusDrawerIdeationState createState() => _StatusDrawerIdeationState();
}

class _StatusDrawerIdeationState extends State<StatusDrawerIdeation> {

  Future<String> getSprintsStatusesOfTeam(context) async {

    String url = globals.urlLogin + "getsprintstatusdata.php";

    http.post(url, body: {

      "sprintID" : home.selectedSprintId.toString() == null || home.selectedSprintId.toString() == "null" ? home.sprintID.toString() : home.selectedSprintId.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayGetSprintStatuses = jsonDecode(response.body);
      print(responseArrayGetSprintStatuses);

      var responseArrayGetSprintStatusesMsg = responseArrayGetSprintStatuses['message'].toString();
      if(statusCode == 200){
        if(responseArrayGetSprintStatusesMsg == "Data Found"){

          setState(() {
            teamMemberStatuses1 = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep1'].toString());
            teamMemberStatuses2 = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep2'].toString());
            teamMemberStatuses3 = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep3'].toString());
            teamMemberStatuses4 = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep4'].toString());
            teamMemberStatuses5 = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep5'].toString());
            teamMemberStatuses6 = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep6'].toString());
            teamMemberStatuses7 = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep7'].toString());
            teamMemberStatuses8 = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep8'].toString());
            teamMemberStatuses9 = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep9'].toString());
            teamMemberStatuses10 = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep10'].toString());
            sprintCreatorId = responseArrayGetSprintStatuses['data'][0]['sprintUserid'].toString();
          });

          print(teamMemberStatuses1);
          print(teamMemberStatuses2);
          print(teamMemberStatuses3);
          print(teamMemberStatuses4);
          print(teamMemberStatuses5);
          print(teamMemberStatuses6);
          print(teamMemberStatuses7);
          print(teamMemberStatuses8);
          print(teamMemberStatuses9);
          print(teamMemberStatuses10);
          print(sprintCreatorId);

        }else{

          setState(() {
            teamMemberStatuses1 = ['1'];
            teamMemberStatuses2 = ['1'];
            teamMemberStatuses3 = ['1'];
            teamMemberStatuses4 = ['1'];
            teamMemberStatuses5 = ['1'];
            teamMemberStatuses6 = ['1'];
            teamMemberStatuses7 = ['1'];
            teamMemberStatuses8 = ['1'];
            teamMemberStatuses9 = ['1'];
            teamMemberStatuses10 = ['1'];
            sprintCreatorId = profile.userID.toString();
          });

        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getSprintsStatusesOfTeam(context);
  }

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
                      SizedBox(width: 25,),
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
                      SizedBox(width: 25,),
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
                      SizedBox(width: 25,),
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

                  },
                  child: Row(
                    children: [
                      SizedBox(width: 25,),
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

                  },
                  child: Row(
                    children: [
                      SizedBox(width: 25,),
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

                  },
                  child: Row(
                    children: [
                      SizedBox(width: 25,),
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
                      SizedBox(width: 25,),
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
