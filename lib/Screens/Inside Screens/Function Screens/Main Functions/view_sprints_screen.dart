import 'package:design_sprint/APIs/create_sprint.dart';
import 'package:design_sprint/APIs/delete_sprint.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/create_sprint_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/create_sprint_screen_two.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_sprint_inside_sections.dart';
import 'package:flutter/material.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
var decisionMakerIdsList;
var decisionMakerEmailsList;

var new1; var new2; var new3; var new4; var new5; var new6;

var sprintIdsList2; var sprintTitlesList2; var sprintStatusList2;
 var decisionMakerIdsList2; var decisionMakerEmailsList2;

 bool showScreen1 = false;
 bool showScreen2 = false;

class ViewSprints extends StatefulWidget {
  @override
  _ViewSprintsState createState() => _ViewSprintsState();
}

class _ViewSprintsState extends State<ViewSprints> {
  CreateSprintApiProvider createSprintApiProvider = CreateSprintApiProvider();
  DeleteSprintApiProvider deleteSprintApiProvider = DeleteSprintApiProvider();

  Future<String> getSprints(context) async {

    print(profile.email.toString());
    String url = globals.urlLogin + "getsprintbyuserid.php";

    http.post(url, body: {

      //"userID" : profile.userID,
      "userEmail" : profile.email.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      home.responseArrayGetSprints = jsonDecode(response.body);
      print(home.responseArrayGetSprints);

      home.responseArrayGetSprintsMsg = home.responseArrayGetSprints['message'].toString();
      if(statusCode == 200){
        if(home.responseArrayGetSprintsMsg == "Data Found"){

          setState(() {
            home.sprintIdsList = List.generate(home.responseArrayGetSprints['data'].length, (i) => home.responseArrayGetSprints['data'][i]['sprintID'].toString());
            home.sprintTitlesList = List.generate(home.responseArrayGetSprints['data'].length, (i) => home.responseArrayGetSprints['data'][i]['sprintName'].toString());
            home.sprintStatusList = List.generate(home.responseArrayGetSprints['data'].length, (i) => home.responseArrayGetSprints['data'][i]['sprintStatus'].toString());
            decisionMakerIdsList = List.generate(home.responseArrayGetSprints['data'].length, (i) => home.responseArrayGetSprints['data'][i]['sprintUserid'].toString());
            decisionMakerEmailsList = List.generate(home.responseArrayGetSprints['data'].length, (i) => home.responseArrayGetSprints['data'][i]['userEmail'].toString());

            new1 = home.sprintTitlesList.toList();
            new2 = home.sprintIdsList.toList();
            new3 = home.sprintStatusList.toList();
            new4 = decisionMakerIdsList.toList();
            new5 = decisionMakerEmailsList.toList();

            showScreen1 = true;

          });

          print(new1.toList()); //titles
          print(new2.toList()); //ids
          print(new3.toList()); //statusus
          print(new4.toList()); //dm ids
          print(new5.toList()); //dm emails

          print(home.sprintIdsList.toList());
          print(home.sprintTitlesList.toList());
          print(home.sprintStatusList.toList());
          print(decisionMakerIdsList.toList());
          print(decisionMakerEmailsList.toList());

        }else{

          setState(() {
            home.sprintIdsList = [];
            home.sprintTitlesList = [];
            home.sprintStatusList = [];

            showScreen1 = true;

          });

        }
      }
    });
  }

  Future<String> getSprintsByUserId(context) async {

    print(profile.email.toString());
    String url = globals.urlLogin + "getsprint.php";

    http.post(url, body: {

      "userID" : profile.userID,
      //"userEmail" : profile.email.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      var getSoloSprints = jsonDecode(response.body);
      print(getSoloSprints);

      var getSoloSprintsMsg = getSoloSprints['message'].toString();
      print(getSoloSprintsMsg);

      if(statusCode == 200){
        if(getSoloSprintsMsg == "Data Found"){

          setState(() {
            sprintIdsList2 = List.generate(getSoloSprints['data'].length, (i) => home.sprintIdsList.add(getSoloSprints['data'][i]['sprintID'].toString()));
            sprintTitlesList2 = List.generate(getSoloSprints['data'].length, (i) => home.sprintTitlesList.add(getSoloSprints['data'][i]['sprintName'].toString()));
            sprintStatusList2 = List.generate(getSoloSprints['data'].length, (i) => home.sprintStatusList.add(getSoloSprints['data'][i]['sprintStatus'].toString()));
            decisionMakerIdsList2 = List.generate(getSoloSprints['data'].length, (i) => decisionMakerIdsList.add(getSoloSprints['data'][i]['sprintUserid'].toString()));
            decisionMakerEmailsList2 = List.generate(getSoloSprints['data'].length, (i) => decisionMakerEmailsList.add(getSoloSprints['data'][i]['userEmail'].toString()));

//            sprintIdsList2.forEach((element) {
//
//              int idx = sprintIdsList2.indexOf(element);
//
//              home.sprintIdsList.toList().add(sprintIdsList2[idx]);
//              home.sprintTitlesList.toList().add(sprintTitlesList2[idx]);
//              home.sprintStatusList.toList().add(sprintStatusList2[idx]);
//              decisionMakerIdsList.toList().add(decisionMakerIdsList2[idx]);
//              decisionMakerEmailsList.toList().add(decisionMakerEmailsList2[idx]);
//
//            });

          });

          print(home.sprintIdsList.toList());
          print(home.sprintTitlesList.toList());
          print(home.sprintStatusList.toList());
          print(decisionMakerIdsList.toList());
          print(decisionMakerEmailsList.toList());

          setState(() {

            new1 = home.sprintTitlesList.toSet().toList();

            new1.forEach((element){

              int idx = home.sprintTitlesList.indexOf(element);

              new2.add(home.sprintIdsList[idx]);
              new3.add(home.sprintStatusList[idx]);
              new4.add(decisionMakerIdsList[idx]);
              new5.add(decisionMakerEmailsList[idx]);

              print("new2 list : "+ new2.toList().toString());

            });

            showScreen2 = true;

          });
          print(new1.toList()); //titles
          print(new2.toList()); //ids
          print(new3.toList()); //statusus
          print(new4.toList()); //dm ids
          print(new5.toList()); //dm emails

        }else{

          setState(() {
            new1 = null;
            sprintIdsList2 = null;
            sprintTitlesList2 = null;
            sprintStatusList2 = null;

            showScreen2 = true;
          });

        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      showScreen1 = false;
      showScreen2 = false;
      new1 = []; new2 = [];  new3 = [];  new4 = [];  new5 = [];  new6 = [];
      home.sprintIdsList = [];
      home.sprintTitlesList = [];
      home.sprintStatusList = [];
      decisionMakerIdsList = [];
      decisionMakerEmailsList = [];

      home.selectedSprintId = null;
      home.sprintID = null;
      //home.sprintTitlesList = "1";
    });
    getSprints(context);
    Future.delayed(const Duration(seconds: 3), () {
      getSprintsByUserId(context);
    });
    //getSprintsByUserId(context);
//    createSprintApiProvider.getSprints(context).whenComplete((){
//      Future.delayed(const Duration(seconds: 3), () {setState(() {});});
//    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: ProfileDrawerCommon(),
      body: showScreen1 == true && showScreen2 == true ? SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            buildName2Widget(context),
            SizedBox(height: 25,),
            buildSprintsListViewBuilder(context),
          ],
        ),
      ) : Center(child: CircularProgressIndicator()),
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

  Widget buildSprintsListViewBuilder(BuildContext context){

    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35),
      child: new1 == [] ? ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 2,
        itemBuilder: (context, i) => InkWell(
          onTap: (){

          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey.shade300,
              child: Container(
                width: 302,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  //color: Color(0xff96C3CB),
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ),
      ) : ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: new1 == null ? 0 : new1.length,
        itemBuilder: (context, i) => new1 == null ? Center(child: Text("You've not created any sprints yet.")) :
//        (i>0 && new1.toList()[i].toString() == new1.toList()[i-1].toString()) ? Container()
//          :
        InkWell(
          onTap: (){
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => ViewSprintInsideSections(new2.reversed.toList()[i],new4.reversed.toList()[i], new5.reversed.toList()[i]),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 21),
            child: Stack(
              children: [
                Center(
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
                              child: Text(new1.reversed.toList()[i],
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
                            child: Text(new3.reversed.toList()[i] == "0" ? "Completed" : "Ongoing",
                              style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new4[i] == profile.userID ? Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white,size: 20,),
                      onPressed: (){
                        if(new4[i] == profile.userID){
                          print("i am a decision maker");
                        }else{
                          print("i am not a decision maker");
                        }
                        setState(() {
                          home.selectedSprintIdForDeleting = new2.reversed.toList()[i];
                        });
                        print(home.selectedSprintIdForDeleting);
                        showAlertDialogDelete(context);
                      },
                    ),
                  ),
                ) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialogDelete(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () async {
        Navigator.of(context).pop();
        deleteSprintApiProvider.deleteSprintFromSprints(context).whenComplete((){
          Future.delayed(const Duration(seconds: 3), () {
            createSprintApiProvider.getSprints(context).whenComplete((){
              Fluttertoast.showToast(msg: "removing...", backgroundColor: Colors.black,
                textColor: Colors.white,);
              Future.delayed(const Duration(seconds: 3), () {setState(() {});});
            });
          });
        });
      },

    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Sprint"),
      content: Text("Are you sure that you want to delete this sprint? By pressing delete you will delete this sprint."),
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
