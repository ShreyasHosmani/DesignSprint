import 'package:design_sprint/APIs/get_pain_points.dart';
import 'package:design_sprint/APIs/vote_pain_point.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_team.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/IdentifyPainPoints/identify_painpoint_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/IdentifyPainPoints/select_final_painpoints.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:progress_dialog/progress_dialog.dart';

bool statusDrawer = false;
double percentage = 0;
ProgressDialog prJpHorizontal;

class VotePageViewBuilder extends StatefulWidget {
  @override
  _VotePageViewBuilderState createState() => _VotePageViewBuilderState();
}

class _VotePageViewBuilderState extends State<VotePageViewBuilder> {
  GetPainPointsApiProvider getPainPointsApiProvider =
      GetPainPointsApiProvider();

  Future<String> getPainPoints(context) async {
    print(home.selectedSprintId);
    String url = globals.urlSignUp + "getpainpoint.php";

    http.post(url, body: {
      //"userID" : "37",//profile.userID,
      "sprintID": home.sprintID == null || home.sprintID == "null"
          ? home.selectedSprintId
          : home.sprintID,
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayGetPainPoints = jsonDecode(response.body);
      print(empathize.responseArrayGetPainPoints);

      empathize.responseArrayGetPainPointsMsg =
          empathize.responseArrayGetPainPoints['message'].toString();
      print(empathize.responseArrayGetPainPointsMsg);
      if (statusCode == 200) {
        if (empathize.responseArrayGetPainPointsMsg == "Painpoint Data Found") {
          setState(() {
            empathize.painPointsList = List.generate(
                empathize.responseArrayGetPainPoints['data'].length,
                (index) => empathize.responseArrayGetPainPoints['data'][index]
                        ['ppName']
                    .toString());
            empathize.painPointIdsList = List.generate(
                empathize.responseArrayGetPainPoints['data'].length,
                (index) => empathize.responseArrayGetPainPoints['data'][index]
                        ['ppID']
                    .toString());
            //percentage = (int.parse(empathize.painPointIdsList[empathize.pageIndex]) / int.parse(empathize.painPointsList.length)).toDouble();
          });
          print(empathize.painPointsList.toList());
          print(empathize.painPointIdsList.toList());
          print((empathize.pageIndex + 1) / empathize.painPointsList.length);
        } else {
          setState(() {
            empathize.painPointsList = "1";
          });
        }
      }
    });
  }

  final controller = PageController(viewportFraction: 1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    empathize.pageIndex = 0;
    percentage = 0;
    print(empathize.pageIndex);
    empathize.painPointsList = null;
    getPainPoints(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: empathize.painPointsList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : empathize.painPointsList == "1"
              ? Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning,
                        size: 100,
                        color: Color(0xff787cd1),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "You have not uploaded any pain points, please go back and upload the pain points!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Center(
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: BoxDecoration(
                                color: Color(0xff7579cb),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            child: Center(
                              child: Text(
                                "Okay",
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : PageView.builder(
                  physics: new NeverScrollableScrollPhysics(),
                  itemCount: empathize.painPointsList == null
                      ? 0
                      : empathize.painPointsList.length,
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      empathize.pageIndex = index;
                    });
                    print(empathize.pageIndex);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return VotePainPoints(controller);
                  },
                ),
    );
  }
}

class VotePainPoints extends StatefulWidget {
  final controller;

  VotePainPoints(this.controller) : super();

  @override
  _VotePainPointsState createState() => _VotePainPointsState();
}

class _VotePainPointsState extends State<VotePainPoints> {
  VotePainPointsApiProvider votePainPointsApiProvider =
      VotePainPointsApiProvider();

  Future<String> updateStep4(context) async {
    String url = globals.urlSignUp + "updatesprintstatus.php";

    http.post(url, body: {
      "userID": profile.userID,
      "sprintID": home.sprintID == null || home.sprintID == "null"
          ? home.selectedSprintId
          : home.sprintID,
      "stepID": "4",
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayUpdateStatus = jsonDecode(response.body);
      print(responseArrayUpdateStatus);

      var responseArrayUpdateStatusMsg =
          responseArrayUpdateStatus['message'].toString();
      print(responseArrayUpdateStatusMsg);
      if (statusCode == 200) {
        if (responseArrayUpdateStatusMsg == "Timeline updated Successfully") {
          print("Status updated!!");
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => SelectFinalPainPoints(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        } else {}
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    empathize.selectedPainPointId =
        empathize.painPointIdsList[empathize.pageIndex];
    containerColorList = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    prJpHorizontal = ProgressDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer:
          statusDrawer == true ? StatusDrawerTeam() : ProfileDrawerCommon(),
      body: Stack(
        children: [
          WillPopScope(
            onWillPop: () => Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => IdentifyPainPointTutorial(),
                transitionsBuilder: (c, anim, a2, child) =>
                    FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildName3Widget(context),
                SizedBox(
                  height: 20,
                ),
                buildLevelContainer(context),
                SizedBox(
                  height: 46,
                ),
                buildPainPointNumberIndicator(context),
                SizedBox(
                  height: 46,
                ),
                buildName4Widget(context),
                SizedBox(
                  height: 74,
                ),
                buildName5Widget(context),
                SizedBox(
                  height: 25,
                ),
                buildVoteRow(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: buildName2Widget(context),
          ),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    Container line =
        Container(height: 1, color: Colors.black, child: Divider());
    void _openEndDrawer() {
      setState(() {
        statusDrawer = false;
      });
      _scaffoldKey.currentState.openEndDrawer();
    }

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Text(
          empathize.empathize,
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
          onPressed: () {
            widget.controller.animateToPage(empathize.pageIndex - 1,
                duration: Duration(seconds: 1), curve: Curves.easeIn);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.grey.shade700,
          ),
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
                  SizedBox(
                    height: 6,
                  ),
                  line,
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                      height: 1,
                      width: 20,
                      color: Colors.black,
                      child: Divider()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProfileDrawer(BuildContext context) {
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, " + profile.name + "!",
                            style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            profile.email,
                            style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 42,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 62,
                    ),
                    Icon(
                      Icons.image,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      home.sideBarHeadingHome,
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 42,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 62,
                    ),
                    Icon(
                      Icons.image,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      home.sideBarHeadingDesignSprint,
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 42,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 62,
                    ),
                    Icon(
                      Icons.image,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      home.sideBarHeadingTips,
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 42,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 62,
                    ),
                    Icon(
                      Icons.image,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      home.sideBarHeadingManageTeam,
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 42,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 62,
                    ),
                    Icon(
                      Icons.image,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      home.sideBarHeadingFAQs,
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 42,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 62,
                    ),
                    Icon(
                      Icons.image,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      home.sideBarHeadingLegalPolicy,
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 42,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget statusBarDrawer(BuildContext context) {
    void _openEndDrawer() {
      setState(() {
        statusDrawer = true;
      });
      _scaffoldKey.currentState.openEndDrawer();
    }

    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: _openEndDrawer,
        child: Container(
          height: 37,
          width: 37,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )),
          child: Center(
              child: Text(
            "<<",
            style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(color: Color(0xff787CD1), fontSize: 18)),
          )),
        ),
      ),
    );
  }

  Widget buildStatusDrawer(BuildContext context) {
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
                  height: 70,
                  color: Color(0xff787CD1),
                  child: Center(
                    child: Text(
                      "Sprint Name",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 42,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 62,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Sprint Goal",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 42,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 62,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Colors.grey)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Empathize",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 42,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 62,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Colors.grey)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Ideation",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 42,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 62,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Colors.grey)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Prototype",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 42,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 62,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Colors.grey)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "User Testing",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 42,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 62,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Colors.grey)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Re - Iterate",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 42,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 62,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Colors.grey)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Team",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildName2Widget(BuildContext context) {
    return Center(
      child: Text(
        empathize.identifyPainPoints,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                color: Color(0xff707070),
                fontSize: 20,
                fontWeight: FontWeight.w200)),
      ),
    );
  }

  Widget buildName3Widget(BuildContext context) {
    return Center(
      child: Text(
        empathize.voteHint1 + "\n" + empathize.voteHint2 + ".",
        textAlign: TextAlign.center,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget buildLevelContainer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width / 5,
          left: MediaQuery.of(context).size.width / 5),
      child: Center(
        child: LinearPercentIndicator(
          lineHeight: 10,
          percent: (empathize.pageIndex + 1) / empathize.painPointsList.length,
          backgroundColor: Colors.grey.shade300,
          progressColor: Color(0xff787CD1),
        ),
      ),
    );
  }

  Widget buildPainPointNumberIndicator(BuildContext context) {
    return Center(
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
            color: Color(0xff787CD1),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Center(
          child: Text(
            (empathize.pageIndex + 1).toString(),
            style: GoogleFonts.nunitoSans(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget buildName4Widget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 36),
      child: Center(
        child: Text(
          empathize.painPointsList[empathize.pageIndex],
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildName5Widget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 36),
      child: Center(
        child: Text(
          empathize.voteHint2,
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildVoteRow(BuildContext context) {
    Container colorContainer = Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Color(0xff787CD1),
      ),
    );

    return Center(
      child: Container(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("1"),
            SizedBox(
              width: 10,
            ),
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, i) => Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        empathize.selectedIndex = i.toString();
                        var voteRangeTemp = (i + 1).toString();
                        empathize.voteRange = voteRangeTemp.toString();
                        empathize.selectedPainPointId =
                            empathize.painPointIdsList[empathize.pageIndex];
                      });
                      print(empathize.selectedIndex);
                      print(empathize.voteRange);
                      print(empathize.selectedPainPointId);
                      setColorState(context, empathize.selectedIndex);

                      votePainPointsApiProvider
                          .votePainPoints(context)
                          .then((value) {
                        if (empathize.painPointIdsList.last ==
                            empathize.selectedPainPointId) {
                          print(
                              "Last index reached, You are a great man ever!");
                          updateStep4(context);
                        } else {
                          print("You are a loser bro, try again!");
                          widget.controller.nextPage(
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn);
                        }
                      });
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: Color(0xff787CD1)),
                        color: containerColorList[i],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text("10"),
          ],
        ),
      ),
    );
  }

  /* Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (empathize.painPointIdsList.last == empathize.selectedPainPointId) {
          print("Last index reached, You are a great man ever!");
          updateStep4(context);
        } else {
          print("You are a loser bro, try again!");
          widget.controller
              .nextPage(duration: Duration(seconds: 1), curve: Curves.easeIn);
        }
      },
      child: Center(
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 3.0,
          decoration: BoxDecoration(
              color: Color(0xff7579cb),
              borderRadius: BorderRadius.all(Radius.circular(7))),
          child: Center(
            child: Text(
              "Next",
              style: TextStyle(
                  color: Colors.white, letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
*/
  void setColorState(BuildContext context, selectedIndex) {
    if (selectedIndex == "0" || selectedIndex == 0) {
      setState(() {
        containerColorList[0] = Color(0xff787cd1);
        containerColorList[0] = Colors.white;
        containerColorList[1] = Colors.white;
        containerColorList[2] = Colors.white;
        containerColorList[3] = Colors.white;
        containerColorList[4] = Colors.white;
        containerColorList[5] = Colors.white;
        containerColorList[6] = Colors.white;
        containerColorList[7] = Colors.white;
        containerColorList[8] = Colors.white;
        containerColorList[9] = Colors.white;
      });
    } else if (selectedIndex == "1" || selectedIndex == 1) {
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Colors.white;
      containerColorList[3] = Colors.white;
      containerColorList[4] = Colors.white;
      containerColorList[5] = Colors.white;
      containerColorList[6] = Colors.white;
      containerColorList[7] = Colors.white;
      containerColorList[8] = Colors.white;
      containerColorList[9] = Colors.white;
    } else if (selectedIndex == "2" || selectedIndex == 2) {
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Colors.white;
      containerColorList[4] = Colors.white;
      containerColorList[5] = Colors.white;
      containerColorList[6] = Colors.white;
      containerColorList[7] = Colors.white;
      containerColorList[8] = Colors.white;
      containerColorList[9] = Colors.white;
    } else if (selectedIndex == "3" || selectedIndex == 3) {
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Color(0xff787cd1);
      containerColorList[4] = Colors.white;
      containerColorList[5] = Colors.white;
      containerColorList[6] = Colors.white;
      containerColorList[7] = Colors.white;
      containerColorList[8] = Colors.white;
      containerColorList[9] = Colors.white;
    } else if (selectedIndex == "4" || selectedIndex == 4) {
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Color(0xff787cd1);
      containerColorList[4] = Color(0xff787cd1);
      containerColorList[5] = Colors.white;
      containerColorList[6] = Colors.white;
      containerColorList[7] = Colors.white;
      containerColorList[8] = Colors.white;
      containerColorList[9] = Colors.white;
    } else if (selectedIndex == "5" || selectedIndex == 5) {
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Color(0xff787cd1);
      containerColorList[4] = Color(0xff787cd1);
      containerColorList[5] = Color(0xff787cd1);
      containerColorList[6] = Colors.white;
      containerColorList[7] = Colors.white;
      containerColorList[8] = Colors.white;
      containerColorList[9] = Colors.white;
    } else if (selectedIndex == "6" || selectedIndex == 6) {
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Color(0xff787cd1);
      containerColorList[4] = Color(0xff787cd1);
      containerColorList[5] = Color(0xff787cd1);
      containerColorList[6] = Color(0xff787cd1);
      containerColorList[7] = Colors.white;
      containerColorList[8] = Colors.white;
      containerColorList[9] = Colors.white;
    } else if (selectedIndex == "7" || selectedIndex == 7) {
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Color(0xff787cd1);
      containerColorList[4] = Color(0xff787cd1);
      containerColorList[5] = Color(0xff787cd1);
      containerColorList[6] = Color(0xff787cd1);
      containerColorList[7] = Color(0xff787cd1);
      containerColorList[8] = Colors.white;
      containerColorList[9] = Colors.white;
    } else if (selectedIndex == "8" || selectedIndex == 8) {
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Color(0xff787cd1);
      containerColorList[4] = Color(0xff787cd1);
      containerColorList[5] = Color(0xff787cd1);
      containerColorList[6] = Color(0xff787cd1);
      containerColorList[7] = Color(0xff787cd1);
      containerColorList[8] = Color(0xff787cd1);
      containerColorList[9] = Colors.white;
    } else if (selectedIndex == "9" || selectedIndex == 9) {
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Color(0xff787cd1);
      containerColorList[4] = Color(0xff787cd1);
      containerColorList[5] = Color(0xff787cd1);
      containerColorList[6] = Color(0xff787cd1);
      containerColorList[7] = Color(0xff787cd1);
      containerColorList[8] = Color(0xff787cd1);
      containerColorList[9] = Color(0xff787cd1);
    }
//    setState(() {
//      containerColorList[int.parse(selectedIndex)] = Color(0xff787cd1);
//    });
  }
}

var containerColorList = [
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
];
