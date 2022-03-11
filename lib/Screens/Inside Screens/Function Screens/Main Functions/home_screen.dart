import 'dart:io';
import 'package:design_sprint/APIs/create_sprint.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_home_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/team_data_and_manage_team2.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_sprints_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_tips.dart';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/APIs/get_profile.dart';
import 'package:design_sprint/APIs/logout.dart';
import 'package:design_sprint/Screens/Initial%20Screen/initial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/create_sprint_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/edit_profile_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/team_data_and_manage_team.dart';
import 'package:design_sprint/main.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'design_sprint_inside_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null &&
        deepLink.toString() == "https://dezy.page.link/toSprints") {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => ViewSprints(),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 300),
        ),
      );
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null &&
          deepLink.toString() == "https://dezy.page.link/toSprints") {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => ViewSprints(),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  LogoutApiProvider logoutApiProvider = LogoutApiProvider();
  ProfileApiProvider profileApiProvider = ProfileApiProvider();
  CreateSprintApiProvider createSprintApiProvider = CreateSprintApiProvider();
  Future<String> getSprints(context) async {
    print(profile.email.toString());
    String url = globals.urlLogin + "getsprintbyuserid.php";

    http.post(url, body: {
      //"userID" : profile.userID,
      "userEmail": profile.email.toString(),
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      home.responseArrayGetSprints = jsonDecode(response.body);
      print(home.responseArrayGetSprints);

      home.responseArrayGetSprintsMsg =
          home.responseArrayGetSprints['message'].toString();
      if (statusCode == 200) {
        if (home.responseArrayGetSprintsMsg == "Data Found") {
          setState(() {
            home.sprintIdsList = List.generate(
                home.responseArrayGetSprints['data'].length,
                (i) => home.responseArrayGetSprints['data'][i]['sprintID']
                    .toString());
            home.sprintTitlesList = List.generate(
                home.responseArrayGetSprints['data'].length,
                (i) => home.responseArrayGetSprints['data'][i]['sprintName']
                    .toString());
            home.sprintStatusList = List.generate(
                home.responseArrayGetSprints['data'].length,
                (i) => home.responseArrayGetSprints['data'][i]['sprintStatus']
                    .toString());
            decisionMakerIdsList = List.generate(
                home.responseArrayGetSprints['data'].length,
                (i) => home.responseArrayGetSprints['data'][i]['sprintUserid']
                    .toString());
          });

          print(home.sprintIdsList.toList());
          print(home.sprintTitlesList.toList());
          print(home.sprintStatusList.toList());
          print(decisionMakerIdsList.toList());
        } else {
          setState(() {
            home.sprintIdsList = null;
            home.sprintTitlesList = null;
            home.sprintStatusList = null;
          });
        }
      }
    });
  }

  Future<String> getProfile(context) async {
    String url = globals.urlLogin + "getprofile.php";

    http.post(url, body: {
      "userID": profile.userID,
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      profile.responseArrayProfile = jsonDecode(response.body);
      print(profile.responseArrayProfile);

      setState(() {
        profile.email =
            profile.responseArrayProfile['data']['userEmail'].toString();
        profile.name =
            profile.responseArrayProfile['data']['userFullname'].toString();
        profile.mobileNo =
            profile.responseArrayProfile['data']['userPhoneno'].toString();
        profile.profilePicImage =
            profile.responseArrayProfile['data']['userProfilepic'].toString();
        profile.nameList = profile.name.split(' ');
      });

      print(profile.email);
      print(profile.mobileNo);
      print(profile.profilePicImage);
      print(profile.nameList.toList());
      getSprints(context);
    });
  }

  getSideBarProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profile.userID = prefs.getString("userID").toString();
    print(profile.userID);
  }

  showOnMessageNotification(var message) async {
    //message = message['notification']['title'].toString() + "\n" + message['notification']['body'].toString();
    //title = message['notification']['title'].toString();

    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max);

    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        1,
        message['notification']['title'].toString(),
        message['notification']['body'].toString(),
        platform,
        payload: '');

//    showDialog<bool>(
//      context: context,
//      builder: (_) => AlertDialog(
//        content: Text(message['notification']['title'].toString()+"\n"+message['notification']['body'].toString()),
//        actions: <Widget>[
//          FlatButton(
//            child: const Text('CLOSE'),
//            onPressed: () {
//              Navigator.pop(context, false);
//            },
//          ),
//          FlatButton(
//            child: const Text('SHOW'),
//            onPressed: () {
//              Navigator.pop(context, true);
//            },
//          ),
//        ],
//      ),
//    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.initDynamicLinks();
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        //showOnMessageNotification(message);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: AssetImage("assets/images/dezylogo.png"))),
              ),
              title: Text(
                message['notification']['title'],
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                message['notification']['body'],
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff787cd1),
                  fontSize: 16,
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Okay',
                  style: GoogleFonts.nunito(
                    color: Colors.grey[700],
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        print("onMessage.....: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        showOnMessageNotification(message);
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        showOnMessageNotification(message);
        print("onResume: $message");
      },
    );
    getProfile(context);
    getSideBarProfile();
    profile.email = null;
    profile.mobileNo = null;
    profile.nameList = null;
  }

  @override
  Widget build(BuildContext context) {
    return profile.nameList == null
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ))
        : Scaffold(
            key: _scaffoldKey,
            appBar: buildAppBar(context),
            backgroundColor: Colors.white,
            endDrawerEnableOpenDragGesture: true,
            endDrawer: ProfileDrawerHomeScreen(),
            body: WillPopScope(
              onWillPop: () => _scaffoldKey.currentState.isEndDrawerOpen
                  ? {Navigator.pop(context)}
                  : showDialog(
                      context: context,
                      builder: (context) => new AlertDialog(
                        title: new Text('Are you sure?'),
                        content: new Text('Do you want to exit the App'),
                        actions: <Widget>[
                          new GestureDetector(
                            onTap: () => Navigator.of(context).pop(false),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("No"),
                            ),
                          ),
                          SizedBox(height: 16),
                          new GestureDetector(
                            onTap: () => exit(0),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("Yes"),
                            ),
                          ),
                        ],
                      ),
                    ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    buildNameWidget(context),
                    SizedBox(
                      height: 25,
                    ),
                    buildDesignSprintCard(context),
                    SizedBox(
                      height: 25,
                    ),
                    buildManageTeamCard(context),
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
        Container(height: 1, width: 25, color: Colors.black, child: Divider());
    void _openEndDrawer() {
      _scaffoldKey.currentState.openEndDrawer();
    }

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: Container(),
      title: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Text(
          home.home,
          style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
              color: Colors.black,
            ),
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

  Widget buildNameWidget(BuildContext context) {
    Text hello = Text(
      home.hello,
      style: GoogleFonts.nunitoSans(
          textStyle: TextStyle(
              color: Color(0xff707070),
              fontSize: 30,
              fontWeight: FontWeight.w200)),
    );
    Text name = Text(
      profile.nameList[0] + "!",
      style: GoogleFonts.nunitoSans(
          textStyle: TextStyle(
              color: Color(0xff707070),
              fontSize: 30,
              fontWeight: FontWeight.w500)),
    );

    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 7),
      child: Row(
        children: [
          hello,
          name,
        ],
      ),
    );
  }

  Widget buildDesignSprintCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => DesignSprintInside(),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
//        if(home.sprintTitlesList == null){
//          Navigator.push(
//            context,
//            PageRouteBuilder(
//              pageBuilder: (c, a1, a2) => CreateSprint(),
//              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
//              transitionDuration: Duration(milliseconds: 300),
//            ),
//          );
//        }else{
//          Navigator.push(
//            context,
//            PageRouteBuilder(
//              pageBuilder: (c, a1, a2) => DesignSprintInside(),
//              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
//              transitionDuration: Duration(milliseconds: 300),
//            ),
//          );
//        }
      },
      child: Container(
        width: 302,
        height: 286.22,
        decoration: BoxDecoration(
            color: Color(0xffF1A042),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Stack(
          children: [
            Image.asset(
              "assets/images/circleDots.png",
              fit: BoxFit.cover,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 29, left: 35),
                  child: Text(
                    home.designSprint,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 35),
                  child: Text(
                    home.designSprintHint,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    )),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => DesignSprintInside(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildManageTeamCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => TeamDataAndManageTeam2(),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        width: 302,
        height: 286.22,
        decoration: BoxDecoration(
            color: Color(0xff787CD1),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Stack(
          children: [
            Image.asset(
              "assets/images/circleDots.png",
              fit: BoxFit.cover,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 29, left: 35),
                  child: Text(
                    home.manageTeam,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 35),
                  child: Text(
                    home.manageTeamHint,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    )),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 20),
              child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => TeamDataAndManageTeam2(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => EditProfile(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    ).whenComplete(() {
                      profileApiProvider.getSideBarProfile();
                      profileApiProvider.getProfile(context).whenComplete(() {
                        Future.delayed(const Duration(seconds: 4), () {
                          setState(() {});
                        });
                      });
                    });
                  },
                  child: Container(
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: NetworkImage(
                                  globals.urlSignUp + profile.profilePicImage),
                              fit: BoxFit.cover,
                            ),
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
                                fontSize: 18,
                              )),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              profile.email,
                              style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              )),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 20,
                              child: RaisedButton(
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (c, a1, a2) => EditProfile(),
                                      transitionsBuilder:
                                          (c, anim, a2, child) =>
                                              FadeTransition(
                                                  opacity: anim, child: child),
                                      transitionDuration:
                                          Duration(milliseconds: 300),
                                    ),
                                  ).whenComplete(() {
                                    profileApiProvider.getSideBarProfile();
                                    profileApiProvider
                                        .getProfile(context)
                                        .whenComplete(() {
                                      Future.delayed(const Duration(seconds: 4),
                                          () {
                                        setState(() {});
                                      });
                                    });
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    "Edit profile",
                                    style: TextStyle(
                                      color: Color(0xff787cd1),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 42,
                ),
                InkWell(
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: "You're on the homepage",
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                  },
                  child: Row(
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
                ),
                SizedBox(
                  height: 42,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => ViewSprints(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Row(
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
                ),
                SizedBox(
                  height: 42,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => ViewTips(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Row(
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
                ),
                SizedBox(
                  height: 42,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => TeamDataAndManageTeam2(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Row(
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
                InkWell(
                  onTap: () {
                    showAlertDialogLogout(context);
                  },
                  child: Row(
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
                        home.logout,
                        style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        )),
                      ),
                    ],
                  ),
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

  showAlertDialogLogout(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        Navigator.of(context).pop();
        Future.delayed(const Duration(seconds: 1), () {
          main();
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => InitialScreen(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        });
        Fluttertoast.showToast(
          msg: "Logged out",
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Future.delayed(const Duration(seconds: 3), () {
          logoutApiProvider.Logout(context);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure you want to logout?"),
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

class Load extends StatefulWidget {
  @override
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Load> {
  ProfileApiProvider profileApiProvider = ProfileApiProvider();

  jumpScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => Home(),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 300),
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileApiProvider.getSideBarProfile();
    profileApiProvider.getProfile(context).whenComplete(() {
      jumpScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
