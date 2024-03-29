import 'package:design_sprint/APIs/create_journey_map.dart';
import 'package:design_sprint/APIs/delete_sprint.dart';
import 'package:design_sprint/APIs/update_timeline.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/tutorial_sprint_goal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/timeline_data.dart' as timeline;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:progress_dialog/progress_dialog.dart';

class InputTimeline extends StatefulWidget {
  @override
  _InputTimelineState createState() => _InputTimelineState();
}

class _InputTimelineState extends State<InputTimeline> {
  UpdateTimelineApiProvider updateTimelineApiProvider = UpdateTimelineApiProvider();
  DeleteSprintApiProvider deleteSprintApiProvider = DeleteSprintApiProvider();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    home.prCreateSprint = ProgressDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: ProfileDrawerCommon(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            buildName2Widget(context),
            SizedBox(height: 20,),
            buildTimeLine1Card(context),
            SizedBox(height: 10,),
            buildTimeLine2Card(context),
            SizedBox(height: 10,),
            buildTimeLine3Card(context),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context){

    Container line = Container(height:1, width:25, color: Colors.black,child: Divider());
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
          onPressed: (){
            //showAlertDialog(context);
            Navigator.of(context).pop();
            },
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

  Widget buildName2Widget(BuildContext context){

    return Center(
      child: Text("Select Timeline",
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

  Widget buildTimeLine1Card(BuildContext context){
    return Center(
      child: GestureDetector(
        onTap: (){
          setState(() {
            timeline.selectedTimeline = "5";
          });
          print(timeline.selectedTimeline);
          home.prCreateSprint.show();
          updateTimelineApiProvider.updateTimeLine(context);
        },
        child: Stack(
          children: [
            Center(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Container(
                  width: 302,
                  height: 197.22,
                  decoration: BoxDecoration(
                      color: Color(0xfffab7b7),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 29, left: 35),
                            child: Text(timeline.timeline1Text1,
                              style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 35),
                            child: Text(timeline.timeline1Text2,
                              style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35, bottom: 20),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(timeline.timeline1Text3,
                            style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                  fontSize: 14,
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
            ),
            Padding(
              padding: const EdgeInsets.only(right: 60, top: 25),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: (){
                    setState(() {
                      timeline.selectedTimeline = "5";
                    });
                    print(timeline.selectedTimeline);
                    home.prCreateSprint.show();
                    updateTimelineApiProvider.updateTimeLine(context);
                  },
                  icon: Icon(Icons.arrow_forward, color: Colors.white,size: 25,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTimeLine2Card(BuildContext context){
    return GestureDetector(
      onTap: (){
        setState(() {
          timeline.selectedTimeline = "14";
        });
        print(timeline.selectedTimeline);
        home.prCreateSprint.show();
        updateTimelineApiProvider.updateTimeLine(context);
      },
      child: Stack(
        children: [
          Center(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Container(
                width: 302,
                height: 197.22,
                decoration: BoxDecoration(
                    color: Color(0xff96C3CB),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 29, left: 35),
                          child: Text(timeline.timeline2Text1,
                            style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 35),
                          child: Text(timeline.timeline2Text2,
                            style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35, bottom: 20),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(timeline.timeline2Text3,
                          style: GoogleFonts.nunitoSans(
                              textStyle: TextStyle(
                                fontSize: 14,
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
          ),
          Padding(
            padding: const EdgeInsets.only(right: 60, top: 25),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: (){
                  setState(() {
                    timeline.selectedTimeline = "14";
                  });
                  print(timeline.selectedTimeline);
                  home.prCreateSprint.show();
                  updateTimelineApiProvider.updateTimeLine(context);
                },
                icon: Icon(Icons.arrow_forward, color: Colors.white,size: 25,),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTimeLine3Card(BuildContext context){
    return GestureDetector(
      onTap: (){
        setState(() {
          timeline.selectedTimeline = "30";
        });
        print(timeline.selectedTimeline);
        home.prCreateSprint.show();
        updateTimelineApiProvider.updateTimeLine(context);
      },
      child: Stack(
        children: [
          Center(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Container(
                width: 302,
                height: 197.22,
                decoration: BoxDecoration(
                    color: Color(0xffF1A042),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 29, left: 35),
                          child: Text(timeline.timeline3Text1,
                            style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 35),
                          child: Text(timeline.timeline3Text2,
                            style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35, bottom: 20),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(timeline.timeline3Text3,
                          style: GoogleFonts.nunitoSans(
                              textStyle: TextStyle(
                                fontSize: 14,
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
          ),
          Padding(
            padding: const EdgeInsets.only(right: 60, top: 25),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: (){
                  setState(() {
                    timeline.selectedTimeline = "30";
                  });
                  print(timeline.selectedTimeline);
                  home.prCreateSprint.show();
                  updateTimelineApiProvider.updateTimeLine(context);
                },
                icon: Icon(Icons.arrow_forward, color: Colors.white,size: 25,),
              ),
            ),
          )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel",style: GoogleFonts.nunitoSans(),),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue",style: GoogleFonts.nunitoSans(),),
      onPressed:  () async {
        deleteSprintApiProvider.deleteSprint(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning",
        style: GoogleFonts.nunitoSans(
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text("If you go back, this sprint will be discarded. Are you sure you want to go back?",
        style: GoogleFonts.nunitoSans(),
      ),
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
