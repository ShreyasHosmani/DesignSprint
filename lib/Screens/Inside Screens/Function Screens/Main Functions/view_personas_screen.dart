import 'package:design_sprint/APIs/create_persona.dart';
import 'package:design_sprint/APIs/get_persona.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_paper_persona_details.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_single_persona_details.dart';
import 'package:flutter/material.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:design_sprint/utils/comments_data.dart' as comments;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:http/http.dart' as http;
import 'dart:convert';


final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ViewPersonas extends StatefulWidget {
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    empathize.personaNameList = "1";
    getPersonaAPIProvider.getPersonas(context).whenComplete((){
      Future.delayed(const Duration(seconds: 3), () {setState(() {});});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: ProfileDrawerCommon(),
      //bottomNavigationBar: buildCommentBottomBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25,),
            buildName2Widget(context),
            SizedBox(height: 51,),
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
        padding: const EdgeInsets.only(top: 20),
        child: Text(empathize.empathize,
          style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 35, top: 17),
        child: IconButton(
          onPressed: (){Navigator.of(context).pop();},
          icon: Icon(Icons.arrow_back_ios,size: 20, color: Colors.grey.shade700,),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 35, top: 20),
          child: IconButton(
            onPressed: _openEndDrawer,
            icon: Container(
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
            return CommentsPage0();
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
            child: Container(
              width: 303,
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
          ),
        ),
      ),
    );
  }

}

class CommentsPage0 extends StatefulWidget {
  @override
  _CommentsPage0State createState() => _CommentsPage0State();
}

class _CommentsPage0State extends State<CommentsPage0> {
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
                                  image: NetworkImage(globals.urlSignUp+comments.commentsProfilePicDigitlPersonaList[i]),
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
                                  Text(comments.commentsUserNameDigitalPersonaList[i],
                                    style: GoogleFonts.nunitoSans(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 0,),
                                  Text(comments.commentsDigitalPersonaList[i],
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
                            controller: comments.commentController0,
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
