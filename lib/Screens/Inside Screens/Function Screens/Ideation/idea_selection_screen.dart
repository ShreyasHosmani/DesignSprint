import 'package:design_sprint/APIs/get_pain_points.dart';
import 'package:design_sprint/APIs/upload_idea_image.dart';
import 'package:design_sprint/APIs/vote_pain_point.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_empathize.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/design_sprint_sections_screen3.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_sprint_inside_sections.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/ideation_data.dart' as ideation;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

bool statusDrawer = false;
var ppiiStatus;

var teamMemberStatuses;
var sprintCreatorId;

var sprintAdmins;

class IdeaSelection extends StatefulWidget {
  @override
  _IdeaSelectionState createState() => _IdeaSelectionState();
}

class _IdeaSelectionState extends State<IdeaSelection> {
  GetPainPointsApiProvider getPainPointsApiProvider = GetPainPointsApiProvider();
  VotePainPointsApiProvider votePainPointsApiProvider = VotePainPointsApiProvider();
  UploadIdeaApiProvider uploadIdeaApiProvider = UploadIdeaApiProvider();
  Future<String> getPainPointsByIvsFPriority(context) async {

    String url = globals.urlSignUp + "getimpactfeasibilityvote.php";

    http.post(url, body: {

      //"userID" : profile.userID,
      "sprintID": home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ideation.responseArrayGetIvsFByPriority = jsonDecode(response.body);
      print(ideation.responseArrayGetIvsFByPriority);

      ideation.responseArrayGetIvsFByPriorityMsg = ideation.responseArrayGetIvsFByPriority['message'].toString();
      print(ideation.responseArrayGetIvsFByPriorityMsg);
      if(statusCode == 200){
        if(ideation.responseArrayGetIvsFByPriorityMsg == "Data Found"){
          setState(() {
            ideation.painPointsByIvsFPriorityList = List.generate(ideation.responseArrayGetIvsFByPriority['data'].length, (index) => ideation.responseArrayGetIvsFByPriority['data'][index]['ppName'].toString());
            ideation.painPointIdsByIvsFPriorityList = List.generate(ideation.responseArrayGetIvsFByPriority['data'].length, (index) => ideation.responseArrayGetIvsFByPriority['data'][index]['ppID'].toString());
            ppiiStatus = List.generate(ideation.responseArrayGetIvsFByPriority['data'].length, (index) => ideation.responseArrayGetIvsFByPriority['data'][index]['ppImagestatus'].toString());
          });
          print(ideation.painPointsByIvsFPriorityList.toList());
          print(ideation.painPointIdsByIvsFPriorityList.toList());
          print(ppiiStatus.toList());
        }else{

        }
      }
    });
  }
  Future<String> getAllIdeaImages(context) async {

    String url = globals.urlSignUp + "getideaimagespainpointwise.php";

    http.post(url, body: {

      "sprintID" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ideation.responseArrayGetAllIdeaImages = jsonDecode(response.body);
      print(ideation.responseArrayGetAllIdeaImages);

      ideation.responseArrayGetAllIdeaImagesMsg = ideation.responseArrayGetAllIdeaImages['message'].toString();
      print(ideation.responseArrayGetAllIdeaImagesMsg);

      if(ideation.responseArrayGetAllIdeaImagesMsg == "Painpoint Data Found"){

        setState(() {
          ideation.ideaAllImagesPainPointWiseList = List.generate(ideation.responseArrayGetAllIdeaImages['data'].length, (i) => ideation.responseArrayGetAllIdeaImages['data'][i]['iiImgpath'].toString());
        });

        print(ideation.ideaAllImagesPainPointWiseList.toList());

      }else{

        setState(() {
          ideation.ideaAllImagesPainPointWiseList = null;
        });

      }

    });
  }
  Future<String> updateStep7(context) async {

    String url = globals.urlSignUp + "updatesprintstatus.php";

    http.post(url, body: {

      "userID" : profile.email,
      "sprintID" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
      "stepID" : "7",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayUpdateStatus = jsonDecode(response.body);
      print(responseArrayUpdateStatus);

      var responseArrayUpdateStatusMsg = responseArrayUpdateStatus['message'].toString();
      print(responseArrayUpdateStatusMsg);
      if(statusCode == 200){
        if(responseArrayUpdateStatusMsg == "Timeline updated Successfully"){
          print("Status updated!!");
        }else{

        }
      }
    });
  }

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
            teamMemberStatuses = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep7'].toString());
            sprintCreatorId = responseArrayGetSprintStatuses['data'][0]['sprintUserid'].toString();
          });

          print(teamMemberStatuses);
          print(sprintCreatorId);

        }else{

          setState(() {
            teamMemberStatuses = ['1'];
            sprintCreatorId = profile.userID.toString();
          });

        }
      }
    });
  }

  Future<String> getSprintAdmins(context) async {
    String url = globals.urlLogin + "getsprintbyrights.php";

    http.post(url, body: {

      "sprintID" : home.selectedSprintId.toString() == null || home.selectedSprintId.toString() == "null" ? home.sprintID.toString() : home.selectedSprintId.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayGetSprintAdmins = jsonDecode(response.body);
      print(responseArrayGetSprintAdmins);

      var responseArrayGetSprintAdminsMsg = responseArrayGetSprintAdmins['message'].toString();
      print(responseArrayGetSprintAdminsMsg);

      if(statusCode == 200){
        if(responseArrayGetSprintAdminsMsg == "Data Found"){

          setState(() {
            sprintAdmins = List.generate(responseArrayGetSprintAdmins['data'].length, (index) => responseArrayGetSprintAdmins['data'][index]['teamMemberEmail'].toString() == profile.email.toString() ? responseArrayGetSprintAdmins['data'][index]['teamStatus'].toString() : "null");
          });

          print("sprintAdmins : "+sprintAdmins.toList().toString());

        }else{

          setState(() {
            sprintAdmins = ["0"];
          });

        }
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSprintAdmins(context);
    getSprintsStatusesOfTeam(context);
    ideation.ideaAllImagesPainPointWiseList = null;
    getPainPointsByIvsFPriority(context);
    getAllIdeaImages(context);
    updateStep7(context);
    boolSelectedList = [false,false,false,false,false,false,false,false,false,false,];
    counter = 0;
    textColorList = [Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), ];
    getSprintsStatusesOfTeam(context);
    getSprintsStatusesOfTeam(context);
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    //getSprintsStatusesOfTeam(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: ProfileDrawerCommon(),
      bottomNavigationBar:/* teamMemberStatuses.toList().contains("0") ? null : */Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Container(
            height: 50,
            child: buildNextButton(context)),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                buildName2Widget(context),
                SizedBox(height: 35,),
                buildName3Widget(context),
                SizedBox(height: 25,),
                buildSelectIdeasList(context),
                SizedBox(height: 40,),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: statusBarDrawer(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context){

    Container line = Container(height:1,color: Colors.black,child: Divider());
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
        child: Text(ideation.title,
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
      _scaffoldKey.currentState.openEndDrawer();
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
      child: GestureDetector(
        onTap: (){
          getSprintsStatusesOfTeam(context);
        },
        child: Text(ideation.ivsfanalysis,
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                  color: Color(0xff707070),
                  fontSize: 20,
                  fontWeight: FontWeight.w200
              )
          ),
        ),
      ),
    );
  }

  Widget buildName3Widget(BuildContext context){

    return Center(
      child: Text(ideation.select3to5FinalIdeas,
        textAlign: TextAlign.center,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
            )
        ),
      ),
    );
  }

  Widget buildSelectIdeasList(BuildContext context){
    return Container(
      //height: MediaQuery.of(context).size.height/1.2,
      child: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: ideation.painPointsByIvsFPriorityList == null ? 0 : ideation.painPointsByIvsFPriorityList.length,
        itemBuilder: (context, i) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                ideation.ideaAllImagesPainPointWiseList == null ? Container(
                  height: 161,
                  width: 302,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    border: Border.all(color: Colors.grey),
                  ),
                ) : GestureDetector(
                  onTap: (){
                    launch(globals.urlSignUp+ideation.ideaAllImagesPainPointWiseList[i]);
                  },
                  child: Container(
                    height: 161,
                    width: 302,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      border: Border.all(color: Colors.grey),
                      image: DecorationImage(
                          image: NetworkImage(globals.urlSignUp+ideation.ideaAllImagesPainPointWiseList[i]),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                ),
                boolSelectedList[i] == true ? Padding(
                  padding: const EdgeInsets.only(left: 252, top: 20),
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        color: Color(0xff787CD1),
                        borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: Center(
                      child: Text("$counter",
                        style: GoogleFonts.nunitoSans(
                            fontSize: 16,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ) : Container(height: 1,width: 1,)
              ],
            ),
            SizedBox(height: 20,),
            /*teamMemberStatuses.toList().contains("0") ? Container() :*/ GestureDetector(
              onTap: (){
                print("sprintAdmins + " + sprintAdmins.toString());

                print("dmID : " + dmIDd.toString());
                print("profile.userID : " + profile.userID.toString());

                if(dmIDd.toString() == "null"){
                  setState(() {
                    boolSelectedList[i] = !boolSelectedList[i];
                    if(boolSelectedList[i] == false){
                      print("1111111");
                      setState(() {
                        counter--;
                        ideation.selectedPainPointIdForPrototyping = ideation.painPointIdsByIvsFPriorityList[i].toString();
                        ideation.selectedPainPointForPrototypingStatus = "0";
                      });
                      print(ideation.selectedPainPointIdForPrototyping);
                      print(ideation.selectedPainPointForPrototypingStatus);
                      votePainPointsApiProvider.selectFinalPainPointsForPrototyping(context).then((value){
                        Future.delayed(Duration(seconds: 2), () async {
                          getPainPointsByIvsFPriority(context);
                        });
                      });
                    }else{
                      print("222222");
                      setState(() {
                        counter++;
                        ideation.selectedPainPointIdForPrototyping = ideation.painPointIdsByIvsFPriorityList[i].toString();
                        ideation.selectedPainPointForPrototypingStatus = "2";
                      });
                      print(ideation.selectedPainPointIdForPrototyping);
                      print(ideation.selectedPainPointForPrototypingStatus);
                      votePainPointsApiProvider.selectFinalPainPointsForPrototyping(context).then((value){
                        Future.delayed(Duration(seconds: 2), () async {
                          getPainPointsByIvsFPriority(context);
                        });
                      });
                    }
                  });
                }else{
                  if(dmIDd == profile.userID){

                    print("entering first if else looooooppppp!!!");

                    if(profile.userID == sprintCreatorId || sprintAdmins.toList().contains('1')){

                      print("entering second if else looooooppppp!!!");

                      setState(() {
                        boolSelectedList[i] = !boolSelectedList[i];
                        if(boolSelectedList[i] == false){
                          print("1111111");
                          setState(() {
                            counter--;
                            ideation.selectedPainPointIdForPrototyping = ideation.painPointIdsByIvsFPriorityList[i].toString();
                            ideation.selectedPainPointForPrototypingStatus = "0";
                          });
                          print(ideation.selectedPainPointIdForPrototyping);
                          print(ideation.selectedPainPointForPrototypingStatus);
                          votePainPointsApiProvider.selectFinalPainPointsForPrototyping(context).then((value){
                            Future.delayed(Duration(seconds: 2), () async {
                              getPainPointsByIvsFPriority(context);
                            });
                          });
                        }else{
                          print("222222");
                          setState(() {
                            counter++;
                            ideation.selectedPainPointIdForPrototyping = ideation.painPointIdsByIvsFPriorityList[i].toString();
                            ideation.selectedPainPointForPrototypingStatus = "2";
                          });
                          print(ideation.selectedPainPointIdForPrototyping);
                          print(ideation.selectedPainPointForPrototypingStatus);
                          votePainPointsApiProvider.selectFinalPainPointsForPrototyping(context).then((value){
                            Future.delayed(Duration(seconds: 2), () async {
                              getPainPointsByIvsFPriority(context);
                            });
                          });
                        }
                      });
                    }else{
                      print("exiting second else looooooppppp!!!");
                      Fluttertoast.showToast(msg: 'Please wait until the decision maker selects the final ideas!',
                        backgroundColor: Colors.black, textColor: Colors.white,
                      );
                    }

//                }else{
//                  Fluttertoast.showToast(msg: 'Please wait untill decision maker selects the final ideas!',
//                    backgroundColor: Colors.black, textColor: Colors.white,
//                  );
//                }
                  }else{
                    print("exiting first else looooooppppp!!!");
                    Fluttertoast.showToast(msg: 'Please wait until the decision maker selects the final ideas!',
                      backgroundColor: Colors.black, textColor: Colors.white,
                    );
                  }
                }
                },
              child: Container(
                width: 102,
                height: 37,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                    border: Border.all(color: Color(0xff787cd1)),
                  color: boolSelectedList[i] == true ? Color(0xff787cd1) : Colors.white,
                ),
                child: Center(
                  child: Text("Select",
                    style: GoogleFonts.nunitoSans(
                      color: boolSelectedList[i] == false ? textColorList[i] : Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            /*teamMemberStatuses.toList().contains("0") ? Container() : */SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: (){

       if(home.selectedSprintId == null || home.selectedSprintId == "null"){
         if(ppiiStatus.contains('1')){
           print("contains 1");
           if(dmIDd == profile.userID){
             print("i am a decision maker");
             Navigator.push(
               context,
               PageRouteBuilder(
                 pageBuilder: (c, a1, a2) => EmphatizeSections3(),
                 transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                 transitionDuration: Duration(milliseconds: 300),
               ),
             );
           }else{
             print("i am not a decision maker");
             Navigator.push(
               context,
               PageRouteBuilder(
                 pageBuilder: (c, a1, a2) => EmphatizeSections3(),
                 transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                 transitionDuration: Duration(milliseconds: 300),
               ),
             );
           }
         }else{
           print("doesnt contain 1");
           if(dmIDd == profile.userID){
             print("i am a decision maker");
             if(home.selectedSprintId == null || home.selectedSprintId == "null"){
               Navigator.push(
                 context,
                 PageRouteBuilder(
                   pageBuilder: (c, a1, a2) => EmphatizeSections3(),
                   transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                   transitionDuration: Duration(milliseconds: 300),
                 ),
               );
             }else{
               Fluttertoast.showToast(msg: 'Please select atleast one of the ideas!',
                 backgroundColor: Colors.black, textColor: Colors.white,
               );
             }
           }else{
             print("i am not a decision maker");
             if(home.selectedSprintId == null || home.selectedSprintId == "null"){
               Navigator.push(
                 context,
                 PageRouteBuilder(
                   pageBuilder: (c, a1, a2) => EmphatizeSections3(),
                   transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                   transitionDuration: Duration(milliseconds: 300),
                 ),
               );
             }else{
               Fluttertoast.showToast(msg: 'Please wait untill decision maker selects the final ideas!',
                 backgroundColor: Colors.black, textColor: Colors.white,
               );
             }
           }
         }
       }else{
         Navigator.push(
           context,
           PageRouteBuilder(
             pageBuilder: (c, a1, a2) => EmphatizeSections3(),
             transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
             transitionDuration: Duration(milliseconds: 300),
           ),
         );
       }

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

var containerColorList = [Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, ];
var textColorList = [Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), Color(0xff787cd1), ];
var boolSelectedList = [false,false,false,false,false,false,false,false,false,false,];
var counterList = [];
int counter = 0;
