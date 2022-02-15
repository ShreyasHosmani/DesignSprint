import 'dart:io';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/APIs/create_journey_map.dart';
import 'package:design_sprint/APIs/create_persona.dart';
import 'package:design_sprint/APIs/get_pain_points.dart';
import 'package:design_sprint/APIs/input_pain_point.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_team.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/EmpathizeScreens/emphatize_inside_sections_scree3.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:shared_preferences/shared_preferences.dart';

bool statusDrawer = false;
bool showSecondStep = false;
bool showPainPoint = false;

var teamMemberStatuses;
var sprintCreatorId;

class UploadJourneyMap extends StatefulWidget {
  @override
  _UploadJourneyMapState createState() => _UploadJourneyMapState();
}

class _UploadJourneyMapState extends State<UploadJourneyMap> {


  bool _isVisible = true;

  final GlobalKey<ScaffoldState> _scaffoldKey22 = GlobalKey<ScaffoldState>();
  InputPainPointsApiProvider inputPainPointsApiProvider = InputPainPointsApiProvider();
  CreatePersonaApiProvider createPersonaApiProvider = CreatePersonaApiProvider();
  CreateJourneyApiProvider createJourneyApiProvider = CreateJourneyApiProvider();
  GetPainPointsApiProvider getPainPointsApiProvider = GetPainPointsApiProvider();

  Future<String> getJourneyMapDetails(context) async {

    String url = globals.urlSignUp + "getjourneymap.php";

    http.post(url, body: {

      "sprintID": home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayGetJourneyMap = jsonDecode(response.body);
      print(empathize.responseArrayGetJourneyMap);

      empathize.responseArrayGetJourneyMapMsg = empathize.responseArrayGetJourneyMap['message'].toString();
      print(empathize.responseArrayGetJourneyMapMsg);
      if(statusCode == 200){
        if(empathize.responseArrayGetJourneyMapMsg == "Data Found"){

          setState(() {
            empathize.journeyMapImageNamesList = List.generate(empathize.responseArrayGetJourneyMap['data'].length, (i) => empathize.responseArrayGetJourneyMap['data'][i]['jpdocImage'] == null || empathize.responseArrayGetJourneyMap['data'][i]['jpdocImage'] == "null" ? "Digital Journey Map" : "https://admin.dezyit.com/mobileapp/"+empathize.responseArrayGetJourneyMap['data'][i]['jpdocImage'].toString().substring(6));
          });

          print(empathize.journeyMapImageNamesList.toList());

        }else{

          setState(() {
            empathize.journeyMapImageNamesList = null;
          });

        }
      }
    });
  }

  Future<String> getSprintsStatusesOfTeam(context) async {

    setState(() {
      _isVisible = false;
    });
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
            teamMemberStatuses = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep3'].toString());
            sprintCreatorId = responseArrayGetSprintStatuses['data'][0]['sprintUserid'].toString();
            _isVisible = true;
          });

          print(teamMemberStatuses);
          print(sprintCreatorId);

        }else{

          setState(() {
            _isVisible = true;
          });

        }
      }
    });
  }

  Future<String> getSprintsStatusesOfTeam2(context) async {

    String url = globals.urlLogin + "getsprintstatusdata.php";

    print("home.selectedSprintId : "+home.selectedSprintId.toString());
    print("home.sprintId : "+home.sprintID.toString());

    http.post(url, body: {

      "sprintID" : home.sprintID.toString() == null || home.sprintID.toString() == "null" ? home.selectedSprintId.toString() : home.sprintID.toString(),

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

          empathize.prInputPainPoint.hide();
          setState(() {
            teamMemberStatuses = List.generate(responseArrayGetSprintStatuses['data'].length, (index) => responseArrayGetSprintStatuses['data'][index]['sprintstatusStep3'].toString());
            sprintCreatorId = responseArrayGetSprintStatuses['data'][0]['sprintUserid'].toString();
          });

          if(teamMemberStatuses.toList().contains('0')){
            Fluttertoast.showToast(msg: 'Please wait until rest of the team uploads the pain points!',
              backgroundColor: Colors.black, textColor: Colors.white,
            );
          }else{
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => EmphatizeInsideSections3(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          }

          print(teamMemberStatuses);
          print(sprintCreatorId);

        }else{

          empathize.prInputPainPoint.hide();
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => EmphatizeInsideSections3(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
          setState(() {

          });

        }
      }
    });
  }

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
                        getImageOne();
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
                        getImageOneGallery();
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJourneyMapDetails(context);
    //createJourneyApiProvider.getJourneyMapDetails(context);
    getPainPointsApiProvider.getPainPoints(context);
    getSprintsStatusesOfTeam(context);
    ppListStatic = [];
    empathize.imagePaperJourneyMap = null;
    empathize.painPointsList = null;
    empathize.fileNamePaperJourneyMap = "";
    statusDrawer = false;
    showSecondStep = false;
    showPainPoint = false;
  }
  final picker = ImagePicker();
  Future getImageOne() async {

    Navigator.of(context).pop();
   /* var pickedFile =*/ await picker.getImage(source: ImageSource.camera, imageQuality: 25,).then((value) {
      setState(() {
        empathize.imagePaperJourneyMap = File(value.path);
        _isVisible = false;
      });
    });


    createJourneyApiProvider.uploadPaperJourneyMap(context).whenComplete((){
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          getSprintsStatusesOfTeam(context);
          getJourneyMapDetails(context).whenComplete((){

            Future.delayed(const Duration(seconds: 3), () {setState(() {
              _isVisible = true;
            });});
            if(empathize.imagePaperJourneyMap == null){

            }else{
              showSecondStep = true;
            }
          });
        });
      });
    });
  }
  Future getImageOneGallery() async {
    Navigator.of(context).pop();


    /*final pickedFile = */await picker.getImage(source: ImageSource.gallery, imageQuality: 25,).then((value) {
      setState(() {
        empathize.imagePaperJourneyMap = File(value.path);
        _isVisible = false;
      });
    });


    createJourneyApiProvider.uploadPaperJourneyMap(context).whenComplete((){
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          getSprintsStatusesOfTeam(context);
          getJourneyMapDetails(context).whenComplete((){
        /*    Fluttertoast.showToast(msg: "processing...", backgroundColor: Colors.black,
              textColor: Colors.white,gravity: ToastGravity.CENTER);*/
            Future.delayed(const Duration(seconds: 3), () {setState(() {
              _isVisible = true;
            });});
            if(empathize.imagePaperJourneyMap == null){

            }else{
              showSecondStep = true;
            }
          });
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    empathize.prInputPainPoint = ProgressDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey22,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: statusDrawer == true ? StatusDrawerTeam() : ProfileDrawerCommon(),
      bottomNavigationBar: Padding(
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
              children: [
                SizedBox(height: 10,),
                buildName2Widget(context),
                SizedBox(height: 25,),
                buildName3Widget(context),
                SizedBox(height: 43,),
                _isVisible == false ? Container() :  buildUploadButton(context),
                SizedBox(height: 25,),
                buildFileNameWidget(context),
                SizedBox(height: 25,),
                buildPainPointListView(context),
                showSecondStep == false && empathize.journeyMapImageNamesList == null ? Container(height: 1, width: 1,) :SizedBox(height: 25,),
                showSecondStep == false && empathize.journeyMapImageNamesList == null ? Container(height: 1, width: 1,) :buildName4Widget(context),
                showSecondStep == false && empathize.journeyMapImageNamesList == null ? Container(height: 1, width: 1,) :SizedBox(height: 25,),
                showSecondStep == false && empathize.journeyMapImageNamesList == null ? Container(height: 1, width: 1,) :buildPainPointTextFieldContainer(context),
                showSecondStep == false && empathize.journeyMapImageNamesList == null ? Container(height: 1, width: 1,) :SizedBox(height: 40,),
                showSecondStep == false && empathize.journeyMapImageNamesList == null ? Container(height: 1, width: 1,) :buildAddPainPointWidget(context),
                showSecondStep == false && empathize.journeyMapImageNamesList == null ? SizedBox(height: 162,) : SizedBox(height: 30,),
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
    void _openEndDrawer2() {
      setState(() {
        statusDrawer = false;
      });
      _scaffoldKey22.currentState.openEndDrawer();
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
          child: GestureDetector(
            onTap: _openEndDrawer2,
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
      _scaffoldKey22.currentState.openEndDrawer();
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
                      child: Divider(color: Color(0xffd4d4d4),),
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
                          border: Border.all(color: Color(0xffd4d4d4))
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(color: Color(0xffd4d4d4),),
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
                          border: Border.all(color: Color(0xffd4d4d4))
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(color: Color(0xffd4d4d4),),
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
                          border: Border.all(color: Color(0xffd4d4d4))
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(color: Color(0xffd4d4d4),),
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
                          border: Border.all(color: Color(0xffd4d4d4))
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(color: Color(0xffd4d4d4),),
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
                          border: Border.all(color: Color(0xffd4d4d4))
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(color: Color(0xffd4d4d4),),
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
                          border: Border.all(color: Color(0xffd4d4d4))
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(color: Color(0xffd4d4d4),),
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
      child: Text(empathize.paperJourneyMapHint1,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
            )
        ),
      ),
    );
  }

  Widget buildUploadButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _settingModalBottomSheetOne(context);
        /*
        showGeneralDialog(
          barrierLabel: "Label",
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 400),
          context: context,
          pageBuilder: (context, anim1, anim2) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 195,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          getImageOneGallery();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 44,
                                height: 44,
                                child: Image.asset("assets/images/photo.png")),
                            SizedBox(height: 8.97,),
                            Text(empathize.gallery,
                              style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          getImageOne();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 44,
                                height: 44,
                                child: Image.asset("assets/images/folder.png")),
                            SizedBox(height: 8.97,),
                            Text(empathize.fileManager,
                              style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                      color: Colors.white,
                                  ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff707070),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            );
          },
          transitionBuilder: (context, anim1, anim2, child) {
            return SlideTransition(
              position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
              child: child,
            );
          },
        );

         */
//        Navigator.push(
//          context,
//          PageRouteBuilder(
//            pageBuilder: (c, a1, a2) => PersonaMainScreen(),
//            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
//            transitionDuration: Duration(milliseconds: 300),
//          ),
//        );
      },
      child: Center(
        child: Container(
          height: 37,
          width: 166,
          decoration: BoxDecoration(
              border: Border.all(color :Color(0xff302B70),width: 2),
              borderRadius: BorderRadius.all(Radius.circular(19))
          ),
          child: Center(
            child: Text(empathize.upload,
              style: TextStyle(
                  color: Color(0xff302B70), letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFileNameWidget(BuildContext context) {
    return empathize.journeyMapImageNamesList == null
        ? Container()
        : Container(
      height: 200,
      child: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: empathize.journeyMapImageNamesList == null
            ? 0
            : empathize.journeyMapImageNamesList.length,
        itemBuilder: (context, i) => empathize
            .journeyMapImageNamesList[i] ==
            "Digital Journey Map" ? Container() : Center(
          child: InkWell(
            onTap: () {
              if (empathize.journeyMapImageNamesList[i] == null ||
                  empathize.journeyMapImageNamesList[i] == "Digital Journey Map") {
              } else {
                launch(empathize.journeyMapImageNamesList[i]);
              }
            },
            child: Padding(
                padding:
                const EdgeInsets.only(bottom: 2, left: 10, right: 10),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.grey),
                      image: DecorationImage(
                          image: NetworkImage(empathize
                              .journeyMapImageNamesList[i] ==
                              "Digital Journey Map"
                              ? "https://admin.dezyit.com/assets/media/favicons/favicon.png"
                              : empathize.journeyMapImageNamesList[i]),
                          fit: BoxFit.fill,
                          scale: 5)),
                )

//            Text(empathize.journeyMapImageNamesList[i] == null || empathize.journeyMapImageNamesList[i] == "null" ? ("Digital Journey Map"+(i+1).toString()) : empathize.journeyMapImageNamesList[i],
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

  /*Widget buildFileNameWidget(BuildContext context){

    return empathize.journeyMapImageNamesList == null ? Container() : Container(
      height: 50,
      child: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: empathize.journeyMapImageNamesList == null ? 0 : empathize.journeyMapImageNamesList.length,
        itemBuilder: (context, i) => empathize.journeyMapImageNamesList[i].toString() == "Digital Journey Map" ? Container() : Center(
          child: InkWell(
            onTap: (){

              print("empathize.journeyMapImageNamesList[i].toString() : "+empathize.journeyMapImageNamesList[i].toString());

              if(empathize.journeyMapImageNamesList[i].toString() == "Digital Journey Map"){
                print("If loop");
              }else{
                print("else loop");
                launch(empathize.journeyMapImageNamesList[i]);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2, left: 10, right: 10),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                        image: NetworkImage(empathize.journeyMapImageNamesList[i].toString() == "Digital Journey Map" ? "https://admin.dezyit.com/assets/media/favicons/favicon.png" : empathize.journeyMapImageNamesList[i]),
                        fit: BoxFit.cover, scale: 5
                    )
                ),
              )

//            Text(empathize.journeyMapImageNamesList[i] == null || empathize.journeyMapImageNamesList[i] == "null" ? ("Digital Journey Map"+(i+1).toString()) : empathize.journeyMapImageNamesList[i],
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


  }*/

  Widget buildName4Widget(BuildContext context){

    return Center(
      child: Text(empathize.paperPersonaHint2,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
            )
        ),
      ),
    );
  }

  Widget buildPainPointListView(BuildContext context){
    return ppListStatic == null ? Container() : ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: ppListStatic == null || ppListStatic.isEmpty ? 0 : ppListStatic.length,
      itemBuilder: (context, i) => Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, bottom: 2),
        child: Card(
          elevation: 2,
          child: Container(
            width: 302,
            height: 105.54,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,),
                child: Text(ppListStatic[i],
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPainPointTextFieldContainer(BuildContext context){
    return Card(
      elevation: 5,
      child: Container(
        width: 302,
        height: 105.54,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Form(
            //key: empathize.formKey3,
            child: Column(
              children: [
                TextFormField(
                  controller: empathize.painPointController,
                  focusNode: focus,
                  decoration: InputDecoration(
                    hintText: 'Type your painpoint',
                    border: InputBorder.none,
                  ),
                ),
                Divider(color: Color(0xff787CD1),height: 2,),
                SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        empathize.painPointController.clear();
                      },
                      child: Text("Cancel",
                        style: GoogleFonts.nunitoSans(
                          color: Color(0xff787CD1)
                        ),
                      ),
                    ),
                    SizedBox(width: 36,),
                    GestureDetector(
                      onTap: (){
                        focus.unfocus();
                        setState(() {
                          showPainPoint = true;
                        });
                        setState(() {

                        });
                        if(empathize.painPointController.text.isNotEmpty){
                          empathize.prInputPainPoint.show();
                          inputPainPointsApiProvider.inputPainPoints(context).whenComplete((){
                            setState(() {
                              ppListStatic.add(empathize.painPointController.text);
                            });
                            print(ppListStatic.toList());
                          });
                        }else{
                          Fluttertoast.showToast(msg: "Please upload atleast one pain point",
                            backgroundColor: Colors.black, textColor: Colors.white
                          );
                        }
                      },
                      child: Text("Done",
                        style: GoogleFonts.nunitoSans(
                            color: Color(0xff787CD1)
                        ),
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

  Widget buildAddPainPointWidget(BuildContext context){
    return GestureDetector(
      onTap: (){
        if(empathize.formKey3.currentState.validate()){
          empathize.prInputPainPoint.show();
          inputPainPointsApiProvider.inputPainPoints(context).whenComplete((){
            setState(() {
              ppListStatic.add(empathize.painPointController.text);
            });
            print(ppListStatic.toList());
          });
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
            child: Icon(Icons.add, color: Colors.white,),
          ),
          SizedBox(height: 10,),
          Text("Add Pain Point",
            style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                color: Color(0xff787CD1),
                fontSize: 14,
              )
            ),
          )
        ],
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return _isVisible == true
        ? GestureDetector(
      onTap: (){

        print("home.sprintId : "+home.sprintID.toString());
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => EmphatizeInsideSections3(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
        //if(home.sprintID)

        // if(ppListStatic == null || ppListStatic.isEmpty){
        //   Fluttertoast.showToast(msg: 'Please upload atleast one pain point!',
        //     backgroundColor: Colors.black, textColor: Colors.white,gravity: ToastGravity.CENTER
        //   );
        // }else{
        //   empathize.prInputPainPoint.show();
        //   getSprintsStatusesOfTeam2(context);
        // }
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
    ): Center(
      child: Container(
        height: 45,
        width: 146,
        decoration: BoxDecoration(
            color: Color(0xff7579cb),
            borderRadius: BorderRadius.all(Radius.circular(7))),
        child: Center(
          child: Text(
            "Loading...",
            style: TextStyle(
                color: Colors.white, letterSpacing: 1, fontSize: 16),
          ),
        ),
      ),
    );
  }

}

List<String> ppListStatic;
FocusNode focus = FocusNode();