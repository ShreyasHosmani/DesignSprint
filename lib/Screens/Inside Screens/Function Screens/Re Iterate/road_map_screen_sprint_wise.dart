import 'dart:convert';

import 'package:design_sprint/APIs/reiterate_calls.dart';
import 'package:design_sprint/Helpers/helper.dart';
import 'package:design_sprint/Models/TaskListParser.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_user_testing.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Re%20Iterate/congratulations_screenSolo.dart';
import 'package:design_sprint/utils/reiterate_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/reiterate_data.dart' as reiterate;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:http/http.dart' as http;

bool statusDrawer = false;

class RoadMapSprintWise extends StatefulWidget {
  final sprintid;

  RoadMapSprintWise(this.sprintid) : super();

  @override
  _RoadMapSprintWiseState createState() => _RoadMapSprintWiseState();
}

class _RoadMapSprintWiseState extends State<RoadMapSprintWise> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ReIterateApiProvider reIterateApiProvider = ReIterateApiProvider();

  Future<String> getRoadMapDataNotes2(context) async {
    String url = globals.urlSignUp + "getprototypenotebysprint.php";

    http.post(url, body: {
      "sprintID": (home.sprintID == null || home.sprintID == "null"
              ? home.selectedSprintId
              : home.sprintID)
          .toString(),
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      setState(() {
        reiterate.responseArrayGetRoadNotesMap = jsonDecode(response.body);
        print(reiterate.responseArrayGetRoadNotesMap.toString());

        reiterate.responseArrayGetRoadMapNotesMsg =
            reiterate.responseArrayGetRoadNotesMap['message'].toString();
        if (reiterate.responseArrayGetRoadMapNotesMsg == "Data Found") {
          reiterate.allPrototypeNotes = List.generate(
              reiterate.responseArrayGetRoadNotesMap['images'].length,
              (i) => reiterate.responseArrayGetRoadNotesMap['images'][i]
                  ['ptnNotetext']);

          reiterate.allPrototypeId = List.generate(
              reiterate.responseArrayGetRoadNotesMap['images'].length,
              (i) => reiterate.responseArrayGetRoadNotesMap['images'][i]
                  ['ptnPrototypeid']);

          print(reiterate.allPrototypeNotes.toList());
          getRoadMapDataTasksAndTimeLines2(context);
        } else {
          reiterate.allPrototypeNotes = null;
          reiterate.allPrototypeId = null;
        }
      });
    });
  }

  Future<String> getRoadMapDataTasksAndTimeLines2(context) async {
    taskList.clear();

    print(home.selectedSprintId);
    String url = globals.urlSignUp + "getprototypetaskbysprint.php";

    http.post(url, body: {
      "sprintID": (home.sprintID == null || home.sprintID == "null"
              ? home.selectedSprintId
              : home.sprintID)
          .toString(),
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      setState(() {
        reiterate.responseArrayGetRoadTasksMap = jsonDecode(response.body);
        print(reiterate.responseArrayGetRoadTasksMap.toString());

        reiterate.responseArrayGetRoadTasksMsg =
            reiterate.responseArrayGetRoadTasksMap['message'].toString();

        if (reiterate.responseArrayGetRoadTasksMsg == "Data Found") {
          var data = reiterate.responseArrayGetRoadTasksMap['images'];
          if (data != null) {
            for (Map i in data) {
              taskList.add(TaskListParser.fromJson(i));
            }
          }

          reiterate.allPrototypeTasks = List.generate(
              reiterate.responseArrayGetRoadTasksMap['images'].length,
              (i) => reiterate.responseArrayGetRoadTasksMap['images'][i]
                  ['pptTasktext']);
          reiterate.allPrototypeDueDates = List.generate(
              reiterate.responseArrayGetRoadTasksMap['images'].length,
              (i) => reiterate.responseArrayGetRoadTasksMap['images'][i]
                  ['pptDuedate']);

          print(reiterate.allPrototypeTasks.toList());
          print(reiterate.allPrototypeDueDates.toList());
          getRoadMapPrototypeOfStatusTwo(context);
        } else {
          reiterate.allPrototypeTasks = null;
        }
      });
    });
  }

  Future<String> getRoadMapPrototypeOfStatusTwo(context) async {
    String url = globals.urlSignUp + "getprototypebystatus.php";

    http.post(url, body: {
      "sprintID": (home.sprintID == null || home.sprintID == "null"
              ? home.selectedSprintId
              : home.sprintID)
          .toString(),
      "status": "2",
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      setState(() {
        reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo2 =
            jsonDecode(response.body);
        print(reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo2);

        reiterate.responseArrayGetAllPrototypeImagesOfStatusTwoMsg2 = reiterate
            .responseArrayGetAllPrototypeImagesOfStatusTwo2['message']
            .toString();
        print(reiterate.responseArrayGetAllPrototypeImagesOfStatusTwoMsg2);

        if (reiterate.responseArrayGetAllPrototypeImagesOfStatusTwoMsg2 ==
            "Data Found") {
          reiterate.prototypeAllImagesListOfStatusTwo2 = List.generate(
              reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo2['data']
                  .length,
              (i) => reiterate
                  .responseArrayGetAllPrototypeImagesOfStatusTwo2['data'][i]
                      ['ptiImgpath']
                  .toString());
          reiterate.prototypeAllImagesIdsListOfStatusTwo2 = List.generate(
              reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo2['data']
                  .length,
              (i) => reiterate
                  .responseArrayGetAllPrototypeImagesOfStatusTwo2['data'][i]
                      ['ptiID']
                  .toString());

          print(reiterate.prototypeAllImagesListOfStatusTwo2.toList());
          print(reiterate.prototypeAllImagesIdsListOfStatusTwo2.toList());
        } else {
          reiterate.prototypeAllImagesListOfStatusTwo2 = null;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      home.selectedSprintId = widget.sprintid;
      reiterate.allPrototypeNotes = null;
      reiterate.allPrototypeTasks = null;
      reiterate.allPrototypeDueDates = null;
    });
    getRoadMapDataNotes2(context);
    /* reIterateApiProvider.getRoadMapDataNotes2(context).whenComplete(() {
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {


          reIterateApiProvider
              .getRoadMapDataTasksAndTimeLines2(context)
              .whenComplete(() {
            reIterateApiProvider.getRoadMapPrototypeOfStatusTwo(context);
            Future.delayed(const Duration(seconds: 3), () {
              setState(() {});
            });
          });


        });
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Container(
            height: 60,
            child: buildNextButton(context)),
      ),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: statusDrawer == true
          ? StatusDrawerUserTesting()
          : ProfileDrawerCommon(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            buildName2Widget(context),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 47,
                ),
                buildSeperaterListView(context),
                SizedBox(
                  width: 47,
                ),
                buildRoadMapListViewBuilder(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).popUntil((route) => route.isFirst);
        push(context, CongratulationsSolor());
      },
      child: Center(
        child: Container(
          height: 50,
          width: MediaQuery
              .of(context)
              .size
              .width / 3.0,
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
          reiterate.title,
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
            Navigator.of(context).pop();
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
      alignment: Alignment.centerRight,
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
        reiterate.roadMap,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                color: Color(0xff707070),
                fontSize: 20,
                fontWeight: FontWeight.w200)),
      ),
    );
  }

  Widget buildRoadMapListViewBuilder(BuildContext context) {
    return reiterate.allPrototypeNotes == null ||
            reiterate.allPrototypeDueDates == null ||
            reiterate.prototypeAllImagesListOfStatusTwo2 == null
        ? Container()
        : Container(
            width: 250,
            child: ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: reiterate.allPrototypeNotes == null
                  ? 0
                  : reiterate.allPrototypeNotes.length,
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Center(
                  child: Container(
                    //height: 574,
                    width: 248,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      border: Border.all(color: Color(0xffF2F2F2)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 130,
                              width: 248,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  topRight: Radius.circular(7),
                                  bottomRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(globals.urlSignUp +
                                      reiterate
                                          .prototypeAllImagesListOfStatusTwo2[i]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: Color(0xff787cd1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      (i + 1).toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 27,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Note:",
                                style: GoogleFonts.nunitoSans(
                                  color: Color(0xff787cd1),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                reiterate.allPrototypeNotes[i],
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade200),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30,
                                          right: 30,
                                          top: 10,
                                          bottom: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Task:",
                                            style: GoogleFonts.nunitoSans(
                                                textStyle: TextStyle(
                                              color: Color(0xff787cd1),
                                              fontSize: 14,
                                            )),
                                          ),
                                          SizedBox(height: 10),
                                          reiterate.taskList.length == 0
                                              ? Container()
                                              : ListView.builder(
                                                  physics: ScrollPhysics(),
                                                  //controller: controller,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      reiterate.taskList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return reiterate.allPrototypeId[
                                                                i] !=
                                                            reiterate
                                                                .taskList[index]
                                                                .pptPrototypeid
                                                        ? Container()
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                reiterate
                                                                        .taskList[
                                                                            index]
                                                                        .pptTasktext ??
                                                                    "",
                                                                style: GoogleFonts
                                                                    .nunitoSans(
                                                                  textStyle:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  /* Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .perm_identity,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 12,
                                                                ),
                                                                SizedBox(
                                                                  width: 6,
                                                                ),
                                                                Text(
                                                                  "member name",
                                                                  style: GoogleFonts
                                                                      .nunitoSans(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),*/
                                                                  SizedBox(
                                                                    width: 30,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .date_range,
                                                                        color: Colors
                                                                            .grey,
                                                                        size:
                                                                            12,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            6,
                                                                      ),
                                                                      Text(
                                                                        reiterate.taskList[index].pptDuedate ??
                                                                            "",
                                                                        style: GoogleFonts
                                                                            .nunitoSans(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              12,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          );
                                                  }),
                                        ],
                                      ),
                                    ),
                                  ),
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
            ),
          );
  }

  Widget buildSeperaterListView(BuildContext context) {
    return Container(
      width: 20,
      child: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: reiterate.allPrototypeNotes == null
            ? 0
            : reiterate.allPrototypeNotes.length,
        itemBuilder: (context, i) => Column(
          children: [
            buildFilledContainer(context),
            buildFilledContainerSeperater(context),
          ],
        ),
      ),
    );
  }

  Widget buildNonFilledContainer(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(50))),
    );
  }

  Widget buildFilledContainer(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff787CD1),
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(50))),
    );
  }

  Widget buildContainerSeperater(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 13,
      width: 1,
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
    );
  }

  Widget buildFilledContainerSeperater(BuildContext context) {
    return Container(
      height: 350,
      width: 2,
      decoration: BoxDecoration(
        color: Color(0xff787cd1),
      ),
    );
  }
}
