import 'package:design_sprint/APIs/get_profile.dart';
import 'package:design_sprint/APIs/logout.dart';
import 'package:design_sprint/Screens/Initial%20Screen/initial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/edit_profile_screen.dart';
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

import '../main.dart';

class ProfileDrawerCommon extends StatefulWidget {
  @override
  _ProfileDrawerCommonState createState() => _ProfileDrawerCommonState();
}

class _ProfileDrawerCommonState extends State<ProfileDrawerCommon> {
  LogoutApiProvider logoutApiProvider = LogoutApiProvider();
  ProfileApiProvider profileApiProvider = ProfileApiProvider();
  @override
  Widget build(BuildContext context) {
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
                  onTap: (){
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
                              style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  )
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(profile.email,
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
                SizedBox(height: 42,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Row(
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
                ),
                SizedBox(height: 42,),
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
                ),
                SizedBox(height: 42,),
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
                ),
                SizedBox(height: 42,),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => TeamDataAndManageTeam(),
                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Row(
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
        Future.delayed(const Duration(seconds: 1), () {
          main();
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => InitialScreen(),
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

}
