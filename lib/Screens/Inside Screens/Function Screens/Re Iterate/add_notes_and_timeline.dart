import 'dart:convert';

import 'package:design_sprint/APIs/get_team_by_sprints.dart';
import 'package:design_sprint/APIs/reiterate_calls.dart';
import 'package:design_sprint/Helpers/helper.dart';
import 'package:design_sprint/Models/MembersListParser.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_user_testing.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Re%20Iterate/road_map_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Re%20Iterate/road_map_screen_sprint_wise.dart';
import 'package:design_sprint/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/reiterate_data.dart' as reiterate;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/hint_texts.dart' as hint;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:design_sprint/utils/team_by_sprints_data.dart' as teamBySprints;
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/reiterate_data.dart' as reiterate;

bool statusDrawer = false;
ProgressDialog prTeam;

var sprintCreatorId;
var sprintType;
var _currentSelectedValue;
var teamNameIdForTeamMembers;

class AddNotesAndTimeLinePageViewBuilder extends StatefulWidget {
  @override
  _AddNotesAndTimeLinePageViewBuilderState createState() =>
      _AddNotesAndTimeLinePageViewBuilderState();
}

class _AddNotesAndTimeLinePageViewBuilderState
    extends State<AddNotesAndTimeLinePageViewBuilder> {
  final controller = PageController(viewportFraction: 1);
  ReIterateApiProvider reIterateApiProvider = ReIterateApiProvider();
  GetTeamBySprintApiProvider getTeamBySprintApiProvider =
      GetTeamBySprintApiProvider();

  Future<String> getPrototypeOfStatusTwo(context) async {

    print("Sprint iD : "+home.sprintID.toString());

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
        reiterate.prototypeAllImagesListOfStatusTwo = null;
        reiterate.prototypeAllImagesIdsListOfStatusTwo = null;
        reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo =
            jsonDecode(response.body);
        print(reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo);

        reiterate.responseArrayGetAllPrototypeImagesOfStatusTwoMsg = reiterate
            .responseArrayGetAllPrototypeImagesOfStatusTwo['message']
            .toString();
        print(reiterate.responseArrayGetAllPrototypeImagesOfStatusTwoMsg);
      });

      setState(() {
        if (reiterate.responseArrayGetAllPrototypeImagesOfStatusTwoMsg ==
            "Data Found") {

          print("+++++++++");

          reiterate.prototypeAllImagesListOfStatusTwo = List.generate(
              reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo['data'].length,
                  (i) => reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo['data'][i]
              ['ptiImgpath']
                  .toString());
          reiterate.prototypeAllImagesIdsListOfStatusTwo = List.generate(
              reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo['data'].length,
                  (i) => reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo['data'][i]
              ['ptiID']
                  .toString());

          print(reiterate.prototypeAllImagesListOfStatusTwo.toList());
          print(reiterate.prototypeAllImagesIdsListOfStatusTwo.toList());
        } else {
          reiterate.prototypeAllImagesListOfStatusTwo = null;
        }
      });

    });
  }

  Future initTask() async {
    print("Calling initttttttt taasskkkk");
    Provider.of<CustomViewModel>(context, listen: false)
        .getTeamMembersList(teamNameIdForTeamMembers)
        .then((value) async {
      // setState(() {
      //   _isloaded = true;
      // });
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
          teamNameIdForTeamMembers = responseArrayGetSprintStatuses['data']['storeteamID'].toString();
        });
        print("sprintType : "+sprintType.toString());
        print("storeUserId : "+sprintCreatorId.toString());
        print("teamNameIdForTeamMembers : "+teamNameIdForTeamMembers.toString());


        initTask();
      }

    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    reiterate.pageIndexNotesAndTimeLine = 0;
    initLists();
    getStoreData(context);
    setState(() {
      _currentSelectedValue = null;
      //sprintType = null;
      reiterate.noteUploaded = false;
      selectedTeamMember = null;
    });
    getTeamBySprintApiProvider.getTeamdata2(context);
    getPrototypeOfStatusTwo(context);
  }

  initLists() {
    setState(() {
      reiterate.roadMapNotesList = [];
      reiterate.roadMapNotesList1 = [];
      reiterate.roadMapNotesList2 = [];
      reiterate.roadMapNotesList3 = [];
      reiterate.roadMapNotesList4 = [];
      reiterate.roadMapNotesList5 = [];
      reiterate.roadMapNotesList6 = [];
      reiterate.roadMapNotesList7 = [];
      reiterate.roadMapNotesList8 = [];
      reiterate.roadMapNotesList9 = [];
      reiterate.roadMapNotesList10 = [];
      reiterate.roadMapTaskList = [];
      reiterate.roadMapTaskList1 = [];
      reiterate.roadMapTaskList2 = [];
      reiterate.roadMapTaskList3 = [];
      reiterate.roadMapTaskList4 = [];
      reiterate.roadMapTaskList5 = [];
      reiterate.roadMapTaskList6 = [];
      reiterate.roadMapTaskList7 = [];
      reiterate.roadMapTaskList8 = [];
      reiterate.roadMapTaskList9 = [];
      reiterate.roadMapTaskList10 = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    prTeam = ProgressDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: reiterate.prototypeAllImagesListOfStatusTwo == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PageView.builder(
              physics: new NeverScrollableScrollPhysics(),
              itemCount: reiterate.prototypeAllImagesListOfStatusTwo == null
                  ? 0
                  : reiterate.prototypeAllImagesListOfStatusTwo.length,
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  reiterate.pageIndexNotesAndTimeLine = index;
                  reiterate.selectedPrototypeIdForUploadingNotesAndImages =
                      reiterate.prototypeAllImagesIdsListOfStatusTwo[
                          reiterate.pageIndexNotesAndTimeLine];
                });
                print(reiterate.pageIndexNotesAndTimeLine);
                print(reiterate.selectedPrototypeIdForUploadingNotesAndImages);
              },
              itemBuilder: (BuildContext context, int index) {
                return AddNotesAndTimeLine(controller);
              },
            ),
    );
  }
}

class AddNotesAndTimeLine extends StatefulWidget {
  final controller;

  AddNotesAndTimeLine(this.controller) : super();

  @override
  _AddNotesAndTimeLineState createState() => _AddNotesAndTimeLineState();
}

class _AddNotesAndTimeLineState extends State<AddNotesAndTimeLine> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ReIterateApiProvider reIterateApiProvider = ReIterateApiProvider();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2501));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        teamBySprints.dateForSending = selectedDate.toString().substring(0, 10);
        datePicked = true;
      });
    print(teamBySprints.dateForSending);
  }

  Future<String> uploadPrototypeNote(context) async {
    String url = globals.urlSignUp + "createprototypenote.php";

    print({
      "userID": "null",
      "sprintID": (home.sprintID == null || home.sprintID == "null"
          ? home.selectedSprintId
          : home.sprintID)
          .toString(),
      "prototypeID":
      reiterate.selectedPrototypeIdForUploadingNotesAndTimeLine.toString(),
      "notetext": reiterate.notesController.text,
    });

    http.post(url, body: {
      "userID": "null",
      "sprintID": (home.sprintID == null || home.sprintID == "null"
          ? home.selectedSprintId
          : home.sprintID)
          .toString(),
      "prototypeID":
      reiterate.selectedPrototypeIdForUploadingNotesAndTimeLine.toString(),
      "notetext": reiterate.notesController.text,
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayUploadPrototype = jsonDecode(response.body);
      print(reiterate.responseArrayUploadPrototype);

      reiterate.responseArrayUploadPrototypeMsg =
          reiterate.responseArrayUploadPrototype['message'].toString();
      print(reiterate.responseArrayUploadPrototypeMsg);

      if (reiterate.responseArrayUploadPrototypeMsg == "Prototype Note Added") {
        Fluttertoast.showToast(
          msg: "notes saved",
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

        setState(() {
          reiterate.noteUploaded = true;
        });
        print(reiterate.noteUploaded);
        insertNotes();
      } else {
        Fluttertoast.showToast(
          msg: "please check your internet connection",
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      teamBySprints.dateForSending = "";
      datePicked = false;
      reiterate.noteUploaded = false;
      reiterate.notesController.clear();
      reiterate.uploadedTaskList = [];
      reiterate.uploadedTaskListNames = [];
      reiterate.uploadedTeamMemberList = [];
      reiterate.uploadedDueDateList = [];
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        reiterate.selectedPrototypeIdForUploadingNotesAndTimeLine =
            reiterate.prototypeAllImagesIdsListOfStatusTwo[
                reiterate.pageIndexNotesAndTimeLine];
      });
      print(reiterate.selectedPrototypeIdForUploadingNotesAndTimeLine);
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: statusDrawer == true
          ? StatusDrawerUserTesting()
          : ProfileDrawerCommon(),
      body: GestureDetector(
        onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
        child: SingleChildScrollView(
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
              buildPrototypeImageCard(context),
              SizedBox(
                height: 40,
              ),
              buildNotesArea(context),
              SizedBox(
                height: 20,
              ),
              reiterate.noteUploaded == true
                  ? Container() : Center(
                    child: Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        print("reiterate.noteUploaded : "+reiterate.noteUploaded.toString());
                        //reiterate.notesFocus.requestFocus();
                        reiterate.notesFocus.unfocus();
                        reIterateApiProvider
                            .uploadPrototypeNote(context)
                            .whenComplete(() {
                          Future.delayed(const Duration(seconds: 3), () {
                            setState(() {
                              reiterate.noteUploaded = true;
                            });
                            insertNotes();
                          });
                        });
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.nunitoSans(color: Color(0xff787CD1)),
                      ),
                    ),
                ),
              ),
                  ),
              SizedBox(
                height: 0,
              ),
              buildTimelineListViewBuiler(context),
              SizedBox(
                height: 40,
              ),
              buildTimeLineArea(context),
              SizedBox(
                height: 40,
              ),
              buildAddTaskWidget(context),
              SizedBox(
                height: 40,
              ),
              buildNextButton(context),
              SizedBox(
                height: 40,
              ),
            ],
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
        reiterate.notesAndTimeLine,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                color: Color(0xff707070),
                fontSize: 20,
                fontWeight: FontWeight.w200)),
      ),
    );
  }

  Widget buildPrototypeImageCard(BuildContext context) {
    return Center(
      child: Container(
        width: 302,
        height: 161,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          image: DecorationImage(
            image: NetworkImage(globals.urlSignUp +
                reiterate.prototypeAllImagesListOfStatusTwo[
                    reiterate.pageIndexNotesAndTimeLine]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildNotesArea(BuildContext context) {
    return reiterate.noteUploaded == true
        ? Center(
            child: Container(
              height: 148,
              width: 302,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffd4d4d4)),
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    reiterate.notesController.text.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
        : Center(
                child: Container(
                  width: 302,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reiterate.addNotes,
                        style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        )),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 148,
                        width: 302,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffd4d4d4)),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35, right: 35),
                          child: new TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            focusNode: reiterate.notesFocus,
                            maxLines: 4,
                            controller: reiterate.notesController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            validator: (val) {
                              if (val.isEmpty) {
                                return hint.bioValidation;
                              }
                              return null;
                            },
                            onEditingComplete: () {
                              reiterate.notesFocus.unfocus();
                              uploadPrototypeNote(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }

  Widget buildTimeLineArea(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);
    return Center(
      child: Container(
        width: 302,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reiterate.addTimeLine,
              style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                fontSize: 18,
                color: Colors.black,
              )),
            ),
            SizedBox(
              height: 25,
            ),
            Stack(
              children: [
                Container(
                  height: 352,
                  width: 302,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffd4d4d4)),
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Container(
                            height: 130,
                            width: 256,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffd4d4d4)),
                                borderRadius: BorderRadius.all(Radius.circular(7))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                maxLines: 4,
                                controller: reiterate.taskLineController,
                                decoration: InputDecoration(
                                  hintText: hint.addTask,
                                  border: InputBorder.none,
                                ),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return hint.bioValidation;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                       /* Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Theme(
                              data: ThemeData(primaryColor: Color(0xff787cd1)),
                              child: SearchableDropdown.single(
                                  items: teamBySprints
                                              .teamMemberNamesBySprintsList2 ==
                                          null
                                      ? []
                                      : teamBySprints.teamMemberNamesBySprintsList2
                                          .map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(
                                              value[1] == "0" ||
                                                      value[1] == "1" ||
                                                      value[1] == "2" ||
                                                      value[1] == "3" ||
                                                      value[1] == "4" ||
                                                      value[1] == "5" ||
                                                      value[1] == "6" ||
                                                      value[1] == "7" ||
                                                      value[1] == "8" ||
                                                      value[1] == "9"
                                                  ? value.substring(2)
                                                  : value.substring(1),
                                            ),
                                          );
                                        }).toList(),
                                  value: selectedTeamMember == null
                                      ? "Select member"
                                      : selectedTeamMember,
                                  hint: "Select member",
                                  searchHint: "Select member",
                                  clearIcon: Icon(null),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value[1] == "0" ||
                                          value[1] == "1" ||
                                          value[1] == "2" ||
                                          value[1] == "3" ||
                                          value[1] == "4" ||
                                          value[1] == "5" ||
                                          value[1] == "6" ||
                                          value[1] == "7" ||
                                          value[1] == "8" ||
                                          value[1] == "9") {
                                        teamBySprints.selectedTeamMemberIdForTasks =
                                            value[0] + value[1];
                                      } else {
                                        teamBySprints.selectedTeamMemberIdForTasks =
                                            value[0];
                                      }
                                      if (value[1] == "0" ||
                                          value[1] == "1" ||
                                          value[1] == "2" ||
                                          value[1] == "3" ||
                                          value[1] == "4" ||
                                          value[1] == "5" ||
                                          value[1] == "6" ||
                                          value[1] == "7" ||
                                          value[1] == "8" ||
                                          value[1] == "9") {
                                        selectedTeamMemberName =
                                            value.toString().substring(2);
                                      } else {
                                        selectedTeamMemberName =
                                            value.toString().substring(1);
                                      }
                                      print(selectedTeamMemberName);
                                    });
                                    print(
                                        teamBySprints.selectedTeamMemberIdForTasks);
//                                setState(() {
//                                  //teamBySprints.selectedTeamMemberIdForTasks = teamBySprints.teamMemberIdsBySprintsList2[index];
//                                });
//                                //print(teamBySprints.selectedTeamMemberIdForTasks);
                                  },
                                  isExpanded: true),
                              */
                        /*
                              TextFormField(
                                autofocus:false ,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                maxLines: 1,
                                controller: reiterate.teamMemberController,
                                decoration: InputDecoration(
                                  hintText: hint.choseTeamMember,
                                ),
                                validator: (val){
                                  if(val.isEmpty){
                                    return hint.bioValidation;
                                  }
                                  return null;
                                },
                              ),

                               *//*
                            ),
                          ),
                        ),*/

                        sprintType.toString() == "Solo" ? Container() :
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                          child: Container(
                            width: double.infinity,
                            child: DropdownButton<String>(
                              value: _currentSelectedValue,
                              style: GoogleFonts.nunitoSans(
                                color: Colors.grey.shade600,
                                fontSize: 15,
                              ),
                              isDense: true,
                              hint: Text("Choose team member"),
                              onChanged:
                                  (String newValue) {
                                setState(() {
                                  _currentSelectedValue =
                                      newValue;
                                  reiterate.teamMemberController.text = newValue.toString();
                                  // state.didChange(
                                  //     newValue);
                                });
                                print(
                                    _currentSelectedValue);
                              },
                              // dropdownColor:
                              // Color(COLOR_ACCENT),
                              items: providerListener.membersList.map((MembersListParser value) {
                                return DropdownMenuItem<
                                    String>(
                                  value: value.teamMemberName ?? "",
                                  child: Container(
                                    //color: Color(COLOR_ACCENT),
                                    child: Text(
                                      value.teamMemberName ?? "",
                                      style: GoogleFonts
                                          .nunitoSans(
                                          color: Colors
                                              .black,),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        /*Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            autofocus:false ,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            maxLines: 1,
                            controller: reiterate.teamMemberController,
                            decoration: InputDecoration(
                              hintText: "Team member email",//hint.choseTeamMember,
                            ),
                            validator: (val){
                              if(val.isEmpty){
                                return hint.bioValidation;
                              }
                              return null;
                            },
                          ),
                        ),*/


                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Theme(
                              data: ThemeData(primaryColor: Color(0xff787cd1)),
                              child: InkWell(
                                onTap: () => _selectDate(context),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: Text(
                                          teamBySprints.dateForSending == ""
                                              ? "Choose due date"
                                              : teamBySprints.dateForSending
                                                  .toString()
                                                  .substring(0, 10),
                                          style: GoogleFonts.nunitoSans(
                                            color: Colors.grey.shade600,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 312, right: 30),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {

                        if(sprintType.toString() == "Solo"){
                          if(reiterate.taskLineController.text.isEmpty || teamBySprints.dateForSending == "" || teamBySprints.dateForSending == null){
                            Fluttertoast.showToast(msg: 'All fields are mandatory',backgroundColor: Colors.black, textColor: Colors.white);
                          }else{
                            reIterateApiProvider
                                .uploadPrototypeTaksAndTimeLine(context)
                                .whenComplete(() {
                              setState(() {


                                reiterate.uploadedTaskList.add(reiterate.taskLineController.text);
                                print(reiterate.uploadedTaskList.toList());

                                reiterate.uploadedTaskListNames.add(reiterate.teamMemberController.text.toString());
                                print(reiterate.uploadedTaskListNames.toList());

                                reiterate.uploadedTeamMemberList
                                    .add(selectedTeamMemberName.toString());
                                print(reiterate.uploadedTeamMemberList.toList());

                                reiterate.uploadedDueDateList
                                    .add(teamBySprints.dateForSending.toString());
                                print(reiterate.uploadedDueDateList.toList());

                                reiterate.taskLineController.clear();
                              });
                            });
                          }
                        }else{
                          if(reiterate.taskLineController.text.isEmpty || teamBySprints.dateForSending == "" || teamBySprints.dateForSending == null || _currentSelectedValue == null){
                            Fluttertoast.showToast(msg: 'All fields are mandatory',backgroundColor: Colors.black, textColor: Colors.white);
                          }else{
                            reIterateApiProvider
                                .uploadPrototypeTaksAndTimeLine(context)
                                .whenComplete(() {
                              setState(() {


                                reiterate.uploadedTaskList.add(reiterate.taskLineController.text);
                                print(reiterate.uploadedTaskList.toList());

                                reiterate.uploadedTaskListNames.add(reiterate.teamMemberController.text.toString());
                                print(reiterate.uploadedTaskListNames.toList());

                                reiterate.uploadedTeamMemberList
                                    .add(selectedTeamMemberName.toString());
                                print(reiterate.uploadedTeamMemberList.toList());

                                reiterate.uploadedDueDateList
                                    .add(teamBySprints.dateForSending.toString());
                                print(reiterate.uploadedDueDateList.toList());

                                reiterate.taskLineController.clear();
                              });
                            });
                          }
                        }
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.nunitoSans(color: Color(0xff787CD1)),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildTimelineListViewBuiler(BuildContext context) {
    return reiterate.uploadedTaskList == null
        ? Container()
        : ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: reiterate.uploadedTaskList == null
                ? 0
                : reiterate.uploadedTaskList.length,
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: Container(
                  width: 302,
                  height: 162,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffd4d4d4)),
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Task:",
                          style: GoogleFonts.nunitoSans(
                              textStyle: TextStyle(
                            color: Color(0xff787cd1),
                            fontSize: 14,
                          )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(//reiterate.uploadedTaskListNames
                          reiterate.uploadedTaskList[i],
                          style: GoogleFonts.nunitoSans(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )),
                        ),
                        sprintType.toString() == "Solo" ? Container() : SizedBox(
                          height: 10,
                        ),
                        sprintType.toString() == "Solo" ? Container() : Text(//reiterate.uploadedTaskListNames
                          "Assigned to : "+reiterate.uploadedTaskListNames[i],
                          style: GoogleFonts.nunitoSans(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reiterate.uploadedTeamMemberList[i]==null || reiterate.uploadedTeamMemberList[i]=="null"? Container(): Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.perm_identity,
                                  color: Colors.grey,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  reiterate.uploadedTeamMemberList[i],
                                  style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            reiterate.uploadedTeamMemberList[i]==null || reiterate.uploadedTeamMemberList[i]=="null"? Container():SizedBox(
                              width: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: Colors.grey,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  reiterate.uploadedDueDateList[i],
                                  style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget buildAddTaskWidget(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {

          if(sprintType.toString() == "Solo"){
            if(reiterate.taskLineController.text.isEmpty || teamBySprints.dateForSending == "" || teamBySprints.dateForSending == null){
              Fluttertoast.showToast(msg: 'All fields are mandatory',backgroundColor: Colors.black, textColor: Colors.white);
            }else{
              reIterateApiProvider
                  .uploadPrototypeTaksAndTimeLine(context)
                  .whenComplete(() {
                setState(() {


                  reiterate.uploadedTaskList.add(reiterate.taskLineController.text);
                  print(reiterate.uploadedTaskList.toList());

                  reiterate.uploadedTaskListNames.add(reiterate.teamMemberController.text.toString());
                  print(reiterate.uploadedTaskListNames.toList());

                  reiterate.uploadedTeamMemberList
                      .add(selectedTeamMemberName.toString());
                  print(reiterate.uploadedTeamMemberList.toList());

                  reiterate.uploadedDueDateList
                      .add(teamBySprints.dateForSending.toString());
                  print(reiterate.uploadedDueDateList.toList());

                  reiterate.taskLineController.clear();
                });
              });
            }
          }else{
            if(reiterate.taskLineController.text.isEmpty || teamBySprints.dateForSending == "" || teamBySprints.dateForSending == null || _currentSelectedValue == null){
              Fluttertoast.showToast(msg: 'All fields are mandatory',backgroundColor: Colors.black, textColor: Colors.white);
            }else{
              reIterateApiProvider
                  .uploadPrototypeTaksAndTimeLine(context)
                  .whenComplete(() {
                setState(() {


                  reiterate.uploadedTaskList.add(reiterate.taskLineController.text);
                  print(reiterate.uploadedTaskList.toList());

                  reiterate.uploadedTaskListNames.add(reiterate.teamMemberController.text.toString());
                  print(reiterate.uploadedTaskListNames.toList());

                  reiterate.uploadedTeamMemberList
                      .add(selectedTeamMemberName.toString());
                  print(reiterate.uploadedTeamMemberList.toList());

                  reiterate.uploadedDueDateList
                      .add(teamBySprints.dateForSending.toString());
                  print(reiterate.uploadedDueDateList.toList());

                  reiterate.taskLineController.clear();
                });
              });
            }
          }
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
              reiterate.addNewTask,
              style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                color: Color(0xff787CD1),
                fontSize: 14,
              )),
            )
          ],
        ),
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (reiterate.roadMapNotesList != null) {
            if (reiterate.uploadedTaskList != null) {
              if (reiterate.prototypeAllImagesIdsListOfStatusTwo.last ==
                  reiterate.prototypeAllImagesIdsListOfStatusTwo[
                      reiterate.pageIndexNotesAndTimeLine]) {
                print("Last index reached, You are a great man ever!");
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => RoadMapSprintWise((home.sprintID == null || home.sprintID == "null"
                        ? home.selectedSprintId
                        : home.sprintID)
                        .toString()),
                    transitionsBuilder: (c, anim, a2, child) =>
                        FadeTransition(opacity: anim, child: child),
                    transitionDuration: Duration(milliseconds: 300),
                  ),
                );
              } else {
                print("You are a loser bro, try again!");
                widget.controller.nextPage(
                    duration: Duration(seconds: 1), curve: Curves.easeIn);
              }
            } else {
              commonToast(context, "Please add task");
            }
        } else {
          commonToast(context, "Please add notes1");
        }
      },
      child: Center(
        child: Container(
          height: 45,
          width: 146,
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

  insertNotes() {
    setState(() {
      reiterate.noteUploaded = true;
      if (reiterate.pageIndexNotesAndTimeLine == 0) {
        reiterate.roadMapNotesList.add(reiterate.notesController.text);
        print(reiterate.roadMapNotesList.toList());
      } else if (reiterate.pageIndexNotesAndTimeLine == 1) {
        reiterate.roadMapNotesList1.add(reiterate.notesController.text);
        print(reiterate.roadMapNotesList1.toList());
      } else if (reiterate.pageIndexNotesAndTimeLine == 2) {
        reiterate.roadMapNotesList2.add(reiterate.notesController.text);
        print(reiterate.roadMapNotesList2.toList());
      } else if (reiterate.pageIndexNotesAndTimeLine == 3) {
        reiterate.roadMapNotesList3.add(reiterate.notesController.text);
        print(reiterate.roadMapNotesList3.toList());
      } else if (reiterate.pageIndexNotesAndTimeLine == 4) {
        reiterate.roadMapNotesList4.add(reiterate.notesController.text);
        print(reiterate.roadMapNotesList4.toList());
      } else if (reiterate.pageIndexNotesAndTimeLine == 5) {
        reiterate.roadMapNotesList5.add(reiterate.notesController.text);
        print(reiterate.roadMapNotesList5.toList());
      } else if (reiterate.pageIndexNotesAndTimeLine == 6) {
        reiterate.roadMapNotesList6.add(reiterate.notesController.text);
        print(reiterate.roadMapNotesList6.toList());
      } else if (reiterate.pageIndexNotesAndTimeLine == 7) {
        reiterate.roadMapNotesList7.add(reiterate.notesController.text);
        print(reiterate.roadMapNotesList7.toList());
      } else if (reiterate.pageIndexNotesAndTimeLine == 8) {
        reiterate.roadMapNotesList8.add(reiterate.notesController.text);
        print(reiterate.roadMapNotesList8.toList());
      } else if (reiterate.pageIndexNotesAndTimeLine == 9) {
        reiterate.roadMapNotesList9.add(reiterate.notesController.text);
        print(reiterate.roadMapNotesList9.toList());
      } else if (reiterate.pageIndexNotesAndTimeLine == 10) {
        reiterate.roadMapNotesList10.add(reiterate.notesController.text);
        print(reiterate.roadMapNotesList10.toList());
      }
    });
  }
}

var selectedTeamMember;
bool datePicked = false;
var selectedTeamMemberName;
