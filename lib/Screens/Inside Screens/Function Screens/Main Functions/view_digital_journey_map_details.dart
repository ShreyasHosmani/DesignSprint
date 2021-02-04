import 'package:design_sprint/APIs/create_journey_map.dart';
import 'package:design_sprint/APIs/get_warehouse_journeymap_data.dart';
import 'package:design_sprint/APIs/input_pain_point.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/EmpathizeScreens/emphatize_inside_sections_scree3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/warehouse_journey_map_data.dart' as journeyMapWH;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/comments_data.dart' as comments;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:http/http.dart' as http;
import 'dart:convert';

var touchPointsList;
var customerThoughtsList;
var customerExperiencesList;
var painPointsList;

class ViewDigitalJourneyMapDetails extends StatefulWidget {
  final mapId;
  ViewDigitalJourneyMapDetails(this.mapId) : super();
  @override
  _ViewDigitalJourneyMapDetailsState createState() => _ViewDigitalJourneyMapDetailsState();
}

class _ViewDigitalJourneyMapDetailsState extends State<ViewDigitalJourneyMapDetails> {
  InputPainPointsApiProvider inputPainPointsApiProvider = InputPainPointsApiProvider();
  CreateJourneyApiProvider createJourneyApiProvider = CreateJourneyApiProvider();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GetWareHouseJourneyMapDataApiProvider getWareHouseJourneyMapDataApiProvider = GetWareHouseJourneyMapDataApiProvider();
  Future<String> addComments(context) async {

    //Status : 0-digital persona; 1-paper persona; 2-digital journey maps; 3-paper journey maps

    String url = globals.urlSignUp + "addcomments.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.selectedSprintId,
      "text" : comments.commentController2.text,
      "statuses" : "2",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      comments.responseArrayAddComments2 = jsonDecode(response.body);
      print(comments.responseArrayAddComments2);

      comments.responseArrayAddComments2Msg = comments.responseArrayAddComments2['message'].toString();
      print(comments.responseArrayAddComments2Msg);
      if(statusCode == 200){
        if(comments.responseArrayAddComments2Msg == "Added Data"){

          comments.commentController2.clear();
          getComments(context);

        }else{



        }
      }
    });
  }
  Future<String> getComments(context) async {

    //Status : 0-digital persona; 1-paper persona; 2-digital journey maps; 3-paper journey maps

    String url = globals.urlSignUp + "getcomments.php";

    http.post(url, body: {

      "sprintID": home.selectedSprintId,
      "statuses" : "2",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      comments.responseArrayGetComments2 = jsonDecode(response.body);
      print(comments.responseArrayGetComments2);

      comments.responseArrayGetComments2Msg = comments.responseArrayGetComments2['message'].toString();
      print(comments.responseArrayGetComments2Msg);
      if(statusCode == 200){
        if(comments.responseArrayGetComments2Msg == "Comment Data Found"){

          setState(() {
            comments.commentsDigitalMapList = List.generate(comments.responseArrayGetComments2['data'].length, (i) => comments.responseArrayGetComments2['data'][i]['commentText'].toString());
            comments.commentsUserNameDigitalMapList = List.generate(comments.responseArrayGetComments2['data'].length, (i) => comments.responseArrayGetComments2['data'][i]['userFullname'].toString());
            comments.commentsProfilePicDigitalMapList = List.generate(comments.responseArrayGetComments2['data'].length, (i) => comments.responseArrayGetComments2['data'][i]['userProfilepic'].toString());
          });
          print(comments.commentsDigitalMapList.toList());
          print(comments.commentsUserNameDigitalMapList.toList());
          print(comments.commentsProfilePicDigitalMapList.toList());

        }else{

          setState(() {
            comments.commentsDigitalMapList = null;
          });

        }
      }
    });
  }
  Future<String> getTouchPoints(context) async {

    String url = globals.urlSignUp + "gettouchpointbymapid.php";

    http.post(url, body: {

      "mapID": widget.mapId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayGetTouchPoints = jsonDecode(response.body);
      print(responseArrayGetTouchPoints);

      var responseArrayGetTouchPointsMsg = responseArrayGetTouchPoints['message'].toString();
      print(responseArrayGetTouchPointsMsg);
      if(statusCode == 200){
        if(responseArrayGetTouchPointsMsg == "Touch Point Data Found"){

          setState(() {
            touchPointsList = List.generate(responseArrayGetTouchPoints['data'].length, (i) => responseArrayGetTouchPoints['data'][i]['tpText'].toString());
          });
          print(touchPointsList.toList());

        }else{

          setState(() {
            touchPointsList = null;
          });

        }
      }
    });
  }
  Future<String> getCustomerThoughts(context) async {

    String url = globals.urlSignUp + "getcustomerthoughtsbymapid.php";

    http.post(url, body: {

      "mapID": widget.mapId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayGetCustomerThoughts = jsonDecode(response.body);
      print(responseArrayGetCustomerThoughts);

      var responseArrayGetCustomerThoughtsMsg = responseArrayGetCustomerThoughts['message'].toString();
      print(responseArrayGetCustomerThoughtsMsg);
      if(statusCode == 200){
        if(responseArrayGetCustomerThoughtsMsg == "Touch Point Data Found"){

          setState(() {
            customerThoughtsList = List.generate(responseArrayGetCustomerThoughts['data'].length, (i) => responseArrayGetCustomerThoughts['data'][i]['ctText'].toString());
          });
          print(customerThoughtsList.toList());

        }else{

          setState(() {
            customerThoughtsList = null;
          });

        }
      }
    });
  }
  Future<String> getCustomerExperiences(context) async {

    String url = globals.urlSignUp + "getcustomerexperiencebymapid.php";

    http.post(url, body: {

      "mapID": widget.mapId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayGetCustomerExperience = jsonDecode(response.body);
      print(responseArrayGetCustomerExperience);

      var responseArrayGetCustomerExperienceMsg = responseArrayGetCustomerExperience['message'].toString();
      print(responseArrayGetCustomerExperienceMsg);
      if(statusCode == 200){
        if(responseArrayGetCustomerExperienceMsg == "Touch Point Data Found"){

          setState(() {
            customerExperiencesList = List.generate(responseArrayGetCustomerExperience['data'].length, (i) => responseArrayGetCustomerExperience['data'][i]['cxText'].toString());
          });
          print(customerExperiencesList.toList());

        }else{

          setState(() {
            customerExperiencesList = null;
          });

        }
      }
    });
  }
  Future<String> getPainPointsDJM(context) async {

    String url = globals.urlSignUp + "getpainpointbymapid.php";

    http.post(url, body: {

      "mapID": widget.mapId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayGetPainPointDJM = jsonDecode(response.body);
      print(responseArrayGetPainPointDJM);

      var responseArrayGetPainPointDJMMsg = responseArrayGetPainPointDJM['message'].toString();
      print(responseArrayGetPainPointDJMMsg);
      if(statusCode == 200){
        if(responseArrayGetPainPointDJMMsg == "Touch Point Data Found"){

          setState(() {
            painPointsList = List.generate(responseArrayGetPainPointDJM['data'].length, (i) => responseArrayGetPainPointDJM['data'][i]['ppName'].toString());
          });
          print(painPointsList.toList());

        }else{

          setState(() {
            painPointsList = null;
          });

        }
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTouchPoints(context);
    getCustomerThoughts(context);
    getCustomerExperiences(context);
    getPainPointsDJM(context);
    touchPointIdListStorage = ['x', 'x', 'x', 'x', 'x'];
    customerThoughtIdListStorage = ['x', 'x', 'x', 'x', 'x'];
    customerExperienceIdListStorage = ['x', 'x', 'x', 'x', 'x'];
    painPointIdListStorage = ['x', 'x', 'x', 'x', 'x'];
    _controllerListTouchPoints = List.generate(5, (i) => TextEditingController());
    _controllerListCustomerThoughts = List.generate(5, (i) => TextEditingController());
    _controllerListPainPoints = List.generate(5, (i) => TextEditingController());
    emojiList1 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList2 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList3 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList4 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList5 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    boolEmojis1 = [false,false,false,false,false,false,false,false,];
    boolEmojis2 = [false,false,false,false,false,false,false,false,];
    boolEmojis3 = [false,false,false,false,false,false,false,false,];
    boolEmojis4 = [false,false,false,false,false,false,false,false,];
    boolEmojis5 = [false,false,false,false,false,false,false,false,];
    focusNodesTouchPoints = List.generate(5, (i) => FocusNode());
    focusEnableTouchPoints = [false,false,false,false,false];
    focusNodesCustomerThoughts = List.generate(5, (i) => FocusNode());
    focusEnableCustomerThoughts = [false,false,false,false,false];
    focusNodesCustomerExperience = List.generate(5, (i) => FocusNode());
    focusEnableCustomerExperience = [false,false,false,false,false];
    focusNodesPainPoint = List.generate(5, (i) => FocusNode());
    focusEnablePainPoint = [false,false,false,false,false];
    touchPointsList = null;
    customerThoughtsList = null;
    customerExperiencesList = null;
    painPointsList = null;
  }
  @override
  Widget build(BuildContext context) {
    return touchPointsList == null || customerThoughtsList == null || customerExperiencesList == null || painPointsList == null ? Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ) : Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: statusDrawer == true ? buildStatusDrawer(context) : ProfileDrawerCommon(),
      bottomNavigationBar: buildCommentBottomBar(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Center(child: buildName2Widget(context))),
            SizedBox(height: 35,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35, right: 0),
                        child: buildTouchPointRow(context),
                      ),
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.only(left: 35, right: 0),
                        child: buildCustomerThoughtsRow(context),
                      ),
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.only(left: 35, right: 0),
                        child: buildCustomerExperienceRow(context),
                      ),
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.only(left: 35, right: 0),
                        child: buildPainPointsRow(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
//            Padding(
//              padding: const EdgeInsets.only(left: 35, right: 0),
//              child: buildTouchPointRow(context),
//            ),
//            SizedBox(height: 30,),
//            Padding(
//              padding: const EdgeInsets.only(left: 35, right: 0),
//              child: buildCustomerThoughtsRow(context),
//            ),
//            SizedBox(height: 30,),
//            Padding(
//              padding: const EdgeInsets.only(left: 35, right: 0),
//              child: buildCustomerExperienceRow(context),
//            ),
//            SizedBox(height: 30,),
//            Padding(
//              padding: const EdgeInsets.only(left: 35, right: 0),
//              child: buildPainPointsRow(context),
//            ),
            SizedBox(height: 40,),
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
          onPressed: (){
            Navigator.of(context).pop();
          },
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

  Widget buildCommentBottomBar(BuildContext context){
    return InkWell(
      onTap: (){
        showGeneralDialog(
          barrierLabel: "Label",
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 400),
          context: context,
          pageBuilder: (context, anim1, anim2) {
            Future<String> getComments2(context) async {

              //Status : 0-digital persona; 1-paper persona; 2-digital journey maps; 3-paper journey maps

              String url = globals.urlSignUp + "getcomments.php";

              http.post(url, body: {

                "sprintID": home.selectedSprintId,
                "statuses" : "1",

              }).then((http.Response response) async {
                final int statusCode = response.statusCode;

                if (statusCode < 200 || statusCode > 400 || json == null) {
                  throw new Exception("Error fetching data");
                }

                comments.responseArrayGetComments1 = jsonDecode(response.body);
                print(comments.responseArrayGetComments1);

                comments.responseArrayGetComments1Msg = comments.responseArrayGetComments1['message'].toString();
                print(comments.responseArrayGetComments1Msg);
                if(statusCode == 200){
                  if(comments.responseArrayGetComments1Msg == "Comment Data Found"){

                    setState(() {
                      comments.commentsPaperPersonaList = List.generate(comments.responseArrayGetComments1['data'].length, (i) => comments.responseArrayGetComments1['data'][i]['commentText'].toString());
                      comments.commentsUserNamePaperPersonaList = List.generate(comments.responseArrayGetComments1['data'].length, (i) => comments.responseArrayGetComments1['data'][i]['userFullname'].toString());
                      comments.commentsProfilePicPaperPersonaList = List.generate(comments.responseArrayGetComments1['data'].length, (i) => comments.responseArrayGetComments1['data'][i]['userProfilepic'].toString());
                    });
                    print(comments.commentsPaperPersonaList.toList());
                    print(comments.commentsUserNamePaperPersonaList.toList());
                    print(comments.commentsProfilePicPaperPersonaList.toList());

                  }else{

                    setState(() {
                      comments.commentsPaperPersonaList = null;
                    });

                  }
                }
              });
            }
            return CommentsPage2();
          },
          transitionBuilder: (context, anim1, anim2, child) {
            return SlideTransition(
              position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
              child: child,
            );
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        color: Colors.grey.shade300,
        child: Center(
          child: Text("Comments",
            style: GoogleFonts.nunitoSans(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
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

  Widget statusBarDrawer(BuildContext context){
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
              )
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
      child: Text(empathize.journeyMapping,
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

  Widget buildTouchPointRow(BuildContext context){
    return Container(
      height: 95,
      child: Container(
        height: 95,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Container(
                height: 95,
                width: 127,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(empathize.touchPoints,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          color: Color(0xff787cd1),
                          fontSize: 20,
                        )
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: touchPointsList == null ? 0 : touchPointsList.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Container(
                    height: 95,
                    width: 254,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(touchPointsList[i]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomerThoughtsRow(BuildContext context){
    return Container(
      height: 95,
      child: Container(
        height: 95,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Container(
                height: 95,
                width: 127,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(empathize.customerThoughts,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          color: Color(0xff787cd1),
                          fontSize: 20,
                        )
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: customerThoughtsList == null ? 0 : customerThoughtsList.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Container(
                    height: 95,
                    width: 254,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(customerThoughtsList[i]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomerExperienceRow(BuildContext context){
    return Container(
      height: 95,
      child: Container(
        height: 95,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Container(
                height: 95,
                width: 127,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(empathize.customerExperience,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          color: Color(0xff787cd1),
                          fontSize: 20,
                        )
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: customerExperiencesList == null ? 0 : customerExperiencesList.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Container(
                    height: 95,
                    width: 254,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(customerExperiencesList[i]),
                    ),
                  ),
                ),
      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPainPointsRow(BuildContext context){
    return Container(
      height: 95,
      child: Container(
        height: 95,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Container(
                height: 95,
                width: 127,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(empathize.painPoints,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          color: Color(0xff787cd1),
                          fontSize: 20,
                        )
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: painPointsList == null ? 0 : painPointsList.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Container(
                    height: 95,
                    width: 254,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(painPointsList[i]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class CommentsPage2 extends StatefulWidget {
  @override
  _CommentsPage2State createState() => _CommentsPage2State();
}

class _CommentsPage2State extends State<CommentsPage2> {
  Future<String> addComments(context) async {

    //Status : 0-digital persona; 1-paper persona; 2-digital journey maps; 3-paper journey maps

    String url = globals.urlSignUp + "addcomments.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.selectedSprintId,
      "text" : comments.commentController2.text,
      "statuses" : "2",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      comments.responseArrayAddComments1 = jsonDecode(response.body);
      print(comments.responseArrayAddComments1);

      comments.responseArrayAddComments1Msg = comments.responseArrayAddComments1['message'].toString();
      print(comments.responseArrayAddComments1Msg);
      if(statusCode == 200){
        if(comments.responseArrayAddComments1Msg == "Added Data"){

          comments.commentController2.clear();
          getComments(context);

        }else{



        }
      }
    });
  }
  Future<String> getComments(context) async {

    //Status : 0-digital persona; 1-paper persona; 2-digital journey maps; 3-paper journey maps

    String url = globals.urlSignUp + "getcomments.php";

    http.post(url, body: {

      "sprintID": home.selectedSprintId,
      "statuses" : "2",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      comments.responseArrayGetComments1 = jsonDecode(response.body);
      print(comments.responseArrayGetComments1);

      comments.responseArrayGetComments1Msg = comments.responseArrayGetComments1['message'].toString();
      print(comments.responseArrayGetComments1Msg);
      if(statusCode == 200){
        if(comments.responseArrayGetComments1Msg == "Comment Data Found"){

          setState(() {
            comments.commentsPaperPersonaList = List.generate(comments.responseArrayGetComments1['data'].length, (i) => comments.responseArrayGetComments1['data'][i]['commentText'].toString());
            comments.commentsUserNamePaperPersonaList = List.generate(comments.responseArrayGetComments1['data'].length, (i) => comments.responseArrayGetComments1['data'][i]['userFullname'].toString());
            comments.commentsProfilePicPaperPersonaList = List.generate(comments.responseArrayGetComments1['data'].length, (i) => comments.responseArrayGetComments1['data'][i]['userProfilepic'].toString());
          });
          print(comments.commentsPaperPersonaList.toList());
          print(comments.commentsUserNamePaperPersonaList.toList());
          print(comments.commentsProfilePicPaperPersonaList.toList());

        }else{

          setState(() {
            comments.commentsPaperPersonaList = null;
          });

        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            backgroundColor: Colors.grey.shade200,
            centerTitle: true,
            leading: null,
            title: Text("Comments",
              style: GoogleFonts.nunitoSans(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: comments.commentsPaperPersonaList == null ? 0 : comments.commentsPaperPersonaList.length,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                image: DecorationImage(
                                  image: NetworkImage(globals.urlSignUp+comments.commentsProfilePicPaperPersonaList[i]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(comments.commentsUserNamePaperPersonaList[i],
                                    style: GoogleFonts.nunitoSans(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 0,),
                                  Text(comments.commentsPaperPersonaList[i],
                                    maxLines: 10,
                                    style: GoogleFonts.nunitoSans(
                                        textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade200,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      profile.profilePicImage == null || profile.profilePicImage == "null" ? Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Color(0xff787cd1),
                        ),
                      ) : Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          image: DecorationImage(
                            image: NetworkImage(globals.urlSignUp+profile.profilePicImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        height: 45,
                        width: 250,
                        child: Theme(
                          data: ThemeData(
                            primaryColor: Color(0xff787cd1),
                          ),
                          child: TextFormField(
                            controller: comments.commentController2,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: 'Enter comment',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        child: IconButton(
                          onPressed: (){
                            addComments(context).whenComplete((){
                              Future.delayed(const Duration(seconds: 3), () {
                                getComments(context);
                              });
                            });
                          },
                          icon: Icon(Icons.send),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<TextEditingController> _controllerListTouchPoints = List.generate(5, (i) => TextEditingController());
List<TextEditingController> _controllerListCustomerThoughts = List.generate(5, (i) => TextEditingController());
List<TextEditingController> _controllerListPainPoints = List.generate(5, (i) => TextEditingController());

List<FocusNode> focusNodesTouchPoints = List.generate(5, (i) => FocusNode());
List<bool> focusEnableTouchPoints = [false,false,false,false,false];
List<FocusNode> focusNodesCustomerThoughts = List.generate(5, (i) => FocusNode());
List<bool> focusEnableCustomerThoughts = [false,false,false,false,false];
List<FocusNode> focusNodesCustomerExperience = List.generate(5, (i) => FocusNode());
List<bool> focusEnableCustomerExperience = [false,false,false,false,false];
List<FocusNode> focusNodesPainPoint = List.generate(5, (i) => FocusNode());
List<bool> focusEnablePainPoint = [false,false,false,false,false];

var selectedEmoji;
List<String> emojiList1 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList2 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList3 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList4 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList5 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<bool> boolEmojis1 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis2 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis3 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis4 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis5 = [false,false,false,false,false,false,false,false,];


List<String> touchPointIdListStorage;
List<String> customerThoughtIdListStorage;
List<String> customerExperienceIdListStorage;
List<String> painPointIdListStorage;