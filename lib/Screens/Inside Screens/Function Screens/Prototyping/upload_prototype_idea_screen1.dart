import 'dart:io';
import 'package:design_sprint/APIs/get_pain_points.dart';
import 'package:design_sprint/APIs/upload_idea_image.dart';
import 'package:design_sprint/APIs/upload_prototype_images.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_ideation.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/design_sprint_sections_screen4.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/prototyping_data.dart' as prototyping;
import 'package:design_sprint/utils/ideation_data.dart' as ideation;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/prototyping_data.dart' as prototype;
import 'package:design_sprint/utils/ideation_data.dart' as ideation;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

bool statusDrawer = false;
bool showImages = false;

class UploadPrototypeImagesPageViewBuilder extends StatefulWidget {
  @override
  _UploadPrototypeImagesPageViewBuilderState createState() =>
      _UploadPrototypeImagesPageViewBuilderState();
}

class _UploadPrototypeImagesPageViewBuilderState
    extends State<UploadPrototypeImagesPageViewBuilder> {
  final controller = PageController(viewportFraction: 1);
  GetPainPointsApiProvider getPainPointsApiProvider =
      GetPainPointsApiProvider();

  bool _isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prototyping.pageIndex = 0;
    getPainPointsApiProvider
        .getPainPointsForPrototyping(context)
        .whenComplete(() {
      Future.delayed(const Duration(seconds: 3), () {
        print("aaaaaaaaaaaaaa");
        print(prototyping.painPointsForPrototypingList);
        setState(() {
          _isLoaded = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoaded == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : prototyping.painPointsForPrototypingList == null
              ? Container()
              : PageView.builder(
                  physics: new NeverScrollableScrollPhysics(),
                  itemCount: prototyping.painPointsForPrototypingList == null
                      ? 0
                      : prototyping.painPointsForPrototypingList.length,
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      prototyping.pageIndex = index;
                    });
                    print(prototyping.pageIndex);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return UploadPrototype1(controller);
                  },
                ),
    );
  }
}

class UploadPrototype1 extends StatefulWidget {
  final controller;

  UploadPrototype1(this.controller) : super();

  @override
  _UploadPrototype1State createState() => _UploadPrototype1State();
}

class _UploadPrototype1State extends State<UploadPrototype1> {
  //UploadIdeaApiProvider uploadIdeaApiProvider = UploadIdeaApiProvider();
  PrototypeApiProvider prototypeApiProvider = PrototypeApiProvider();

  final picker = ImagePicker();

  Future getImageOne() async {
    Navigator.of(context).pop();
    var pickedFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );
    setState(() {
      prototyping.imageOne = File(pickedFile.path);
    });
  }

  Future getImageOneGallery() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    setState(() {
      prototyping.imageOne = File(pickedFile.path);
    });
  }

  Future<String> getPrototypeImagesPainPointWise(context) async {
    print("sprint id : " + home.sprintID.toString());
    print("sprint id 2 : " + home.selectedSprintId.toString());

    String url = globals.urlSignUp + "getprototypeimagespainpointwise.php";

    print(url);
    print(home.sprintID);
    http.post(url, body: {
      "sprintID": home.selectedSprintId,
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      prototype.responseArrayGetPrototypeImagesPainPointWise =
          jsonDecode(response.body);

      prototype.responseArrayGetPrototypeImagesPainPointWiseMsg = prototype
          .responseArrayGetPrototypeImagesPainPointWise['message']
          .toString();
      print(prototype.responseArrayGetPrototypeImagesPainPointWiseMsg);

      if (prototype.responseArrayGetPrototypeImagesPainPointWiseMsg ==
          "Painpoint Data Found") {
        prototype.prototypeImagesPPWiseList = List.generate(
            prototype
                .responseArrayGetPrototypeImagesPainPointWise['data'].length,
            (i) =>
                "https://admin.dezyit.com/mobileapp/" +
                prototype.responseArrayGetPrototypeImagesPainPointWise['data']
                        [i]['ptiImgpath']
                    .toString()
                    .substring(6));

        print(prototype.prototypeImagesPPWiseList.toList());
      } else {
        prototype.prototypeImagesPPWiseList = null;
      }
    });
  }

  void _settingModalBottomSheetOne(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
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
                      onTap: () {
                        getImageOne().then((value) {
                          prototypeApiProvider
                              .uploadPrototypeImage(context)
                              .then((value) {
                            if (prototyping.painPointsForPrototypingList.last ==
                                prototyping.painPointsForPrototypingList[
                                    prototyping.pageIndex]) {
                              print(
                                  "Last index reached, You are a great man ever!");
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) =>
                                      EmphatizeSections4(),
                                  transitionsBuilder: (c, anim, a2, child) =>
                                      FadeTransition(
                                          opacity: anim, child: child),
                                  transitionDuration:
                                      Duration(milliseconds: 300),
                                ),
                              );
                            } else {
                              print("You are a loser bro, try again!");
                              widget.controller.nextPage(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.easeIn);
                            }
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
                                child: Icon(
                              Icons.camera_alt,
                              color: Color(0xff7579cb),
                            )),
                          ),
                          Container(
                              width: 150,
                              child: Text(
                                "Open using camera",
                                style:
                                    GoogleFonts.nunitoSans(letterSpacing: 0.5),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: InkWell(
                      onTap: () {
                        getImageOneGallery().then((value) {
                          prototypeApiProvider
                              .uploadPrototypeImage(context)
                              .then((value) {
                            prototypeApiProvider
                                .uploadPrototypeImage(context)
                                .then((value) {
                              if (prototyping
                                      .painPointsForPrototypingList.last ==
                                  prototyping.painPointsForPrototypingList[
                                      prototyping.pageIndex]) {
                                print(
                                    "Last index reached, You are a great man ever!");
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) =>
                                        EmphatizeSections4(),
                                    transitionsBuilder: (c, anim, a2, child) =>
                                        FadeTransition(
                                            opacity: anim, child: child),
                                    transitionDuration:
                                        Duration(milliseconds: 300),
                                  ),
                                );
                              } else {
                                print("You are a loser bro, try again!");
                                widget.controller.nextPage(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeIn);
                              }
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
                                child: Icon(
                              Icons.image,
                              color: Color(0xff7579cb),
                            )),
                          ),
                          Container(
                              width: 150,
                              child: Text(
                                "Open using gallery",
                                style:
                                    GoogleFonts.nunitoSans(letterSpacing: 0.5),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<String> getIdeaImagesByStatus(context) async {
    print(home.sprintID == null || home.sprintID == "null"
        ? home.selectedSprintId
        : home.sprintID);

    String url = globals.urlSignUp + "getideaimagesbystatus.php";

    http.post(url, body: {
      "sprintID": home.sprintID == null || home.sprintID == "null"
          ? home.selectedSprintId
          : home.sprintID,
      "status": "2",
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ideation.responseArrayGetAllIdeaImagesByStatus =
          jsonDecode(response.body);
      print(ideation.responseArrayGetAllIdeaImagesByStatus);

      ideation.responseArrayGetAllIdeaImagesByStatusMsg =
          ideation.responseArrayGetAllIdeaImagesByStatus['message'].toString();
      print(ideation.responseArrayGetAllIdeaImagesByStatusMsg);

      if (ideation.responseArrayGetAllIdeaImagesByStatusMsg ==
          "Painpoint Data Found") {
        setState(() {
          ideation.ideaAllImagesOfStatusTwo = List.generate(
              ideation.responseArrayGetAllIdeaImagesByStatus['data'].length,
              (i) => ideation.responseArrayGetAllIdeaImagesByStatus['data'][i]
                      ['iiImgpath']
                  .toString());
        });

        print("**************");
        print(ideation.ideaAllImagesOfStatusTwo.toList());
      } else {
        setState(() {
          ideation.ideaAllImagesOfStatusTwo = null;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showImages = false;
    getIdeaImagesByStatus(context);
    setState(() {
      prototyping.imageOne = null;
      prototyping.selectedPainPointIdForUploadingPrototypeImage =
          prototyping.painPointIdsForPrototypingList[prototyping.pageIndex];
    });
    print(prototyping.selectedPainPointIdForUploadingPrototypeImage);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer:
          statusDrawer == true ? StatusDrawerIdeation() : ProfileDrawerCommon(),
     /* bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Container(height: 50, child: buildNextButton(context)),
      ),*/
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 52,
                ),
                buildName3Widget(context),
                SizedBox(
                  height: 20,
                ),
                buildLevelContainer(context),
                SizedBox(
                  height: 30,
                ),
                buildIdeaImageContainer(context),
                SizedBox(
                  height: 20,
                ),
                buildName4Widget(context),
                SizedBox(
                  height: 34,
                ),
                buildFileNameWidget(context),
                SizedBox(
                  height: 23,
                ),
                prototyping.imageOne == null
                    ? Container()
                    : Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffd4d4d4)),
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          image: DecorationImage(
                            image: FileImage(prototyping.imageOne),
                            fit: BoxFit.cover,
                          ),
                        ),
//      child: Center(
//        child: Image.file(empathize.imageOne, fit: BoxFit.cover,),
//      ),
                      ),
                SizedBox(
                  height: 20,
                ),
                buildUploadButton(context),
                SizedBox(
                  height: 23,
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 40,
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: statusBarDrawer(context),
            ),
          ),
        ],
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
          prototyping.title,
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

  Widget buildName3Widget(BuildContext context) {
    return Center(
      child: Text(
        prototyping.uploadPrototypeHint1,
        textAlign: TextAlign.center,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget buildLevelContainer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width / 5,
          left: MediaQuery.of(context).size.width / 5),
      child: Center(
        child: LinearPercentIndicator(
          lineHeight: 10,
          percent: (prototyping.pageIndex + 1) /
              prototyping.painPointsForPrototypingList.length,
          backgroundColor: Colors.grey.shade300,
          progressColor: Color(0xff787cd1),
        ),
      ),
    );
  }

  Widget buildNumberIndicator(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Color(0xff787cd1)),
      child: Center(
        child: Text(
          (prototyping.pageIndex + 1).toString(),
          style: GoogleFonts.nunitoSans(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget buildName4Widget(BuildContext context) {
    return Center(
      child: Text(
        prototyping.painPointsForPrototypingList[prototyping.pageIndex],
        textAlign: TextAlign.center,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget buildIdeaImageContainer(BuildContext context) {
    return Stack(
      children: [
        ideation.ideaAllImagesOfStatusTwo == null
            ? Container(
                height: 161,
                width: 302,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: Colors.grey),
                ),
              )
            : GestureDetector(
                onTap: () {
                  print(globals.urlSignUp +
                      ideation.ideaAllImagesOfStatusTwo[prototyping.pageIndex]);
                  launch(globals.urlSignUp +
                      ideation.ideaAllImagesOfStatusTwo[prototyping.pageIndex]);
                },
                child: Container(
                  height: 161,
                  width: 302,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                        image: NetworkImage(globals.urlSignUp +
                            ideation.ideaAllImagesOfStatusTwo[
                                prototyping.pageIndex]),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.only(left: 258, top: 15),
          child: buildNumberIndicator(context),
        ),
      ],
    );
  }

  Widget buildFileNameWidget(BuildContext context) {
    return prototyping.prototypeImagesPPWiseList == null
        ? Container()
        : Container(
            height: 50,
            child: ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: prototyping.prototypeImagesPPWiseList == null
                  ? 0
                  : prototyping.prototypeImagesPPWiseList.length,
              itemBuilder: (context, i) => Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 2, left: 10, right: 10),
                  child: InkWell(
                      onTap: () {
                        launch(globals.urlSignUp +prototyping.prototypeImagesPPWiseList[i]);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.grey),
                            image: DecorationImage(
                                image: NetworkImage(
                                    globals.urlSignUp +prototyping.prototypeImagesPPWiseList[i]),
                                fit: BoxFit.cover,
                                scale: 5)),
                      )

//            Text(prototyping.prototypeImagesPPWiseList[i],
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
      onTap: () {
        _settingModalBottomSheetOne(context);
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
              border: Border.all(color: Color(0xff787cd1), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(19))),
          child: Center(
            child: Text(
              "Upload",
              style: TextStyle(
                  color: Color(0xff787cd1), letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

 /* Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (prototyping.painPointsForPrototypingList.last ==
            prototyping.painPointsForPrototypingList[prototyping.pageIndex]) {
          print("Last index reached, You are a great man ever!");
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => EmphatizeSections4(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        } else {
          print("You are a loser bro, try again!");
          widget.controller
              .nextPage(duration: Duration(seconds: 1), curve: Curves.easeIn);
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
  }*/
}
