import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/IdentifyPainPoints/identify_painpoint_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/IdentifyPainPoints/select_final_painpoints.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/JourneyMap/journey_mapping_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/Personas/persona_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Ideation/crazy_8_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Ideation/i_vs_f_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Ideation/idea_selection_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/create_team_sections_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/selection_message_screen_to_team_member.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/team_data_and_manage_team.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/tutorial_sprint_goal.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_empathize_inside_sections.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_ideation_inside_sections.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_prototypes.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_road_map_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_sprint_goal.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_team_by_sprints_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_user_testing_insights.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Prototyping/prototyping_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Re%20Iterate/road_map_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Re%20Iterate/road_map_screen_sprint_wise.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/User%20Testing/User%20Testing%20Screens/user_testing_inside_sections1.dart';
import 'package:flutter/material.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/comments_data.dart' as comments;
import 'package:shimmer/shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;

var dmIDd;
var dmEmailId;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
var status1;
var status2;
var status3;
var status4;
var status5;
var status6;
var status7;
var status8;
var status9;
var status10;
var status11;

class ShowInsideSections extends StatefulWidget {
  final sprintid;
  final decsionMakersId;
  ShowInsideSections(this.sprintid, this.decsionMakersId) : super();
  @override
  _ShowInsideSectionsState createState() => _ShowInsideSectionsState();
}

class _ShowInsideSectionsState extends State<ShowInsideSections> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: ProfileDrawerCommon(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            buildName2Widget(context),
            SizedBox(height: 25,),
            buildSprintGoalCard(context),
            SizedBox(height: 21,),
            buildEmpathizeCard(context),
            SizedBox(height: 21,),
            buildIdeationCard(context),
            SizedBox(height: 21,),
            buildPrototypeCard(context),
            SizedBox(height: 21,),
            buildUserTestingCard(context),
            SizedBox(height: 21,),
            buildReIterateCard(context),
            SizedBox(height: 21,),
            buildTeamCard(context),
            SizedBox(height: 40,),
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
      title: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Text(home.designSprint,
          style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 15, top: 0),
        child: IconButton(
          onPressed: (){Navigator.of(context).pop();},
          icon: Icon(Icons.arrow_back_ios,size: 20, color: Colors.grey.shade700,),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 25, top: 18),
          child: InkWell(
            onTap: _openEndDrawer,
            child: Container(
              height: 50,
              width: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  line,
                  SizedBox(height: 6,),
                  line,
                  SizedBox(height: 6,),
                  Container(height:1,width:20, color: Colors.black,child: Divider()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildName2Widget(BuildContext context){

    return Center(
      child: Text(home.home,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                color: Color(0xff707070),
                fontSize: 20,
                fontWeight: FontWeight.w200
            )
        ),
      ),
    );
  }

  Widget buildProfileDrawer(BuildContext context){
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
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff302B70),
                        Color(0xff787CD1),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Icon(Icons.person, color: Colors.grey, size: 40,),
                      ),
                      SizedBox(width: 15,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hi, " + profile.name + "!",
                            style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                )
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(profile.email,
                            style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                )
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Icon(Icons.image, color: Colors.grey.shade500,),
                    SizedBox(width: 10,),
                    Text(home.sideBarHeadingHome,
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
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Icon(Icons.image, color: Colors.grey.shade500,),
                    SizedBox(width: 10,),
                    Text(home.sideBarHeadingDesignSprint,
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
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Icon(Icons.image, color: Colors.grey.shade500,),
                    SizedBox(width: 10,),
                    Text(home.sideBarHeadingTips,
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
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Icon(Icons.image, color: Colors.grey.shade500,),
                    SizedBox(width: 10,),
                    Text(home.sideBarHeadingManageTeam,
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
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Icon(Icons.image, color: Colors.grey.shade500,),
                    SizedBox(width: 10,),
                    Text(home.sideBarHeadingFAQs,
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
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Icon(Icons.image, color: Colors.grey.shade500,),
                    SizedBox(width: 10,),
                    Text(home.sideBarHeadingLegalPolicy,
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
                SizedBox(height: 42,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSprintGoalCard(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => ViewSprintGoal(widget.sprintid, widget.decsionMakersId),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        width: 302,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xffF1A042),
        ),
        child: Stack(
          children: [
            Container(
                width: 302,
                child: Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,)),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: Text("Sprint Goal",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, bottom: 30),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_forward, color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmpathizeCard(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => ViewEmpathizeInsideSections(widget.sprintid, widget.decsionMakersId),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        width: 302,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xff96C3CB),
        ),
        child: Stack(
          children: [
            Container(
                width: 302,
                child: Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,)),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: Text("Empathize",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, bottom: 30),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_forward, color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIdeationCard(BuildContext context){
    return GestureDetector(
      onTap: (){
        if(status2 == "0"){
          Fluttertoast.showToast(msg: 'Please complete Empathize section to proceed with Ideation',
            backgroundColor: Colors.black, textColor: Colors.white,
          );
        }else if(status4 == "1"){
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => ViewIdeationInsideSections(widget.sprintid, widget.decsionMakersId),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        }else{
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => IdentifyPainPointTutorial(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        }
      },
      child: Container(
        width: 302,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xff787cd1),
        ),
        child: Stack(
          children: [
            Container(
                width: 302,
                child: Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,)),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: Text("Ideation",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, bottom: 30),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_forward, color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPrototypeCard(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => ViewPrototypes(widget.sprintid),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        width: 302,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xffFFB8B8),
        ),
        child: Stack(
          children: [
            Container(
                width: 302,
                child: Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,)),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: Text("Prototype",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, bottom: 30),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_forward, color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserTestingCard(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => ViewUserTestingInsights(widget.sprintid),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        width: 302,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xff302B70),
        ),
        child: Stack(
          children: [
            Container(
                width: 302,
                child: Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,)),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: Text("User Testing",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, bottom: 30),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_forward, color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReIterateCard(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => RoadMapSprintWise(widget.sprintid),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        width: 302,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xff707070),
        ),
        child: Stack(
          children: [
            Container(
                width: 302,
                child: Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,)),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: Text("Re - Iterate",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, bottom: 30),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_forward, color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTeamCard(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => ViewTeamBySprints(widget.sprintid),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        width: 302,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xff00C24E),
        ),
        child: Stack(
          children: [
            Container(
                width: 302,
                child: Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,)),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: Text("Team",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, bottom: 30),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_forward, color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ViewSprintInsideSections extends StatefulWidget {
  final sprintid;
  final decsionMakersId;
  final dmEmail;
  ViewSprintInsideSections(this.sprintid, this.decsionMakersId, this.dmEmail) : super();
  @override
  _ViewSprintInsideSectionsState createState() => _ViewSprintInsideSectionsState();
}

class _ViewSprintInsideSectionsState extends State<ViewSprintInsideSections> {

  Future<String> getSprintsStatuses(context) async {

    String url = globals.urlLogin + "getsprintstatus.php";

    http.post(url, body: {

      //"userID" : profile.userID,
      "userEmail" : profile.email.toString(),
      "sprintID" : widget.sprintid.toString(),

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
            status1 = responseArrayGetSprintStatuses['data']['sprintstatusStep1'].toString();
            status2 = responseArrayGetSprintStatuses['data']['sprintstatusStep2'].toString();
            status3 = responseArrayGetSprintStatuses['data']['sprintstatusStep3'].toString();
            status4 = responseArrayGetSprintStatuses['data']['sprintstatusStep4'].toString();
            status5 = responseArrayGetSprintStatuses['data']['sprintstatusStep5'].toString();
            status6 = responseArrayGetSprintStatuses['data']['sprintstatusStep6'].toString();
            status7 = responseArrayGetSprintStatuses['data']['sprintstatusStep7'].toString();
            status8 = responseArrayGetSprintStatuses['data']['sprintstatusStep8'].toString();
            status9 = responseArrayGetSprintStatuses['data']['sprintstatusStep9'].toString();
            status10 = responseArrayGetSprintStatuses['data']['sprintstatusStep10'].toString();
            status11 = responseArrayGetSprintStatuses['data']['sprintstatusStep11'].toString();
          });

          print(status1);
          print(status2);
          print(status3);
          print(status4);
          print(status5);
          print(status6);
          print(status7);
          print(status8);
          print(status9);
          print(status10);
          print(status11);

          if(dmIDd == profile.userID){
            print("I am a decision maker...");
            if(status1 == "0" && status2 == "0" && status3 == "0" && status4 == "0" && status5 == "0" && status6 == "0"
                && status7 == "0" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              print("Start freshly...");
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => SprintGoalTutorial(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "0" && status3 == "0" && status4 == "0" && status5 == "0" && status6 == "0"
                && status7 == "0" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              print("Goal has been uploaded...");
              Fluttertoast.showToast(msg: 'If team already selected, then ignore!',backgroundColor: Colors.black, textColor: Colors.white);
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => CreateTeamSections(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "0" && status4 == "0" && status5 == "0" && status6 == "0"
                && status7 == "0" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              print("Goal & Personas have been uploaded...");
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => JourneyMappingTutorial(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "0" && status5 == "0" && status6 == "0"
                && status7 == "0" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              print("Goal & Personas & JourneyMaps have been uploaded...");
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => IdentifyPainPointTutorial(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "1" && status5 == "0" && status6 == "0"
                && status7 == "0" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => SelectFinalPainPoints(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "1" && status5 == "1" && status6 == "0"
                && status7 == "0" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => Crazy8Tutorial(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "1" && status5 == "1" && status6 == "1"
                && status7 == "0" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => IvsFTutorial(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "1" && status5 == "1" && status6 == "1"
                && status7 == "1" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => IdeaSelection(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "1" && status5 == "1" && status6 == "1"
                && status7 == "1" && status8 == "1" && status9 == "0" && status10 == "0" && status11 == "0"){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => PrototypingTutorial(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "1" && status5 == "1" && status6 == "1"
                && status7 == "1" && status8 == "1" && status9 == "1" && status10 == "0" && status11 == "0"){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => UserTestingInsideSections1(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "1" && status5 == "1" && status6 == "1"
                && status7 == "1" && status8 == "1" && status9 == "1" && status10 == "1" && status11 == "0"){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => ShowInsideSections(widget.sprintid, widget.decsionMakersId),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else{
              //print("Calculations are wrong...");
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => ShowInsideSections(widget.sprintid, widget.decsionMakersId),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }
          }else{
            print("I am not a decision maker...");
            if(status1 == "0" && status2 == "0" && status3 == "0" && status4 == "0" && status5 == "0" && status6 == "0"
                && status7 == "0" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              print("Start freshly...");
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => ViewSprintGoal(widget.sprintid, widget.decsionMakersId),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "0" && status3 == "0" && status4 == "0" && status5 == "0" && status6 == "0"
                && status7 == "0" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              print("Goal has been uploaded...");
              //Fluttertoast.showToast(msg: 'If team already selected, then ignore!',backgroundColor: Colors.black, textColor: Colors.white);
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => PersonaTutorial(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "0" && status4 == "0" && status5 == "0" && status6 == "0"
                && status7 == "0" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              print("Goal & Personas have been uploaded...");
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => JourneyMappingTutorial(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "0" && status5 == "0" && status6 == "0"
                && status7 == "0" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              print("Goal & Personas & JourneyMaps have been uploaded...");
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => IdentifyPainPointTutorial(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "1" && status5 == "0" && status6 == "0"
                && status7 == "0" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => ShowSelectionMessage(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "1" && status5 == "1" && status6 == "0"
                && status7 == "0" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => Crazy8Tutorial(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "1" && status5 == "1" && status6 == "1"
                && status7 == "0" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => IvsFTutorial(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "1" && status5 == "1" && status6 == "1"
                && status7 == "1" && status8 == "0" && status9 == "0" && status10 == "0" && status11 == "0"){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => ShowSelectionMessage(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "1" && status5 == "1" && status6 == "1"
                && status7 == "1" && status8 == "1" && status9 == "0" && status10 == "0" && status11 == "0"){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => PrototypingTutorial(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "1" && status5 == "1" && status6 == "1"
                && status7 == "1" && status8 == "1" && status9 == "1" && status10 == "0" && status11 == "0"){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => UserTestingInsideSections1(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else if(status1 == "1" && status2 == "1" && status3 == "1" && status4 == "1" && status5 == "1" && status6 == "1"
                && status7 == "1" && status8 == "1" && status9 == "1" && status10 == "1" && status11 == "0"){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => ShowInsideSections(widget.sprintid, widget.decsionMakersId),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else{
              //print("Calculations are wrong...");
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => ShowInsideSections(widget.sprintid, widget.decsionMakersId),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }
          }

        }else{

          setState(() {

          });

        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSprintsStatuses(context);
    setState(() {
      status1 = null;
      status2 = null;
      status3 = null;
      status4 = null;
      status5 = null;
      status6 = null;
      status7 = null;
      status8 = null;
      status9 = null;
      status10 = null;
      status11 = null;
      home.selectedSprintId = widget.sprintid.toString();
      dmIDd = widget.decsionMakersId.toString();
      dmEmailId = widget.dmEmail.toString();
      comments.responseArrayAddComments1 = null;
      comments.responseArrayAddComments1Msg = null;

      comments.responseArrayGetComments1 = null;
      comments.responseArrayGetComments1Msg = null;

      comments.commentsPaperPersonaList = null;
      comments.commentsUserNamePaperPersonaList = null;
      comments.commentsProfilePicPaperPersonaList = null;

      comments.responseArrayAddComments0 = null;
      comments.responseArrayAddComments0Msg = null;

      comments.responseArrayGetComments0 = null;
      comments.responseArrayGetComments0Msg = null;

      comments.commentsDigitalPersonaList = null;
      comments.commentsUserNameDigitalPersonaList = null;
      comments.commentsProfilePicDigitlPersonaList = null;

      comments.responseArrayAddComments2 = null;
      comments.responseArrayAddComments2Msg = null;

      comments.responseArrayGetComments2 = null;
      comments.responseArrayGetComments2Msg = null;

      comments.commentsDigitalMapList = null;
      comments.commentsUserNameDigitalMapList = null;
      comments.commentsProfilePicDigitalMapList = null;

      comments.responseArrayAddComments3 = null;
      comments.responseArrayAddComments3Msg = null;

      comments.responseArrayGetComments3 = null;
      comments.responseArrayGetComments3Msg = null;

      comments.commentsPaperMapList = null;
      comments.commentsUserNamePaperMapList = null;
      comments.commentsProfilePicPaperMapList = null;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

}
