import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_team.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/JourneyMap/journey_mapping_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

bool statusDrawer = false;

class JourneyMappingTutorial extends StatefulWidget {
  @override
  _JourneyMappingTutorialState createState() => _JourneyMappingTutorialState();
}

class _JourneyMappingTutorialState extends State<JourneyMappingTutorial> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  VideoPlayerController _controller;
  FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://dezyit.ml/mobileapp/mailerimages/DezyVideos/journeymap.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    flickManager = FlickManager(
      videoPlayerController:
      VideoPlayerController.network("https://dezyit.ml/mobileapp/mailerimages/DezyVideos/journeymap.mp4"),
    );
  }
  @override
  void dispose() {
    super.dispose();
    flickManager.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: statusDrawer == true ? StatusDrawerTeam() : ProfileDrawerCommon(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            buildName2Widget(context),
            SizedBox(height: 20,),
            buildVideoContainer(context),
            SizedBox(height: 45,),
            buildInfoText1(context),
            SizedBox(height: 40,),
            buildImage1Container(context),
            SizedBox(height: 40,),
            buildInfoText2(context),
            SizedBox(height: 40,),
            buildInfoText3(context),
            SizedBox(height: 40,),
            buildInfoText4(context),
            SizedBox(height: 40,),
            buildInfoText5(context),
            SizedBox(height: 40,),
            buildNextButton(context),
            SizedBox(height: 40,),
          ],
        ),
      ),
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
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: _openEndDrawer,
        child: Container(
          height: 37,
          width: 37,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )
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

  Widget buildVideoContainer(BuildContext context){
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 215,
          child: FlickVideoPlayer(
            flickManager: flickManager,
            flickVideoWithControls: FlickVideoWithControls(
              controls: FlickPortraitControls(),
            ),
            flickVideoWithControlsFullscreen: FlickVideoWithControls(
              controls: FlickLandscapeControls(),
            ),
          ),
        ),
        statusBarDrawer(context),
      ],
    );
  }

  Widget buildInfoText1(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 36),
      child: Text("A journey map is useful to understand your customer’s interaction with your product. Each person on the team should select one persona and map out their journey.",
        maxLines: 4,
        style: GoogleFonts.nunitoSans(
          textStyle: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
  Widget buildInfoText2(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 36),
      child: Text("- List an objective for your users, mention the first and the last step of the journey and then map all the steps in between.",
        maxLines: 4,
        style: GoogleFonts.nunitoSans(
          textStyle: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
  Widget buildInfoText3(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 36),
      child: Text("- Map down the customer thoughts in every touchpoint and map out their experiences with emojis to understand how they are feeling in each step.",
        maxLines: 4,
        style: GoogleFonts.nunitoSans(
          textStyle: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
  Widget buildInfoText4(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 36),
      child: Text("- Identify the pain points the users are facing and map them down under each touchpoint on the Journey Map",
        maxLines: 4,
        style: GoogleFonts.nunitoSans(
          textStyle: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
  Widget buildInfoText5(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 36),
      child: Text("Example: Opens Browser > Searches for Flight Ticket > Opens makemytrip.com > Adds the destinations and dates of travel > compares and chooses a flight > Completes the process and books the ticket",
        maxLines: 8,
        style: GoogleFonts.nunitoSans(
          textStyle: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget buildImage1Container(BuildContext context){
    return Center(
      child: Container(
          width: 233.56,
          height: 151.28,
          child: Image.asset("assets/images/Journeymaptutorial.png")),
    );
  }

  Widget buildStepText1(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name :",
            style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )
            ),
          ),
          SizedBox(width: 5,),
          Text("Step 1: Identify the objective. What is the\nproblem you are trying to solve?",
            maxLines: 3,
            style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(
                  fontSize: 16,
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => JourneyMappingMainScreen(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Center(
        child: Container(
          height: 50,
          width: MediaQuery
              .of(context)
              .size
              .width / 2.0,
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
