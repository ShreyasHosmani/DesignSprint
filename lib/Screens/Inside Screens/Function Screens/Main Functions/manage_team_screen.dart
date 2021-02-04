import 'package:design_sprint/APIs/create_add_team.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_sprint_goal.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/design_sprint_sections_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/team_data.dart' as team;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/hint_texts.dart' as hint;
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'dart:convert';

bool statusDrawer = false;

class ManageTeam extends StatefulWidget {
  @override
  _ManageTeamState createState() => _ManageTeamState();
}

class _ManageTeamState extends State<ManageTeam> {
  TeamApiProvider teamApiProvider = TeamApiProvider();
  Future<String> removeTeamMember(context) async {

    String url = globals.urlLogin + "removeteammember.php";
    http.post(url, body: {

      "teamID" : selectedTeamMemberIdForDeleting.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      team.responseArrayRemoveMember = jsonDecode(response.body);
      print(team.responseArrayRemoveMember);

      team.responseArrayRemoveMemberMsg = team.responseArrayRemoveMember['message'].toString();
      if(statusCode == 200){
        if(team.responseArrayRemoveMemberMsg == "Member Removed Successfully"){
          team.prTeam.hide();
          Fluttertoast.showToast(msg: "Removing...", backgroundColor: Colors.black,
            textColor: Colors.white,).whenComplete((){
            teamApiProvider.getTeamMembers(context);
          });
        }else{
          team.prTeam.hide();
          Fluttertoast.showToast(msg: "Error", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }

    });
  }
  Future<String> addTeamMember(context) async {

    String url = globals.urlLogin + "addteammember.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID" : home.sprintID,
      "teamid" : team.teamID,
      "membername" : team.memberNameController.text,
      "memberemail" : team.memberEmailController.text,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      team.responseArrayAddTeam = jsonDecode(response.body);
      print(team.responseArrayAddTeam);

      team.responseArrayAddTeamMsg = team.responseArrayAddTeam['message'].toString();
      if(statusCode == 200){
        if(team.responseArrayAddTeamMsg == "Team Added Successfully"){
          team.prTeam.hide();
          Fluttertoast.showToast(msg: team.memberAdded, backgroundColor: Colors.black,
            textColor: Colors.white,).whenComplete((){
            team.memberEmailController.clear();
            team.memberNameController.clear();
            getTeamMembers(context);
            Navigator.of(context).pop();
          });
        }else{
          team.prTeam.hide();
          Fluttertoast.showToast(msg: team.responseArrayAddTeamMsg, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }

    });
  }
  Future<String> getTeamMembers(context) async {

    String url = globals.urlLogin + "getteamstatus.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID" : home.sprintID,
      "teamID" : team.teamID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      team.responseArrayTeamDetails = jsonDecode(response.body);
      print(team.responseArrayTeamDetails);

      team.responseArrayTeamDetailsMsg = team.responseArrayTeamDetails['message'].toString();
      if(statusCode == 200){
        if(team.responseArrayTeamDetailsMsg == "Profile Found"){
          setState(() {
            team.teamMemberIdsList = List.generate(team.responseArrayTeamDetails['data'].length, (i) => team.responseArrayTeamDetails['data'][i]['teamID'].toString());
            team.teamMemberNameList = List.generate(team.responseArrayTeamDetails['data'].length, (i) => team.responseArrayTeamDetails['data'][i]['teamMemberName'].toString());
            team.teamMemberEmailList = List.generate(team.responseArrayTeamDetails['data'].length, (i) => team.responseArrayTeamDetails['data'][i]['teamMemberEmail'].toString());
          });
          print(team.teamMemberIdsList.toList());
          print(team.teamMemberNameList.toList());
          print(team.teamMemberEmailList.toList());
        }else{
          setState(() {
            team.teamMemberIdsList = null;
            team.teamMemberNameList = null;
            team.teamMemberEmailList = null;
          });
        }
      }

    });
  }
  @override
  void initState() {
    teamApiProvider.getTeamMembers(context);
    super.initState();
    team.teamMemberNameList = null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: team.scaffoldKey2,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: statusDrawer == true ? StatusDrawerSprintGoal() : ProfileDrawerCommon(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Container(
            height: 50,
            child: buildNextButton(context)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                buildName2Widget(context),
                SizedBox(height: 20,),
                buildName3Widget(context),
                SizedBox(height: 40,),
                buildMemberCardWidget(context),
                SizedBox(height: 40,),
                team.teamMemberNameList == null ? Container() : buildAddMemberWidget(context),
              ],
            ),
          ),
          Positioned(
            top: 80, right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: statusBarDrawer(context),
            ),
          ),
          team.teamMemberNameList == null ? Center(child: buildAddMemberWidget(context)) : Container(),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context){

    Container line = Container(height:1,color: Colors.black,child: Divider());
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
        child: Text(team.appBarTitle,
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

  Widget statusBarDrawer(BuildContext context){
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
          child: Center(child: Text("<<",style: GoogleFonts.nunitoSans(textStyle: TextStyle(color: Color(0xff787CD1), fontSize: 18)),)),
        ),
      ),
    );
  }

  Widget buildStatusDrawer(BuildContext context){
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
                    child: Text("Sprint Name",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
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
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
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
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
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
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
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
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
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
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
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
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildName2Widget(BuildContext context){

    return Center(
      child: Text(team.teamNameController.text,
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

  Widget buildName3Widget(BuildContext context){

    return Center(
      child: Text(team.subTitleManageTeam2,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500
            )
        ),
      ),
    );
  }

  Widget buildMemberCardWidget(BuildContext context){
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: team.teamMemberNameList == null ? 0 : team.teamMemberNameList.length,
      itemBuilder: (context, i) => Padding(
        padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
        child: Container(
          width: 302,
          height: 57,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xff787cd1)),
              borderRadius: BorderRadius.all(Radius.circular(7)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(team.teamMemberNameList[i],
                  style: GoogleFonts.nunitoSans(
                    fontSize: 18,
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (val){
                    print(val);
                    if(val == "Delete Member"){
                      setState(() {
                        selectedTeamMemberIdForDeleting = team.teamMemberIdsList[i];
                      });
                      showAlertDialogDeleteTeam(context);
                    }else{

                    }
                  },
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(height: 3,width: 3,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                      ),
                      SizedBox(height: 3,),
                      Container(height: 3,width: 3,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                      ),
                      SizedBox(height: 3,),
                      Container(height: 3,width: 3,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                      ),
                    ],
                  ),
                  color: Colors.white,
                  itemBuilder: (BuildContext context) {
                    return {'Delete Member', 'Make Decision Maker'}.map((String choice) {
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
//                IconButton(
//                  icon: Icon(Icons.close, color: Colors.grey,),
//                  onPressed: (){
//                    setState(() {
//                      selectedTeamMemberIdForDeleting = team.teamMemberIdsList[i];
//                    });
//                    removeTeamMember(context).whenComplete((){
//                      Future.delayed(const Duration(seconds: 3), () {setState(() {});});
//                    });
//                  },
//                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAddMemberWidget(BuildContext context){
    return GestureDetector(
      onTap: (){
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
            child: Icon(Icons.add, color: Colors.white,),
          ),
          SizedBox(height: 10,),
          Text("Add Member",
            style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(
                  color: Color(0xff787CD1),
                  fontSize: 14,
                )
            ),
          )
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
            pageBuilder: (c, a1, a2) => EmphatizeSections(),
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

  showAlertDialogAddTeamMember(BuildContext context) {

    Widget textField = Theme(
        data: ThemeData(
          primaryColor: Color(0xff787CD1),
        ),
        child: TextFormField(
          controller: team.memberNameController,
          decoration: InputDecoration(
              hintText: hint.memberName
          ),
          validator: (value){
            if(value.isEmpty){
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
          decoration: InputDecoration(
              hintText: hint.memberEmail
          ),
          validator: (val) => !EmailValidator.validate(val, true)
              ? hint.validationEmail
              : null,
        ));

    GestureDetector buildSaveButton = GestureDetector(
      onTap: () async {
        if(team.formKey2.currentState.validate()){
          team.prTeam.show();
          addTeamMember(context);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10,
        child: Container(
          height: 50,
          width: MediaQuery
              .of(context)
              .size
              .width / 2.4,
          decoration: BoxDecoration(
              color: Color(0xff7579cb),
              borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          child: Center(
            child: Text(team.nextButtonText,
                style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 16, letterSpacing: 1,color: Colors.white),)
            ),
          ),
        ),
      ),
    );

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
      title: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(icon: Icon(Icons.close,color: Colors.grey,),onPressed: (){Navigator.of(context).pop();},)),
          Text(team.addMember, style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 16, letterSpacing: 1),)),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: team.formKey2,
            child: SingleChildScrollView(
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
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogDeleteTeam(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Delete"),
      onPressed:  () async {
        Navigator.of(context).pop();
        removeTeamMember(context).whenComplete((){
          Future.delayed(const Duration(seconds: 3), () {setState(() {});});
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

var selectedTeamMemberIdForDeleting;
