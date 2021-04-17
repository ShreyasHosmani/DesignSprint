import 'package:design_sprint/APIs/create_persona.dart';
import 'package:design_sprint/APIs/get_persona.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/Personas/persona_digital_or_upload_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/Personas/persona_main_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_paper_persona_details.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_single_persona_details.dart';
import 'package:flutter/material.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shimmer/shimmer.dart';
import 'package:design_sprint/utils/comments_data.dart' as comments;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:http/http.dart' as http;
import 'dart:convert';

var selectedPersonaId;
var personaIds;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
ProgressDialog prDelete;

class ViewPersonas extends StatefulWidget {
  final dmID;
  ViewPersonas(this.dmID) : super();
  @override
  _ViewPersonasState createState() => _ViewPersonasState();
}

class _ViewPersonasState extends State<ViewPersonas> {
  GetPersonaAPIProvider getPersonaAPIProvider = GetPersonaAPIProvider();
  Future<String> addComments(context) async {

    //Status : 0-digital persona; 1-paper persona; 2-digital journey maps; 3-paper journey maps

    String url = globals.urlSignUp + "addcomments.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.selectedSprintId,
      "text" : comments.commentController0.text,
      "statuses" : "0",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      comments.responseArrayAddComments0 = jsonDecode(response.body);
      print(comments.responseArrayAddComments0);

      comments.responseArrayAddComments0Msg = comments.responseArrayAddComments0['message'].toString();
      print(comments.responseArrayAddComments0Msg);
      if(statusCode == 200){
        if(comments.responseArrayAddComments0Msg == "Added Data"){

          comments.commentController0.clear();
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
      "statuses" : "0",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      comments.responseArrayGetComments0 = jsonDecode(response.body);
      print(comments.responseArrayGetComments0);

      comments.responseArrayGetComments0Msg = comments.responseArrayGetComments0['message'].toString();
      print(comments.responseArrayGetComments0Msg);
      if(statusCode == 200){
        if(comments.responseArrayGetComments0Msg == "Comment Data Found"){

          setState(() {
            comments.commentsDigitalPersonaList = List.generate(comments.responseArrayGetComments0['data'].length, (i) => comments.responseArrayGetComments0['data'][i]['commentText'].toString());
            comments.commentsUserNameDigitalPersonaList = List.generate(comments.responseArrayGetComments0['data'].length, (i) => comments.responseArrayGetComments0['data'][i]['userFullname'].toString());
            comments.commentsProfilePicDigitlPersonaList = List.generate(comments.responseArrayGetComments0['data'].length, (i) => comments.responseArrayGetComments0['data'][i]['userProfilepic'].toString());
          });
          print(comments.commentsDigitalPersonaList.toList());
          print(comments.commentsUserNameDigitalPersonaList.toList());
          print(comments.commentsProfilePicDigitlPersonaList.toList());

        }else{

          setState(() {
            comments.commentsDigitalPersonaList = null;
          });

        }
      }
    });
  }
  Future<String> getPersonas(context) async {

    String url = globals.urlLogin + "getpersona.php";

    http.post(url, body: {

      "sprintID" : home.selectedSprintId,
      //"userID" : widget.dmID,//profile.userID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayGetPersonaPast = jsonDecode(response.body);
      print(empathize.responseArrayGetPersonaPast);

      empathize.responseArrayGetPersonaPastMsg = empathize.responseArrayGetPersonaPast['message'].toString();
      if(statusCode == 200){
        if(empathize.responseArrayGetPersonaPastMsg == "Profile Found"){

          setState(() {
            personaIds = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaID'].toString());
            empathize.personaNameList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaName'].toString());
            empathize.personaAgeList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaAge'].toString());
            empathize.personaLocationList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaLocation'].toString());
            empathize.personaEducationList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaEducation'].toString());
            empathize.personaJobList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaJob'].toString());
            empathize.personaBioList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaBio'].toString());
            empathize.personaGoalsList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaGoals'].toString());
            empathize.personaImagesList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaImage'] == null || empathize.responseArrayGetPersonaPast['data'][i]['personaImage'] == "null" ?  globals.urlSignUp+empathize.responseArrayGetPersonaPast['data'][i]['personadocImage'].toString() : globals.urlImage+empathize.responseArrayGetPersonaPast['data'][i]['personaImage'].toString().substring(6));
          });

          print(personaIds.toList());
          print(empathize.personaNameList.toList());
          print(empathize.personaAgeList.toList());
          print(empathize.personaLocationList.toList());
          print(empathize.personaEducationList.toList());
          print(empathize.personaJobList.toList());
          print(empathize.personaBioList.toList());
          print(empathize.personaGoalsList.toList());
          print(empathize.personaImagesList.toList());

        }else{

          setState(() {
            empathize.personaNameList = null;
          });

        }
      }
    });
  }
  Future<String> deletePersona(context) async {

    String url = globals.urlLogin + "deletepersona.php";

    http.post(url, body: {

      "personaID" : selectedPersonaId.toString(),
      //"userID" : widget.dmID,//profile.userID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayDelete = jsonDecode(response.body);
      print(responseArrayDelete);

      var responseArrayDeleteMsg = responseArrayDelete['message'].toString();
      if(statusCode == 200){
        if(responseArrayDeleteMsg == "Team deleted"){
          prDelete.hide().whenComplete((){
            Fluttertoast.showToast(msg: 'Persona deleted!',backgroundColor: Colors.black, textColor: Colors.white);
            getPersonas(context);
          });
        }else{
          prDelete.hide().whenComplete((){
            Fluttertoast.showToast(msg: 'Please check your network connection!',backgroundColor: Colors.black, textColor: Colors.white);
          });
        }
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    empathize.personaNameList = "1";
    selectedPersonaId = null;
    getPersonas(context);
  }
  @override
  Widget build(BuildContext context) {
    prDelete = ProgressDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: ProfileDrawerCommon(),
      bottomNavigationBar: buildCommentBottomBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            buildName2Widget(context),
            SizedBox(height: 25,),
            buildPersonsListViewBuilder(context),
          ],
        ),
      ),
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

  Widget buildCommentBottomBar(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => PersonaMainScreen(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        color: Color(0xff787cd1),
        child: Center(
          child: Text("Add Persona",
            style: GoogleFonts.nunitoSans(
              fontSize: 18,
              color: Colors.white,
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

  Widget buildName2Widget(BuildContext context){

    return Center(
      child: Text(empathize.personas,
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

  Widget buildPersonsListViewBuilder(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35),
      child: empathize.personaNameList == "1" ? ListView.builder(
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
        itemCount: empathize.personaNameList == null ? 0 : empathize.personaNameList.length,
        itemBuilder: (context, i) => InkWell(
          onTap: (){
            if(empathize.personaNameList[i] == "null"){
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => ViewPaperPersonaDetails(empathize.personaImagesList[i]),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }else{
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => ViewSinglePersonaDetails(empathize.personaNameList[i], empathize.personaImagesList[i],
                      empathize.personaAgeList[i], empathize.personaLocationList[i], empathize.personaEducationList[i], empathize.personaJobList[i],
                      empathize.personaBioList[i], empathize.personaGoalsList[i]),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Stack(
              children: [
                Container(
                  //width: 303,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    border: Border.all(color: Color(0xffEBEBEB)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 132,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(0), topLeft: Radius.circular(7),
                            bottomLeft: Radius.circular(7), bottomRight: Radius.circular(0),
                          ),
                          border: Border.all(color: Color(0xffEBEBEB)),
                          color: Color(0xff787cd1),
                          image: DecorationImage(
                            image: NetworkImage(empathize.personaImagesList[i]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 180,
                              child: Text(empathize.personaNameList[i] == "null" ? "Paper persona" : empathize.personaNameList[i],
                                maxLines: 2,
                                //textScaleFactor: 0.7,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  )
                                ),
                              ),
                            ),
                            SizedBox(height: 7,),
                            Container(
                              width: 180,
                              child: Text(empathize.personaJobList[i] == "null" ? "Paper persona : click to view" : "Working as a " + empathize.personaJobList[i],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                //textScaleFactor: 0.7,
                                style: GoogleFonts.nunitoSans(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff929292),
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0, bottom: 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: PopupMenuButton<String>(
                      onSelected: (val){
                        setState(() {
                          selectedPersonaId = personaIds[i].toString();
                        });
                        print(selectedPersonaId);
                        showAlertDialogDelete(context);
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
                        return {'Delete Persona'}.map((String choice) {
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
                  ),),
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
        Navigator.pop(context);
        prDelete.show();
        deletePersona(context);
      },

    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Persona"),
      content: Text("Are you sure that you want to delete this persona? By pressing delete you will delete this persona."),
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
