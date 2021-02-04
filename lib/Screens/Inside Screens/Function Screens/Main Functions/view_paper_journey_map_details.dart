import 'package:design_sprint/APIs/get_pain_points.dart';
import 'package:design_sprint/APIs/get_warehouse_journeymap_data.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:shimmer/shimmer.dart';
import 'package:design_sprint/utils/warehouse_journey_map_data.dart' as journeyMapWH;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/comments_data.dart' as comments;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ViewPaperJourneyMapDetails extends StatefulWidget {
  final mapId;
  final imageLink;
  ViewPaperJourneyMapDetails(this.mapId, this.imageLink) : super();
  @override
  _ViewPaperJourneyMapDetailsState createState() => _ViewPaperJourneyMapDetailsState();
}

class _ViewPaperJourneyMapDetailsState extends State<ViewPaperJourneyMapDetails> {
  GetPainPointsApiProvider getPainPointsApiProvider = GetPainPointsApiProvider();
  Future<String> addComments(context) async {

    //Status : 0-digital persona; 1-paper persona; 2-digital journey maps; 3-paper journey maps

    String url = globals.urlSignUp + "addcomments.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.selectedSprintId,
      "text" : comments.commentController3.text,
      "statuses" : "3",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      comments.responseArrayAddComments3 = jsonDecode(response.body);
      print(comments.responseArrayAddComments3);

      comments.responseArrayAddComments3Msg = comments.responseArrayAddComments3['message'].toString();
      print(comments.responseArrayAddComments3Msg);
      if(statusCode == 200){
        if(comments.responseArrayAddComments3Msg == "Added Data"){

          comments.commentController3.clear();
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
      "statuses" : "3",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      comments.responseArrayGetComments3 = jsonDecode(response.body);
      print(comments.responseArrayGetComments3);

      comments.responseArrayGetComments3Msg = comments.responseArrayGetComments3['message'].toString();
      print(comments.responseArrayGetComments3Msg);
      if(statusCode == 200){
        if(comments.responseArrayGetComments3Msg == "Comment Data Found"){

          setState(() {
            comments.commentsPaperMapList = List.generate(comments.responseArrayGetComments3['data'].length, (i) => comments.responseArrayGetComments3['data'][i]['commentText'].toString());
            comments.commentsUserNamePaperMapList = List.generate(comments.responseArrayGetComments3['data'].length, (i) => comments.responseArrayGetComments3['data'][i]['userFullname'].toString());
            comments.commentsProfilePicPaperMapList = List.generate(comments.responseArrayGetComments3['data'].length, (i) => comments.responseArrayGetComments3['data'][i]['userProfilepic'].toString());
          });
          print(comments.commentsPaperMapList.toList());
          print(comments.commentsUserNamePaperMapList.toList());
          print(comments.commentsProfilePicPaperMapList.toList());

        }else{

          setState(() {
            comments.commentsPaperMapList = null;
          });

        }
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments(context);
    setState(() {
      journeyMapWH.selectedWareHouseMapId = widget.mapId.toString();
    });
    print(home.selectedSprintId);
    getPainPointsApiProvider.getPainPoints(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: ProfileDrawerCommon(),
      bottomNavigationBar: buildCommentBottomBar(context),
      body: Stack(
        children: [
//          SingleChildScrollView(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: [
//                SizedBox(height: 10,),
//                buildName2Widget(context),
//                SizedBox(height: 20,),
//                buildJourneyMapImageContainer(context),
//              ],
//            ),
//          ),
          Positioned(
            top: 10, left: 0, right: 0,
            child: buildName2Widget(context),
          ),
          Center(child: buildJourneyMapImageContainer(context)),
        ],
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
            return CommentsPage3();
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
      child: Text(empathize.journeyMaps,
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

  Widget buildJourneyMapImageContainer(BuildContext context){
    return GestureDetector(
      onTap: (){
        launch(globals.urlSignUp+widget.imageLink);
      },
      child: Container(
        height: 261,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xff787cd1),
        ),
        child: Image.network(globals.urlSignUp+widget.imageLink),
      ),
    );
  }

}

class CommentsPage3 extends StatefulWidget {
  @override
  _CommentsPage3State createState() => _CommentsPage3State();
}

class _CommentsPage3State extends State<CommentsPage3> {
  Future<String> addComments(context) async {

    //Status : 0-digital persona; 1-paper persona; 2-digital journey maps; 3-paper journey maps

    String url = globals.urlSignUp + "addcomments.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.selectedSprintId,
      "text" : comments.commentController3.text,
      "statuses" : "3",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      comments.responseArrayAddComments3 = jsonDecode(response.body);
      print(comments.responseArrayAddComments3);

      comments.responseArrayAddComments3Msg = comments.responseArrayAddComments3['message'].toString();
      print(comments.responseArrayAddComments3Msg);
      if(statusCode == 200){
        if(comments.responseArrayAddComments3Msg == "Added Data"){

          comments.commentController3.clear();
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
      "statuses" : "3",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      comments.responseArrayGetComments3 = jsonDecode(response.body);
      print(comments.responseArrayGetComments3);

      comments.responseArrayGetComments3Msg = comments.responseArrayGetComments3['message'].toString();
      print(comments.responseArrayGetComments3Msg);
      if(statusCode == 200){
        if(comments.responseArrayGetComments3Msg == "Comment Data Found"){

          setState(() {
            comments.commentsPaperMapList = List.generate(comments.responseArrayGetComments3['data'].length, (i) => comments.responseArrayGetComments3['data'][i]['commentText'].toString());
            comments.commentsUserNamePaperMapList = List.generate(comments.responseArrayGetComments3['data'].length, (i) => comments.responseArrayGetComments3['data'][i]['userFullname'].toString());
            comments.commentsProfilePicPaperMapList = List.generate(comments.responseArrayGetComments3['data'].length, (i) => comments.responseArrayGetComments3['data'][i]['userProfilepic'].toString());
          });
          print(comments.commentsPaperMapList.toList());
          print(comments.commentsUserNamePaperMapList.toList());
          print(comments.commentsProfilePicPaperMapList.toList());

        }else{

          setState(() {
            comments.commentsPaperMapList = null;
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
                    itemCount: comments.commentsPaperMapList == null ? 0 : comments.commentsPaperMapList.length,
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
                                  image: NetworkImage(globals.urlSignUp+comments.commentsProfilePicPaperMapList[i]),
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
                                  Text(comments.commentsUserNamePaperMapList[i],
                                    style: GoogleFonts.nunitoSans(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 0,),
                                  Text(comments.commentsPaperMapList[i],
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
                            controller: comments.commentController3,
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
