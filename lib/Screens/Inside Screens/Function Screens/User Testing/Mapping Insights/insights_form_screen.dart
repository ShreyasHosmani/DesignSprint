import 'package:design_sprint/APIs/add_insights.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_prototype.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Re%20Iterate/congratulations_screenSolo.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Re%20Iterate/reiterate_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/User%20Testing/Mapping%20Insights/congratulations_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/user_testing_data.dart' as userTesting;
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/ideation_data.dart' as ideation;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:progress_dialog/progress_dialog.dart';


bool statusDrawer = false;
bool showSecondStep = false;
bool showPainPoint = false;
TextEditingController painPointController = new TextEditingController();
FocusNode focus = FocusNode();
var sprintCreatorId;
var sprintType;
ProgressDialog prAddInsights;

class InsightsForm extends StatefulWidget {
  @override
  _InsightsFormState createState() => _InsightsFormState();
}

class _InsightsFormState extends State<InsightsForm> {

  InsightsApiProvider insightsApiProvider = InsightsApiProvider();
   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  Future<String> updateStep10(context) async {

    String url = globals.urlSignUp + "updatesprintstatus.php";

    http.post(url, body: {

      "userID" : profile.email,
      "sprintID" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
      "stepID" : "10",

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
  Future<String> addInsights(context) async {

    String url = globals.urlSignUp + "createinsight.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
      "text" : userTesting.painPointController.text,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      userTesting.responseArrayAddInsights = jsonDecode(response.body);
      print(userTesting.responseArrayAddInsights);

      userTesting.responseArrayAddInsightsMsg = userTesting.responseArrayAddInsights['message'].toString();
      print(userTesting.responseArrayAddInsightsMsg);
      if(statusCode == 200){
        if(userTesting.responseArrayAddInsightsMsg == "Insights Added Successfully"){
          print("Insight saved");
          Fluttertoast.showToast(
            msg: "Insight saved",
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
          prAddInsights.hide();
          setState(() {
            userTesting.uploadedInsightsList.add(userTesting.painPointController.text);
          });
          print(userTesting.uploadedInsightsList.toList());
          userTesting.painPointController.clear();
          updateStep10(context);
        }else{
          Fluttertoast.showToast(
            msg: "Error, please try again!",
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
          prAddInsights.hide();
          print("error");
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      sprintCreatorId = null;
      sprintType = null;
    });
    getStoreData(context);
    userTesting.uploadedInsightsList = [];
    statusDrawer = false;
    showSecondStep = false;
    showPainPoint = false;
  }

  @override
  Widget build(BuildContext context) {
    prAddInsights = ProgressDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: statusDrawer == true
          ? StatusDrawerPrototyping()
          : ProfileDrawerCommon(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Container(height: 50, child: buildNextButton(context)),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                buildName2Widget(context),
                SizedBox(
                  height: 25,
                ),
                buildInsightsListViewBuilder(context),
                SizedBox(
                  height: 51,
                ),
                userTesting.uploadedInsightsList == null
                    ? Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: buildInsightTextFieldContainer(context))
                    : buildInsightTextFieldContainer(context),
                SizedBox(
                  height: 35,
                ),
                buildAddInsightButton(context),
                SizedBox(
                  height: 35,
                ),
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
          userTesting.title,
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
    return Center(
      child: Text(
        userTesting.insightsForm,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                color: Color(0xff707070),
                fontSize: 20,
                fontWeight: FontWeight.w200)),
      ),
    );
  }

  Widget buildInsightsListViewBuilder(BuildContext context) {
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: userTesting.uploadedInsightsList == null
          ? 0
          : userTesting.uploadedInsightsList.length,
      itemBuilder: (context, i) => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
        child: Card(
          elevation: 5,
          child: Container(
            width: 302,
            height: 105.54,
            child: Center(
              child: Text(
                userTesting.uploadedInsightsList[i],
                style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInsightTextFieldContainer(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: 302,
        height: 105.54,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Form(
            key: userTesting.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: userTesting.painPointController,
                  focusNode: focus,
                  decoration: InputDecoration(
                    hintText: userTesting.insightFormHint,
                    border: InputBorder.none,
                  ),
                ),
                Divider(
                  color: Color(0xff787CD1),
                  height: 2,
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          userTesting.painPointController.clear();
                        });
                      },
                      child: Text(
                        userTesting.cancel,
                        style: GoogleFonts.nunitoSans(color: Color(0xff787CD1)),
                      ),
                    ),
                    SizedBox(
                      width: 36,
                    ),
                    GestureDetector(
                      onTap: () {
                        focus.unfocus();
                        print("Length ::: "+userTesting.painPointController.text.length.toString());

                        if (userTesting.painPointController.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Insight cannot be empty!",
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                          );
                        } else {
                          if(userTesting.painPointController.text.replaceAll(' ', '').length == 0){
                            Fluttertoast.showToast(
                              msg: "Insight cannot be empty!",
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                            );
                          }else{
                            Fluttertoast.showToast(
                              msg: "Adding insight...",
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                            );
                            prAddInsights.show();
                            addInsights(context);
                          }
                        }

                      },
                      child: Text(
                        userTesting.done,
                        style: GoogleFonts.nunitoSans(color: Color(0xff787CD1)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAddInsightButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focus.unfocus();
        print("Length ::: "+userTesting.painPointController.text.length.toString());

        if (userTesting.painPointController.text.isEmpty) {
          Fluttertoast.showToast(
            msg: "Insight cannot be empty!",
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        } else {
          if(userTesting.painPointController.text.replaceAll(' ', '').length == 0){
            Fluttertoast.showToast(
              msg: "Insight cannot be empty!",
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );
          }else{
            Fluttertoast.showToast(
              msg: "Adding insight...",
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );
            prAddInsights.show();
            addInsights(context);
          }
        }

      },
      child: Center(
        child: Container(
          height: 37,
          width: 166,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xff787cd1), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(19))),
          child: Center(
            child: Text(
              userTesting.addInsight,
              style: TextStyle(
                  color: Color(0xff787cd1), letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(sprintType.toString() == "Collab" && sprintCreatorId.toString() != profile.userID.toString()){
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => CongratulationsSolor(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        }else{
          Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => ReIterateTutorial(),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
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
}
