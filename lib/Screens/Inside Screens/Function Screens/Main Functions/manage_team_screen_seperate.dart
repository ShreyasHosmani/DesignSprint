import 'package:design_sprint/APIs/create_add_team.dart';
import 'package:design_sprint/Helpers/helper.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_sprint_goal.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/design_sprint_sections_screen.dart';
import 'package:design_sprint/View%20Models/CustomViewModel.dart';
import 'package:design_sprint/main.dart';
import 'package:design_sprint/utils/main_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/team_data.dart' as team;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/hint_texts.dart' as hint;
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:convert';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

bool statusDrawer = false;

var memberNameControllerEdit = new TextEditingController();
var memberEmailControllerEdit = new TextEditingController();

var selectedTeam;
ProgressDialog prSelect;
var teamNmIdsList;
var selectedTeamNameId;

class ManageTeamSeperate extends StatefulWidget {
  final index;
  final teamid;
  final teamName;

  ManageTeamSeperate(this.index, this.teamid, this.teamName) : super();

  @override
  _ManageTeamSeperateState createState() => _ManageTeamSeperateState();
}

class _ManageTeamSeperateState extends State<ManageTeamSeperate> {
  bool _isloaded = false;

  Future<String> storeCollabData(context) async {

    String url = globals.urlSignUp + "addstore.php";


    print({

      "storeSprintType" : "Collab",
      "storeSprintId" : home.sprintID.toString(),
      "storeUserId" : profile.userID.toString(),
      "storeteamID" : selectedTeam.toString(),

    });

    http.post(url, body: {

      "storeSprintType" : "Collab",
      "storeSprintId" : home.sprintID.toString(),
      "storeUserId" : profile.userID.toString(),
      "storeteamID" : selectedTeam.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayStore = jsonDecode(response.body);
      print(responseArrayStore);

      var msg = responseArrayStore['message'].toString();
      print(msg);

      if(msg == "successfully"){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => EmphatizeSections(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      }else{
        Fluttertoast.showToast(msg: "error selecting team", backgroundColor: Colors.black,
          textColor: Colors.white,);
      }

    });
  }

  Future<String> selectTeam(context) async {

    String url = globals.urlSignUp + "selectteam.php";

    http.post(url, body: {

      "teamID" : selectedTeam.toString(),
      "sprintID" : home.sprintID.toString(),
      "callerID" : profile.userID.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayDeleteTeam = jsonDecode(response.body);
      print(responseArrayDeleteTeam);

      var msg = responseArrayDeleteTeam['message'].toString();
      if(statusCode == 200){
        if(msg == "Edited Successfully"){
          team.prTeam.hide();
          storeCollabData(context);
          // Fluttertoast.showToast(msg: "removing...", backgroundColor: Colors.black,
          //   textColor: Colors.white,).whenComplete((){
          //   Navigator.push(
          //     context,
          //     PageRouteBuilder(
          //       pageBuilder: (c, a1, a2) => EmphatizeSections(),
          //       transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
          //       transitionDuration: Duration(milliseconds: 300),
          //     ),
          //   );
          // });
        }else{
          team.prTeam.hide();
          Fluttertoast.showToast(msg: "error selecting team", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }

    });
  }

  Future initTask() async {
    Provider.of<CustomViewModel>(context, listen: false)
        .getTeamMembersList(widget.teamid)
        .then((value) async {
      setState(() {
        _isloaded = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTask();
  }

  @override
  Widget build(BuildContext context) {
    team.prTeam = ProgressDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: team.scaffoldKey2,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: statusDrawer == true
          ? StatusDrawerSprintGoal()
          : ProfileDrawerCommon(),
      body: _isloaded == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      buildName2Widget(context),
                      SizedBox(
                        height: 20,
                      ),
                      buildName3Widget(context),
                      SizedBox(
                        height: 20,
                      ),
                      buildMemberCardWidget(context),
                      SizedBox(
                        height: 75,
                      ),
                      buildAddMemberWidget(context),
                      SizedBox(
                        height: 20,
                      ),
                      buildNextButton(context),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 7,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 40,
                        ),
                        child: statusBarDrawer(context),
                      ),
                    ),
                  ),
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
      team.scaffoldKey2.currentState.openEndDrawer();
    }

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Text(
          team.appBarTitle,
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
      team.scaffoldKey2.currentState.openEndDrawer();
    }

    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: _openEndDrawer,
        child: Container(
          height: 37,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 15,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
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
    final providerListener = Provider.of<CustomViewModel>(context);
    return Center(
      child: GestureDetector(
        onTap: (){
          initTask();
          print("providerListener.teamsList[widget.index].teamUserid ::: "+providerListener.teamsList[widget.index].teamUserid.toString());
        },
        child: Text(
          widget.teamName,
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                  color: Color(0xff707070),
                  fontSize: 20,
                  fontWeight: FontWeight.w200)),
        ),
      ),
    );
  }

  Widget buildName3Widget(BuildContext context) {
    return Center(
      child: Text(
        team.subTitleManageTeam2,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget buildMemberCardWidget(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return providerListener.membersList.length == 0
        ? Container()
        : Column(
            children: [
              ListView.builder(
                physics: ScrollPhysics(),
                //controller: controller,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: providerListener.membersList.length,
                itemBuilder: (context, i) {
                  return (providerListener.adminEmail ?? "") ==
                          (providerListener.membersList[i].teamMemberEmail ??
                              "")
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 30, right: 30),
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  width: 302,
                                  height: 57,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xff787cd1)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            providerListener.membersList[i]
                                                .teamMemberName.isEmpty ? "Sprint Master" : (providerListener.membersList[i]
                                                    .teamMemberName ??
                                                ""),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: 16,
                                              color: (providerListener
                                                              .adminEmail ??
                                                          "") ==
                                                      (providerListener
                                                              .membersList[i]
                                                              .teamMemberEmail ??
                                                          "")
                                                  ? Color(0xff787cd1)
                                                  : Colors.black,
                                              fontWeight: (providerListener
                                                              .adminEmail ??
                                                          "") ==
                                                      (providerListener
                                                              .membersList[i]
                                                              .teamMemberEmail ??
                                                          "")
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            (providerListener.membersList[i]
                                                    .teamMemberEmail ??
                                                ""),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container();
                },
              ),
              ListView.builder(
                physics: ScrollPhysics(),
                //controller: controller,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: providerListener.membersList.length,
                itemBuilder: (context, i) {
                  return (providerListener.adminEmail ?? "") ==
                      (providerListener.membersList[i].teamMemberEmail ??
                          "")?Container(): Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 302,
                          height: 57,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff787cd1)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    (providerListener
                                            .membersList[i].teamMemberName ??
                                        ""),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: 16,
                                      color:
                                          (providerListener.adminEmail ?? "") ==
                                                  (providerListener
                                                          .membersList[i]
                                                          .teamMemberEmail ??
                                                      "")
                                              ? Color(0xff787cd1)
                                              : Colors.black,
                                      fontWeight:
                                          (providerListener.adminEmail ?? "") ==
                                                  (providerListener
                                                          .membersList[i]
                                                          .teamMemberEmail ??
                                                      "")
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    (providerListener
                                            .membersList[i].teamMemberEmail ??
                                        ""),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      (profile.email ?? "") ==
                                  (providerListener
                                          .membersList[i].teamMemberEmail ??
                                      "")
                              ? Container()
                              : Padding(
                                  padding:
                                      const EdgeInsets.only(right: 20, top: 5),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: PopupMenuButton<String>(
                                      onSelected: (val) {
                                        if (val == "Make Sprint Master") {
                                          print("Make Sprint Master called");
                                          team.prTeam.show();

                                          Provider.of<CustomViewModel>(context,
                                                  listen: false)
                                              .changeDecisionMaker(
                                                  widget.teamid,
                                                  widget.teamName,
                                                  (providerListener
                                                          .membersList[i]
                                                          .teamMemberEmail ??
                                                      ""))
                                              .then((value) async {
                                            team.prTeam.hide();
                                            if (value == "success") {
                                            } else if (value == "error") {
                                              Fluttertoast.showToast(
                                                msg: "Please try gain!",
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                              );
                                            } else {
                                              Fluttertoast.showToast(
                                                msg: (value ?? ""),
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                              );
                                            }
                                          });
                                        } else if (val == "Delete Member") {
                                          print("Delete Member called");

                                          showAlertDialogDeleteTeam(
                                              context,
                                              i,
                                              (providerListener
                                                      .membersList[i].teamID ??
                                                  ""));
                                        } else if (val == "Edit Details") {
                                          print("Edit Details called");
                                          setState(() {
                                            memberNameControllerEdit.text =
                                                (providerListener.membersList[i]
                                                        .teamMemberName ??
                                                    "");
                                            memberEmailControllerEdit.text =
                                                (providerListener.membersList[i]
                                                        .teamMemberEmail ??
                                                    "");
                                          });
                                          showAlertDialogEditTeamMember(
                                              context,
                                              i,
                                              (providerListener
                                                      .membersList[i].teamID ??
                                                  ""));
                                        }
                                      },
                                      icon: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 3,
                                            width: 3,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            height: 3,
                                            width: 3,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            height: 3,
                                            width: 3,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))),
                                          ),
                                        ],
                                      ),
                                      color: Colors.white,
                                      itemBuilder: (BuildContext context) {
                                        return {
                                          'Delete Member',
                                          'Edit Details',
                                          'Make Sprint Master'
                                        }.map((String choice) {
                                          return PopupMenuItem<String>(
                                            value: choice,
                                            textStyle: GoogleFonts.nunitoSans(
                                              color: Colors.grey.shade700,
                                              fontSize: 16,
                                            ),
                                            child: Text(choice),
                                          );
                                        }).toList();
                                      },
                                    ),
                                  ),
                                ),
                    ],
                  ),
                );
                },
              ),
            ],
          );
  }

  Widget buildAddMemberWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          team.memberNameController.clear();
          team.memberEmailController.clear();
        });
        showAlertDialogAddTeamMember(context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Color(0xff787CD1),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Add Member",
            style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(
              color: Color(0xff787CD1),
              fontSize: 14,
            )),
          )
        ],
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return InkWell(
      onTap: (){
            print("select team called");
            setState(() {
              selectedTeamIdForDeleting = widget.teamid;
              selectedTeam = widget.teamid;
            });
            print("selectedTeam :::: "+selectedTeam.toString());
            print(selectedTeamIdForDeleting);
            print(selectedTeam);
            team.prTeam.show();
            Fluttertoast.showToast(msg: 'One moment,notifying your team...', backgroundColor: Colors.black, textColor: Colors.white, timeInSecForIosWeb: 5);
            Fluttertoast.showToast(msg: 'One moment,notifying your team...', backgroundColor: Colors.black, textColor: Colors.white, timeInSecForIosWeb: 5);
            Fluttertoast.showToast(msg: 'One moment,notifying your team...', backgroundColor: Colors.black, textColor: Colors.white, timeInSecForIosWeb: 5);
            Fluttertoast.showToast(msg: 'One moment,notifying your team...', backgroundColor: Colors.black, textColor: Colors.white, timeInSecForIosWeb: 5);
            Fluttertoast.showToast(msg: 'One moment,notifying your team...', backgroundColor: Colors.black, textColor: Colors.white, timeInSecForIosWeb: 5);
            Fluttertoast.showToast(msg: 'One moment,notifying your team...', backgroundColor: Colors.black, textColor: Colors.white, timeInSecForIosWeb: 5);
            Fluttertoast.showToast(msg: 'One moment,notifying your team...', backgroundColor: Colors.black, textColor: Colors.white, timeInSecForIosWeb: 5);
            Fluttertoast.showToast(msg: 'One moment,notifying your team...', backgroundColor: Colors.black, textColor: Colors.white, timeInSecForIosWeb: 5);
            selectTeam(context);
      },
      child: Center(
        child: Container(
          height: 50,
          width: MediaQuery
              .of(context)
              .size
              .width / 2.6,
          decoration: BoxDecoration(
              color: Color(0xff7579cb),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          child: Center(
            child: Text("Select Team",
              style: TextStyle(
                  color: Colors.white, letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialogAddTeamMember(BuildContext context) {
    Widget textField = Theme(
        data: ThemeData(
          primaryColor: Color(0xff787CD1),
        ),
        child: TextFormField(
          controller: team.memberNameController,
          decoration: InputDecoration(hintText: 'Enter member name'),
          validator: (value) {
            if (value.isEmpty) {
              return team.teamMemberNameEmpty;
            }
            return null;
          },
        ));

    Widget textFieldEmail = Theme(
        data: ThemeData(
          primaryColor: Color(0xff787CD1),
        ),
        child: TextFormField(
          controller: team.memberEmailController,
          decoration: InputDecoration(hintText: hint.memberEmail),
          validator: (value) {
            if (value.isEmpty) {
              return team.teamMemberEmailEmpty;
            }
            return null;
          },
        ));

    GestureDetector buildSaveButton = GestureDetector(
      onTap: () async {
        if (team.formKey2.currentState.validate()) {
          team.prTeam.show();
          String username = 'dezyit2021@gmail.com';
          String password = 'Dezyit2021@*#\$';

          var smtpServer = SmtpServer('mail.evyaas.com',username: 'noreply@evyaas.com',password: 'radar1234');
          //final smtpServer = gmail(username,password);

          final message = Message()
            ..from = Address('noreply@dezyit.com', 'Design Sprint')
            ..recipients.addAll(['${team.memberEmailController.text.toString()}'])
            ..ccRecipients.addAll(['info.gathrr@gmail.com'])
            ..bccRecipients.add(Address('farmreta@gmail.com'))
            ..subject = 'You joined a new Team'
            ..text = ''
            ..html = "<head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8' /><title>Dezy It</title> <meta name='viewport' content='width=device-width, initial-scale=1.0'/> <style>@import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300&display=swap');</style> <style type='text/css'>a[x-apple-data-detectors] {color: inherit !important;}</style></head> <body style='margin: 0; padding: 0;background: rgb(120, 124, 209);'> <table role='presentation' border='0' cellpadding='0' cellspacing='0' width='100%'> <tr> <td style='padding: 20px 0 30px 0;'> <table align='center' border='0' cellpadding='0' cellspacing='0' width='600' style='border-collapse: collapse; border: 1px solid #cccccc;'> <tr> <td align='center' bgcolor='#302b70' style='padding: 40px 0 30px 0;'> <img src='https://admin.dezyit.com/mobileapp/mailerimages/dezy.gif' alt='Creating Email Magic.' width='300' height='150px;' style='display: block;' /></td></tr> <tr> <td bgcolor='#ffffff' style='padding: 40px 30px 40px 30px;'> <table border='0' cellpadding='0' cellspacing='0' width='100%' style='border-collapse: collapse;'> <tr> <td style='color: #153643; font-family: Arial, sans-serif;'> <h1 style='font-size: 24px; margin: 0;text-align: center;font-family: Nunito Sans, sans-serif;'>You joined a new Team</h1></td></tr><tr><td style='color: #153643; font-family: Arial, sans-serif; font-size: 16px; line-height: 24px; padding: 20px 0 30px 0;'><p style='margin: 0;text-align: center;font-family: Nunito Sans, sans-serif;'>You have been added to a new team by ${profile.email}</p></td></tr><tr><td align='center' style='color: #153643; font-family: Arial, sans-serif;padding-bottom:120px;'><a href='http://onelink.to/equmbp' target='_blank' style='text-decoration: none;margin-top: 15px; border-radius: 100px;min-width: 140px;background:rgb(120, 124, 209);padding-top: 15px;padding-bottom: 15px;border:none;outline : none;font-size:14px;color:#fff;text-transform:capitalize;margin: 0 auto;padding-left: 20px;padding-right: 20px;font-family: Nunito Sans, sans-serif;'>Open App</a></td></tr><tr><td align='center' style='color: #153643; font-family: Arial, sans-serif;padding-bottom:120px;'><p style='font-family: Nunito Sans, sans-serif;'>Follow Us.:</p><a href='https://www.facebook.com/DezyIt/' target='_blank'><img src='https://admin.dezyit.com/mobileapp/mailerimages/facebook.png' height='28' width='28' alt='facebook'></a>&nbsp;&nbsp;&nbsp;<a target='_blank' href='https://in.pinterest.com/Dezy_It/'><img src='https://admin.dezyit.com/mobileapp/mailerimages/pinterest.png' height='28' width='28' alt='Pinterest'></a>&nbsp;&nbsp;&nbsp;<a target='_blank' href='https://twitter.com/dezy_it'><img src='https://admin.dezyit.com/mobileapp/mailerimages/twitter.png' height='28' width='28' alt='Twitter'></a></td></tr></table></td></tr></table></td></tr></table></body>";

          final equivalentMessage = Message()
            ..from = Address('noreply@dezyit.com', 'Design Sprint')
            ..recipients.addAll(['${team.memberEmailController.text.toString()}'])
            ..ccRecipients.addAll(['info.gathrr@gmail.com'])
            ..bccRecipients.add('farmreta@gmail.com')
            ..subject = 'You joined a new Team'
            ..text = ''
            ..html = "<head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8' /><title>Dezy It</title> <meta name='viewport' content='width=device-width, initial-scale=1.0'/> <style>@import url('https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300&display=swap');</style> <style type='text/css'>a[x-apple-data-detectors] {color: inherit !important;}</style></head> <body style='margin: 0; padding: 0;background: rgb(120, 124, 209);'> <table role='presentation' border='0' cellpadding='0' cellspacing='0' width='100%'> <tr> <td style='padding: 20px 0 30px 0;'> <table align='center' border='0' cellpadding='0' cellspacing='0' width='600' style='border-collapse: collapse; border: 1px solid #cccccc;'> <tr> <td align='center' bgcolor='#302b70' style='padding: 40px 0 30px 0;'> <img src='https://admin.dezyit.com/mobileapp/mailerimages/dezy.gif' alt='Creating Email Magic.' width='300' height='150px;' style='display: block;' /></td></tr> <tr> <td bgcolor='#ffffff' style='padding: 40px 30px 40px 30px;'> <table border='0' cellpadding='0' cellspacing='0' width='100%' style='border-collapse: collapse;'> <tr> <td style='color: #153643; font-family: Arial, sans-serif;'> <h1 style='font-size: 24px; margin: 0;text-align: center;font-family: Nunito Sans, sans-serif;'>You joined a new Team</h1></td></tr><tr><td style='color: #153643; font-family: Arial, sans-serif; font-size: 16px; line-height: 24px; padding: 20px 0 30px 0;'><p style='margin: 0;text-align: center;font-family: Nunito Sans, sans-serif;'>You have been added to a new team by ${profile.email}</p></td></tr><tr><td align='center' style='color: #153643; font-family: Arial, sans-serif;padding-bottom:120px;'><a href='http://onelink.to/equmbp' target='_blank' style='text-decoration: none;margin-top: 15px; border-radius: 100px;min-width: 140px;background:rgb(120, 124, 209);padding-top: 15px;padding-bottom: 15px;border:none;outline : none;font-size:14px;color:#fff;text-transform:capitalize;margin: 0 auto;padding-left: 20px;padding-right: 20px;font-family: Nunito Sans, sans-serif;'>Open App</a></td></tr><tr><td align='center' style='color: #153643; font-family: Arial, sans-serif;padding-bottom:120px;'><p style='font-family: Nunito Sans, sans-serif;'>Follow Us.:</p><a href='https://www.facebook.com/DezyIt/' target='_blank'><img src='https://admin.dezyit.com/mobileapp/mailerimages/facebook.png' height='28' width='28' alt='facebook'></a>&nbsp;&nbsp;&nbsp;<a target='_blank' href='https://in.pinterest.com/Dezy_It/'><img src='https://admin.dezyit.com/mobileapp/mailerimages/pinterest.png' height='28' width='28' alt='Pinterest'></a>&nbsp;&nbsp;&nbsp;<a target='_blank' href='https://twitter.com/dezy_it'><img src='https://admin.dezyit.com/mobileapp/mailerimages/twitter.png' height='28' width='28' alt='Twitter'></a></td></tr></table></td></tr></table></td></tr></table></body>";


          //final sendReport2 = await send(equivalentMessage, smtpServer);

          var connection = PersistentConnection(smtpServer);

          await connection.send(message);

          await connection.send(equivalentMessage);

          await connection.close();

          Provider.of<CustomViewModel>(context, listen: false)
              .addTeamMember(
                  profile.userID,
                  widget.teamid,
                  team.memberNameController.text,
                  team.memberEmailController.text)
              .then((value) async {
            team.prTeam.hide();
            pop(context);
          });
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 2.4,
          decoration: BoxDecoration(
              color: Color(0xff7579cb),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Center(
            child: Text(team.nextButtonText,
                style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                      fontSize: 16, letterSpacing: 1, color: Colors.white),
                )),
          ),
        ),
      ),
    );

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      title: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
          ),
          Text(team.addMember,
              style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(fontSize: 16, letterSpacing: 1),
              )),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: team.formKey2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                textField,
                textFieldEmail,
                SizedBox(height: 20),
                buildSaveButton,
              ],
            ),
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogEditTeamMember(BuildContext context, index, teamMemberId) {
    Widget textField = Theme(
        data: ThemeData(
          primaryColor: Color(0xff787CD1),
        ),
        child: TextFormField(
          controller: memberNameControllerEdit,
          decoration: InputDecoration(hintText: hint.memberName),
          validator: (value) {
            if (value.isEmpty) {
              return team.teamMemberNameEmpty;
            }
            return null;
          },
        ));

    Widget textFieldEmail = Theme(
        data: ThemeData(
          primaryColor: Color(0xff787CD1),
        ),
        child: TextFormField(
          controller: memberEmailControllerEdit,
          decoration: InputDecoration(hintText: hint.memberEmail),
          validator: (value) {
            if (value.isEmpty) {
              return team.teamMemberEmailEmpty;
            }
            return null;
          },
        ));

    GestureDetector buildSaveButton = GestureDetector(
      onTap: () async {
        if (team.formKey2.currentState.validate()) {
          team.prTeam.show();

          Provider.of<CustomViewModel>(context, listen: false)
              .editTeamMember(
                  index,
                  widget.teamid,
                  teamMemberId,
                  memberEmailControllerEdit.text,
                  memberNameControllerEdit.text,
                  "fcmtoken")
              .then((value) async {
            team.prTeam.hide();
            pop(context);
          });
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 2.4,
          decoration: BoxDecoration(
              color: Color(0xff7579cb),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Center(
            child: Text(team.nextButtonText,
                style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                      fontSize: 16, letterSpacing: 1, color: Colors.white),
                )),
          ),
        ),
      ),
    );

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      title: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
          ),
          Text(team.addMember,
              style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(fontSize: 16, letterSpacing: 1),
              )),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: team.formKey2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                textField,
                textFieldEmail,
                SizedBox(height: 20),
                buildSaveButton,
              ],
            ),
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogDeleteTeam(BuildContext context, index, teamMemberId) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Delete"),
      onPressed: () async {
        team.prTeam.show();

        Provider.of<CustomViewModel>(context, listen: false)
            .deleteTeamMember(index, teamMemberId)
            .then((value) async {
          team.prTeam.hide();
          Navigator.of(context).pop();
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Member"),
      content: Text("Are you sure you want to delete this member?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

var selectedTeamIdForDeleting;