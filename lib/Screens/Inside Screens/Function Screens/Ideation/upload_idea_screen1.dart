import 'dart:io';
import 'package:design_sprint/APIs/upload_idea_image.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_empathize.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Ideation/ideation_inside_sections_screen2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/ideation_data.dart' as ideation;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/ideation_data.dart' as ideation;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

bool statusDrawer = false;
ProgressDialog prCheck;

var teamMemberStatuses;
var sprintCreatorId;

class UploadIdeaImagePageViewBuilder extends StatefulWidget {
  @override
  _UploadIdeaImagePageViewBuilderState createState() => _UploadIdeaImagePageViewBuilderState();
}

class _UploadIdeaImagePageViewBuilderState extends State<UploadIdeaImagePageViewBuilder> {
  final controller = PageController(viewportFraction: 1);
  @override
  void initState() {
    super.initState();
    ideation.pageIndexIdea = 0;
    print(ideation.pageIndexIdea);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ideation.painPointsOfStatus2List == null ? Center(
        child: CircularProgressIndicator(),
      ) : PageView.builder(
        physics:new NeverScrollableScrollPhysics(),
        itemCount: ideation.painPointsOfStatus2List == null ? 0 : ideation.painPointsOfStatus2List.length,
        controller: controller,
        onPageChanged: (index){
          setState(() {
            ideation.pageIndexIdea = index;
          });
          print(ideation.pageIndexIdea);
        },
        itemBuilder: (BuildContext context, int index) {
          return UploadIdea1(controller);
        },
      ),
    );
  }
}


class UploadIdea1 extends StatefulWidget {
  final controller;
  UploadIdea1(this.controller) : super();
  @override
  _UploadIdea1State createState() => _UploadIdea1State();
}

class _UploadIdea1State extends State<UploadIdea1> {
  UploadIdeaApiProvider uploadIdeaApiProvider = UploadIdeaApiProvider();
  final picker = ImagePicker();
  void _settingModalBottomSheetOne(context){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc){
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: InkWell(
                      onTap: (){
                        getImageOne().then((value){
                          uploadIdeaApiProvider.uploadIdeaImage(context);
                          Future.delayed(const Duration(seconds: 3), () {
                            getIdeaImages(context).whenComplete((){
                              Fluttertoast.showToast(msg: "Loading...", backgroundColor: Colors.black,
                                textColor: Colors.white,);
                              Future.delayed(const Duration(seconds: 3), () {setState(() {});});
                            });
                          });
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              //width: 100,
                                child: Icon(Icons.camera_alt, color: Color(0xff7579cb),)),
                          ),
                          Container(
                              width: 150,
                              child: Text("Open using camera",
                                style: GoogleFonts.nunitoSans(
                                    letterSpacing: 0.5
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: InkWell(
                      onTap: (){
                        getImageOneGallery().then((value){
                          uploadIdeaApiProvider.uploadIdeaImage(context);
                          Future.delayed(const Duration(seconds: 3), () {
                            getIdeaImages(context).whenComplete((){
                              Fluttertoast.showToast(msg: "Loading...", backgroundColor: Colors.black,
                                textColor: Colors.white,);
                              Future.delayed(const Duration(seconds: 3), () {setState(() {});});
                            });
                          });
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              //width: 100,
                                child: Icon(Icons.image, color: Color(0xff7579cb),)),
                          ),
                          Container(
                              width: 150,
                              child: Text("Open using gallery",
                                style: GoogleFonts.nunitoSans(
                                    letterSpacing: 0.5
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  Future getImageOne() async {
    Navigator.of(context).pop();
    var pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 25,);
    setState(() {
      ideation.imageOne = File(pickedFile.path);
    });
  }
  Future getImageOneGallery() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 25,);
    setState(() {
      ideation.imageOne = File(pickedFile.path);
    });
  }
  Future<String> getIdeaImages(context) async {

    String url = globals.urlSignUp + "getideaimagesbypainpoint.php";

    http.post(url, body: {

      "painpointID" : ideation.selectedPainPointIdForUploadIdeaImage.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ideation.responseArrayGetIdeaImages = jsonDecode(response.body);
      print(ideation.responseArrayGetIdeaImages);

      ideation.responseArrayGetIdeaImagesMsg = ideation.responseArrayGetIdeaImages['message'].toString();
      print(ideation.responseArrayGetIdeaImagesMsg);

      if(ideation.responseArrayGetIdeaImagesMsg == "Painpoint Data Found"){

        setState(() {
          ideation.showImagesIdea = true;
          ideation.ideaImagesPainPointWiseList = List.generate(ideation.responseArrayGetIdeaImages['data'].length, (i) => "https://admin.dezyit.com/mobileapp/"+ideation.responseArrayGetIdeaImages['data'][i]['iiImgpath'].toString().substring(6));
        });

        print(ideation.ideaImagesPainPointWiseList.toList());

      }else{

        setState(() {
          ideation.ideaImagesPainPointWiseList = null;
        });

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
            teamMemberStatuses = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep6'].toString());
            sprintCreatorId = responseArrayGetSprintStatuses['data'][0]['sprintUserid'].toString();
          });

          print(teamMemberStatuses);
          print(sprintCreatorId);

        }else{

          setState(() {
            teamMemberStatuses = ['1'];
          });

        }
      }
    });
  }

  Future<String> getSprintsStatusesOfTeam2(context) async {

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

          prCheck.hide();
          setState(() {
            teamMemberStatuses = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep6'].toString());
            sprintCreatorId = responseArrayGetSprintStatuses['data'][0]['sprintUserid'].toString();
          });

          print(teamMemberStatuses);
          print(sprintCreatorId);

          if(teamMemberStatuses.toList().contains('0')){
            Fluttertoast.showToast(msg: 'Please wait until rest of the team uploads idea images!',
              backgroundColor: Colors.black, textColor: Colors.white,
            );
          }else{
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => IdeationInsideSections2(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          }

        }else{

          prCheck.hide();
          setState(() {
            teamMemberStatuses = ['1'];
            sprintCreatorId = profile.userID.toString();
          });
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => IdeationInsideSections2(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );

        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    ideation.showImagesIdea = false;
    ideation.ideaImagesPainPointWiseList = null;
    ideation.selectedPainPointIdForUploadIdeaImage = ideation.painPointsIdsOfStatus2List[ideation.pageIndexIdea];
    print(ideation.selectedPainPointIdForUploadIdeaImage);
    getSprintsStatusesOfTeam(context);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        getIdeaImages(context).whenComplete((){
          Future.delayed(const Duration(seconds: 3), () {setState(() {});});
        });
      });
    });
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    prCheck = ProgressDialog(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: buildAppBar(context),
          endDrawerEnableOpenDragGesture: true,
          endDrawer: statusDrawer == true ? StatusDrawerEmpathize() : ProfileDrawerCommon(),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Container(
                height: 50,
                child: buildNextButton(context)),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                buildName2Widget(context),
                SizedBox(height: 35,),
                buildName3Widget(context),
                SizedBox(height: 35,),
                buildLevelContainer(context),
                SizedBox(height: 40,),
                buildNumberIndicator(context),
                SizedBox(height: 20,),
                buildName4Widget(context),
                SizedBox(height: 34,),
                buildUploadButton(context),
                SizedBox(height: 23,),
                buildFileNameWidget(context),
              ],
            ),
          ),
        ),
        Positioned(
          top: 80, right: 0,
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: statusBarDrawer(context),
          ),
        ),
      ],
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
      child: Text(ideation.card1,
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
      child: Text(ideation.uploadIdeaHint1,
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

  Widget buildLevelContainer(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/5, left: MediaQuery.of(context).size.width/5),
      child: Center(
        child: LinearPercentIndicator(
          lineHeight: 10,
          percent: (ideation.pageIndexIdea+1)/ideation.painPointsOfStatus2List.length,
          backgroundColor: Colors.grey.shade300,
          progressColor: Color(0xff787cd1),
        ),
      ),
    );
  }

  Widget buildNumberIndicator(BuildContext context){
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Color(0xff787cd1)
      ),
      child: Center(
        child: Text((ideation.pageIndexIdea+1).toString(),
          style: GoogleFonts.nunitoSans(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget buildName4Widget(BuildContext context){
    return Center(
      child: Text(ideation.painPointsOfStatus2List[ideation.pageIndexIdea],
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

  Widget buildFileNameWidget(BuildContext context){
    return ideation.ideaImagesPainPointWiseList == null ? Container() : Container(
      height: 50,
      child: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: ideation.ideaImagesPainPointWiseList == null ? 0 : ideation.ideaImagesPainPointWiseList.length,
        itemBuilder: (context, i) => Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2, left: 10, right: 10),
            child: InkWell(
              onTap: (){
                launch(ideation.ideaImagesPainPointWiseList[i]);
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                        image: NetworkImage(ideation.ideaImagesPainPointWiseList[i]),
                        fit: BoxFit.cover, scale: 5
                    )
                ),
              )

//            Text(ideation.ideaImagesPainPointWiseList[i],
//              textAlign: TextAlign.center,
//              style: GoogleFonts.nunitoSans(
//                  textStyle: TextStyle(
//                    fontSize: 12,
//                    fontWeight: FontWeight.w500,
//                    color: Colors.grey,
//                  )
//              ),
//            ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUploadButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          ideation.selectedPainPointIdForUploadIdeaImage = ideation.painPointsIdsOfStatus2List[ideation.pageIndexIdea];
        });
        print(ideation.selectedPainPointIdForUploadIdeaImage);
        _settingModalBottomSheetOne(context);

      },
      child: Center(
        child: Container(
          height: 37,
          width: 166,
          decoration: BoxDecoration(
              border: Border.all(color :Color(0xff787cd1),width: 2),
              borderRadius: BorderRadius.all(Radius.circular(19))
          ),
          child: Center(
            child: Text("Upload",
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
      onTap: (){
       if(ideation.ideaImagesPainPointWiseList == null){
         Fluttertoast.showToast(msg: "You must upload atleast one image", backgroundColor: Colors.black,
           textColor: Colors.white,);
       }else{
          if(ideation.painPointsOfStatus2List.last == ideation.painPointsOfStatus2List[ideation.pageIndexIdea]){
            /*  print("Last index reached, You are a great man ever!");
            prCheck.show();
            getSprintsStatusesOfTeam2(context);*/
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => IdeationInsideSections2(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          }else{
            print("You are a loser bro, try again!");
            widget.controller.nextPage(duration: Duration(seconds: 1), curve: Curves.easeIn);
          }
        }
      },
      child: Center(
        child: Container(
          height: 45,
          width: 146,
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
