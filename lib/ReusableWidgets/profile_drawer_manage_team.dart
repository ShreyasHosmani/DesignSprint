import 'package:design_sprint/APIs/get_profile.dart';
import 'package:design_sprint/APIs/logout.dart';
import 'package:design_sprint/Screens/Initial%20Screen/initial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/edit_profile_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/LoginSignUp%20Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_sprints_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_tips.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/team_data_and_manage_team.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import '../main.dart';
import 'package:design_sprint/utils/login_data.dart' as login;
import '../main.dart';

TextEditingController bugController = TextEditingController();

class ProfileDrawerCommonManageTeam extends StatefulWidget {
  @override
  _ProfileDrawerCommonManageTeamState createState() => _ProfileDrawerCommonManageTeamState();
}

class _ProfileDrawerCommonManageTeamState extends State<ProfileDrawerCommonManageTeam> {
  LogoutApiProvider logoutApiProvider = LogoutApiProvider();
  ProfileApiProvider profileApiProvider = ProfileApiProvider();
  Future<String> getProfile(context) async {
    String url = globals.urlLogin + "getprofile.php";

    http.post(url, body: {

      "userID" : profile.userID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      profile.responseArrayProfile = jsonDecode(response.body);
      print(profile.responseArrayProfile);

      setState(() {
        profile.email = profile.responseArrayProfile['data']['userEmail'].toString();
        profile.name = profile.responseArrayProfile['data']['userFullname'].toString();
        profile.mobileNo = profile.responseArrayProfile['data']['userPhoneno'].toString();
        profile.profilePicImage = profile.responseArrayProfile['data']['userProfilepic'].toString();
        profile.nameList = profile.name.split(' ');
      });

      print(profile.email);
      print(profile.mobileNo);
      print(profile.profilePicImage);
      print(profile.nameList.toList());

    });
  }
  Future<String> reportBug(context) async {
    String url = globals.urlLogin + "savebugs.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "usertext" : bugController.text.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayReport = jsonDecode(response.body);
      print(responseArrayReport);

    });
  }
  getSideBarProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profile.userID = prefs.getString("userID").toString();
    print(profile.userID);
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20.0,
      child: Container(
        child: Drawer(
          elevation: 10,
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => EditProfile(),
                            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                            transitionDuration: Duration(milliseconds: 300),
                          ),
                        ).whenComplete((){
                          getProfile(context);
                          getSideBarProfile();
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
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
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              profile.profilePicImage == null || profile.profilePicImage == "null" ? Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Icon(Icons.person, size: 35, color: Color(0xff787cd1),),
                              ) : Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    image: NetworkImage(globals.urlSignUp+profile.profilePicImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Hi, " + profile.name + "!",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nunitoSans(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(profile.email,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nunitoSans(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    height: 20,
                                    child: RaisedButton(
                                      color: Colors.white,
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (c, a1, a2) => EditProfile(),
                                            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                            transitionDuration: Duration(milliseconds: 300),
                                          ),
                                        ).whenComplete((){
                                          profileApiProvider.getSideBarProfile();
                                          profileApiProvider.getProfile(context).whenComplete((){
                                            Future.delayed(const Duration(seconds: 4), () {
                                              setState(() {

                                              });
                                            });
                                          });
                                        });
                                      },
                                      child: Center(
                                        child: Text("Edit profile",
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
                    ),
                    SizedBox(height: 35,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 45,),
                          Container(
                            height: 25,
                            width: 25,
                            child: Image.asset("assets/images/home.png"),
                          ),
                          SizedBox(width: 15,),
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
                    ),
                    SizedBox(height: 25,),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => ViewSprints(),
                            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                            transitionDuration: Duration(milliseconds: 300),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 45,),
                          Container(
                            height: 25,
                            width: 25,
                            child: Image.asset("assets/images/sprint.png"),
                          ),
                          SizedBox(width: 15,),
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
                    ),
                    SizedBox(height: 25,),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => ViewTips(),
                            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                            transitionDuration: Duration(milliseconds: 300),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 45,),
                          Container(
                            height: 25,
                            width: 25,
                            child: Image.asset("assets/images/tips.png"),
                          ),
                          SizedBox(width: 15,),
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
                    ),
                    SizedBox(height: 25,),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 45,),
                          Container(
                            height: 25,
                            width: 25,
                            child: Image.asset("assets/images/manage_team.png"),
                          ),
                          SizedBox(width: 15,),
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
                    ),
                    SizedBox(height: 25,),
                    Row(
                      children: [
                        SizedBox(width: 45,),
                        Container(
                          height: 25,
                          width: 25,
                          child: Image.asset("assets/images/faq.png"),
                        ),
                        SizedBox(width: 15,),
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
                    SizedBox(height: 25,),
                    InkWell(
                      onTap: (){
                        launch("https://dezyit.com/privacypolicy");
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 45,),
                          Container(
                            height: 25,
                            width: 25,
                            child: Image.asset("assets/images/legal.png"),
                          ),
                          SizedBox(width: 15,),
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
                    ),
                    SizedBox(height: 25,),
                    InkWell(
                      onTap: (){
                        showAlertDialogReportBug(context);
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 45,),
                          Container(
                            height: 25,
                            width: 25,
                            child: Icon(Icons.bug_report_outlined),//Image.asset("assets/images/legal.png"),
                          ),
                          SizedBox(width: 15,),
                          Text("Report a Bug",
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
                    ),
                  ],
                ),
                Positioned(
                  bottom: 35,left: 0,right: 0,
                  child: InkWell(
                    onTap: (){
                      showAlertDialogLogout(context);
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 45,),
                        Container(
                          height: 20,
                          width: 20,
                          child: Image.asset("assets/images/logout.png"),
                        ),
                        SizedBox(width: 15,),
                        Text(home.logout,
                          style: GoogleFonts.nunitoSans(
                              textStyle: TextStyle(
                                color: Color(0xff787cd1),
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
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
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        Navigator.of(context).pop();
        login.googleSignIn.disconnect();
        //login.facebookLogin.logOut();
        Future.delayed(const Duration(seconds: 1), () {
          main();
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => Login(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        });
        Fluttertoast.showToast(msg: "Logged out", backgroundColor: Colors.black,
          textColor: Colors.white,);
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

  showAlertDialogReportBug(BuildContext context) {

    Widget textField = Theme(
        data: ThemeData(
          primaryColor: Color(0xff787CD1),
        ),
        child: TextFormField(
          controller: bugController,
          decoration: InputDecoration(
              hintText: 'Type here...'
          ),
          validator: (value){
            if(value.isEmpty){
              return home.sprintNameValidation;
            }
            return null;
          },
        ));

    GestureDetector buildSaveButton = GestureDetector(
      onTap: (){
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Your problem has been successfully reported!',backgroundColor: Colors.black, textColor: Colors.white).whenComplete((){
          reportBug(context);
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10,
        child: Container(
          height: 50,
          width: MediaQuery
              .of(context)
              .size
              .width / 2.4,
          decoration: BoxDecoration(
              color: Color(0xff7579cb),
              borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          child: Center(
            child: Text("Report",
                style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 16, letterSpacing: 1,color: Colors.white),)
            ),
          ),
        ),
      ),
    );

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(icon: Icon(Icons.close,color: Colors.grey,),onPressed: (){Navigator.of(context).pop();},)),
          SizedBox(height: 10,),
          Text("Report a bug ?", style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 16, letterSpacing: 1),)),
          //Text(home.popUp2,style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 12, letterSpacing: 1),)),
          SizedBox(height: 10,)
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: home.formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textField,
                  SizedBox(height: 25,),
                  buildSaveButton,
                  SizedBox(height: 25,),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
