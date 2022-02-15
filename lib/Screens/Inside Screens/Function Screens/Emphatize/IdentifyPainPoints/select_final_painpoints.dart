import 'package:design_sprint/APIs/get_pain_points.dart';
import 'package:design_sprint/APIs/vote_pain_point.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_team.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/design_sprint_sections_screen2.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_sprint_inside_sections.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_sprints_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'dart:convert';
import 'package:http/http.dart' as http;

bool statusDrawer = false;
var ppStatus;
var sprintType;
var teamMemberStatuses;
var sprintCreatorId;
var sprintAdmins;

class SelectFinalPainPoints extends StatefulWidget {
  @override
  _SelectFinalPainPointsState createState() => _SelectFinalPainPointsState();
}

class _SelectFinalPainPointsState extends State<SelectFinalPainPoints> {
  GetPainPointsApiProvider getPainPointsApiProvider = GetPainPointsApiProvider();
  VotePainPointsApiProvider votePainPointsApiProvider = VotePainPointsApiProvider();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<String> getPainPointsAccordingToVotes(context) async {

    String url = globals.urlSignUp + "getsprintvote.php";

    http.post(url, body: {

      "sprintID": home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayGetPainPointsAccToVotes = jsonDecode(response.body);
      print(empathize.responseArrayGetPainPointsAccToVotes);

      empathize.responseArrayGetPainPointsAccToVotesMsg = empathize.responseArrayGetPainPointsAccToVotes['message'].toString();
      print(empathize.responseArrayGetPainPointsAccToVotesMsg);
      if(statusCode == 200){
        if(empathize.responseArrayGetPainPointsAccToVotesMsg == "Data Found"){
          setState(() {
            empathize.painPointsListAccToVotes = List.generate(empathize.responseArrayGetPainPointsAccToVotes['data'].length, (index) => empathize.responseArrayGetPainPointsAccToVotes['data'][index]['ppName'].toString());
            empathize.painPointIdsListAccToVotes = List.generate(empathize.responseArrayGetPainPointsAccToVotes['data'].length, (index) => empathize.responseArrayGetPainPointsAccToVotes['data'][index]['ppID'].toString());
            ppStatus = List.generate(empathize.responseArrayGetPainPointsAccToVotes['data'].length, (index) => empathize.responseArrayGetPainPointsAccToVotes['data'][index]['ppStatus'].toString());
          });
          print(empathize.painPointsListAccToVotes.toList());
          print(empathize.painPointIdsListAccToVotes.toList());
          print(ppStatus.toList());
        }else{
          setState(() {
            empathize.painPointsListAccToVotes = null;
          });
        }
      }
    });
  }
  Future<String> updateStep4(context) async {

    String url = globals.urlSignUp + "updatesprintstatus.php";

    http.post(url, body: {

      "userID" : profile.email,
      "sprintID" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
      "stepID" : "4",

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
            teamMemberStatuses = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep4'].toString());
            //sprintCreatorId = responseArrayGetSprintStatuses['data'][0]['sprintUserid'].toString();
          });

          print(teamMemberStatuses);
          //print(sprintCreatorId);

        }else{

          setState(() {
            teamMemberStatuses = ['1'];
            //sprintCreatorId = profile.userID.toString();
          });

        }
      }
    });
  }

  Future<String> getStoreData(context) async {

    String url = "https://admin.dezyit.com/mobileapp/api/users/getstore.php";

    http.post(url, body: {

      "storeSprintId" : home.selectedSprintId.toString() == null || home.selectedSprintId.toString() == "null" ? home.sprintID.toString() : home.selectedSprintId.toString(),
      "storeUserId" : profile.userID.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      print("/////");
      var responseArrayGetSprintStatuses = jsonDecode(response.body);
      print(responseArrayGetSprintStatuses);

      var responseArrayGetSprintStatusesMsg = responseArrayGetSprintStatuses['message'].toString();
      print(responseArrayGetSprintStatusesMsg);
      print("/////");

      if(responseArrayGetSprintStatusesMsg == "successfully"){
        setState(() {
          sprintType = responseArrayGetSprintStatuses['data']['storeSprintType'].toString();
          sprintCreatorId = responseArrayGetSprintStatuses['data']['storeUserId'].toString();
        });
        print("sprintType : "+sprintType.toString());
        print("storeUserId : "+sprintCreatorId.toString());
      }

    });
  }

  Future<Null> refreshData() async {
    getSprintsStatusesOfTeam(context);
    getStoreData(context);
  }

/*  Future<String> getSprintAdmins(context) async {
    String url = globals.urlLogin + "getsprintbyrights.php";

    http.post(url, body: {

      "sprintID" :  home.selectedSprintId,

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

          print(sprintAdmins.toList());

        }else{

          setState(() {
            sprintAdmins = null;
          });

        }
      }
    });
  }*/

  @override
  void initState() {
    super.initState();
    setState(() {
      sprintType = null;
    });
    updateStep4(context);
    getStoreData(context);
  //  getSprintAdmins(context);
    getSprintsStatusesOfTeam(context);
    empathize.painPointsListAccToVotes = null;
    checkList = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,];
    getPainPointsAccordingToVotes(context);
  }
  @override
  Widget build(BuildContext context) {
   // getSprintsStatusesOfTeam(context);
    return empathize.painPointsListAccToVotes == null ? Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ) : Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: statusDrawer == true ? StatusDrawerTeam() : ProfileDrawerCommon(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Container(
            height: 50,
            child: buildNextButton(context)),
      ),
      body: RefreshIndicator(
        onRefresh: () => refreshData(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              buildName2Widget(context),
              SizedBox(height: 20,),
              buildName3Widget(context),
              SizedBox(height: 35,),
              buildPainPointsList(context),
              SizedBox(height: 40,),
            ],
          ),
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
        child: Text(empathize.empathize,
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
      child: Text(empathize.identifyPainPoints,
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
      child: Text(empathize.finalPainPointHint1,
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

  Widget buildPainPointsList(BuildContext context){
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: empathize.painPointIdsListAccToVotes == null ? 0 : empathize.painPointIdsListAccToVotes.length,
      itemBuilder: (context, i) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: Color(0xff787cd1),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width/50,),
              Container(
                height: 61,
                width: 280,
                child: Center(
                  child: Text(empathize.painPointsListAccToVotes[i],
                    maxLines: 5,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width/50,),
              sprintType.toString() == "Collab" && sprintCreatorId.toString() != profile.userID.toString() ? Container() : GestureDetector(
                onTap: (){
                  print("profile.userID" + profile.userID.toString());
                  print("sprintCreatorId" + sprintCreatorId.toString());
                  //if(profile.userID == sprintCreatorId /*|| sprintAdmins.toList().contains('1')*/){
                    setState(() {
                      checkList[i] = !checkList[i];
                      empathize.selectedFinalPainPointId = empathize.painPointIdsListAccToVotes[i].toString();
                      if(checkList[i] == true){
                        empathize.painPointStatus ="2";
                      }else{
                        empathize.painPointStatus ="1";
                      }
                    });
                    print(empathize.selectedFinalPainPointId);
                    print(empathize.painPointStatus);
                    votePainPointsApiProvider.selectFinalPainPoints(context).whenComplete((){
                      getPainPointsAccordingToVotes(context);
                    });
                  // }else{
                  //   Fluttertoast.showToast(msg: 'Please wait until the decision maker selects the final pain points!',
                  //     backgroundColor: Colors.black, textColor: Colors.white,gravity: ToastGravity.CENTER
                  //   );
                  // }
                },
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                  ),
                  child: checkList[i] == false ? Container(height: 1,width: 1,) : Center(
                    child: Icon(Icons.check, color: Color(0xff787cd1),size: 15,),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return InkWell(
      onTap: (){
        if(sprintType.toString() == "Solo"){
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => EmphatizeSections2(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        }else{
          if(sprintCreatorId.toString() == profile.userID.toString()){
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => EmphatizeSections2(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          }else{
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => ViewSprints(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          }
        }
        /*if(home.selectedSprintId == null || home.selectedSprintId == "null"){
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => EmphatizeSections2(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        }else{
          if(ppStatus.contains('1')){
            print("contains 1");
            if(dmIDd == profile.userID){
              print("i am a decision maker");
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => EmphatizeSections2(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else{
              print("i am not a decision maker");
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => EmphatizeSections2(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }
          }else{
            print("doesnt contain 1");
            if(dmIDd == profile.userID){
              print("i am a decision maker");
              Fluttertoast.showToast(msg: 'Please select atleast one pain point!',
                backgroundColor: Colors.black, textColor: Colors.white,
              );
            }else{
              print("i am not a decision maker");
              Fluttertoast.showToast(msg: 'Please wait untill decision maker selects the final pain points!',
                backgroundColor: Colors.black, textColor: Colors.white,
              );
            }
          }
        }*/
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

var checkList = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,];
