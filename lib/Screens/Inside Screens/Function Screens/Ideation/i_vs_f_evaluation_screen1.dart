import 'package:design_sprint/APIs/get_pain_points.dart';
import 'package:design_sprint/APIs/upload_idea_image.dart';
import 'package:design_sprint/APIs/vote_pain_point.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_empathize.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Ideation/i_vs_f_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Ideation/idea_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/ideation_data.dart' as ideation;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

bool statusDrawer = false;

class ImpactVsFeasibilityPageViewBuilder extends StatefulWidget {
  @override
  _ImpactVsFeasibilityPageViewBuilderState createState() => _ImpactVsFeasibilityPageViewBuilderState();
}

class _ImpactVsFeasibilityPageViewBuilderState extends State<ImpactVsFeasibilityPageViewBuilder> {
  final controller = PageController(viewportFraction: 1);
  GetPainPointsApiProvider getPainPointsApiProvider = GetPainPointsApiProvider();
  UploadIdeaApiProvider uploadIdeaApiProvider = UploadIdeaApiProvider();
  void initState() {
    // TODO: implement initState
    super.initState();
    ideation.pageIndexIvsF = 0;
    getPainPointsApiProvider.getPainPointsOfStatusTwo2(context).whenComplete((){
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {});
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ideation.painPointsOfStatus2List2 == null ? Center(
        child: CircularProgressIndicator(),
      ) : PageView.builder(
        physics:new NeverScrollableScrollPhysics(),
        itemCount: ideation.painPointsOfStatus2List2 == null ? 0 : ideation.painPointsOfStatus2List2.length,
        controller: controller,
        onPageChanged: (index){
          setState(() {
            ideation.pageIndexIvsF = index;
            ideation.selectedPainPointIdForVoteOfIvsF = ideation.painPointsIdsOfStatus2List2[ideation.pageIndexIvsF];
          });
          print(ideation.pageIndexIvsF);
        },
        itemBuilder: (BuildContext context, int index) {
          return IvsFEvaluation1(controller);
        },
      ),
    );
  }
}

class IvsFEvaluation1 extends StatefulWidget {
  final controller;
  IvsFEvaluation1(this.controller) : super();
  @override
  _IvsFEvaluation1State createState() => _IvsFEvaluation1State();
}

class _IvsFEvaluation1State extends State<IvsFEvaluation1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  VotePainPointsApiProvider votePainPointsApiProvider = VotePainPointsApiProvider();
  UploadIdeaApiProvider uploadIdeaApiProvider = UploadIdeaApiProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ideation.ideaImagesPainPointWiseList = null;
    uploadIdeaApiProvider.getIdeaImages(context).whenComplete((){
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          ideation.selectedPainPointIdForUploadIdeaImage = ideation.painPointsIdsOfStatus2List2[ideation.pageIndexIvsF];
        });
        print(ideation.selectedPainPointIdForUploadIdeaImage);
      });
    });
    ideation.selectedPainPointIdForVoteOfIvsF = ideation.painPointsIdsOfStatus2List2[ideation.pageIndexIvsF];
    print(ideation.selectedPainPointIdForVoteOfIvsF);
    containerColorList = [Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, ];
    containerColorList2 = [Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: statusDrawer == true ? StatusDrawerEmpathize() : ProfileDrawerCommon(),
      body: WillPopScope(
        onWillPop: () => Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => IvsFTutorial(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  buildName2Widget(context),
                  SizedBox(height: 25,),
                  buildName3Widget(context),
                  SizedBox(height: 20,),
                  buildLevelContainer(context),
                  SizedBox(height: 46,),
                  buildPainPointNumberIndicator(context),
                  SizedBox(height: 28,),
                  buildImageContainer(context),
                  SizedBox(height: 43,),
                  buildName4Widget(context),
                  SizedBox(height: 25,),
                  buildVoteRow(context),
                  SizedBox(height: 25,),
                  buildName5Widget(context),
                  SizedBox(height: 25,),
                  buildVoteRow2(context),
                  SizedBox(height: 53,),
                  buildNextButton(context),
                  SizedBox(height: 40,),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: statusBarDrawer(context),
              ),
            ],
          ),
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
          onPressed: (){
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => IvsFTutorial(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
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
                        Color(0xff787CD1),
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
      child: Text(ideation.ivsfanalysis,
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
      child: Text(ideation.ivsfHint1,
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
          percent: (ideation.pageIndexIvsF+1)/ideation.painPointsOfStatus2List2.length,
          backgroundColor: Colors.grey.shade300,
          progressColor: Color(0xff787CD1),
        ),
      ),
    );
  }

  Widget buildPainPointNumberIndicator(BuildContext context){
    return Center(
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
            color: Color(0xff787CD1),
            borderRadius: BorderRadius.all(Radius.circular(50))
        ),
        child: Center(
          child: Text((ideation.pageIndexIvsF+1).toString(),
            style: GoogleFonts.nunitoSans(
                fontSize: 16,
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImageContainer(BuildContext context){
    return ideation.ideaImagesPainPointWiseList == null ? Container(
      height: 161,
      width: 302,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        border: Border.all(color: Colors.grey),
      ),
    ) : InkWell(
      onTap: (){
        launch(globals.urlSignUp+ideation.ideaImagesPainPointWiseList[0]);
      },
      child: Container(
        height: 161,
        width: 302,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          border: Border.all(color: Colors.grey),
          image: DecorationImage(
            image: NetworkImage(globals.urlSignUp + ideation.ideaImagesPainPointWiseList[0]),
            fit: BoxFit.cover
          ),
        ),
      ),
    );
  }

  Widget buildName4Widget(BuildContext context){

    return Center(
      child: Text(ideation.ivsfHint2,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            )
        ),
      ),
    );
  }

  Widget buildName5Widget(BuildContext context){

    return Center(
      child: Text(ideation.ivsfHint3,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            )
        ),
      ),
    );
  }

  Widget buildVoteRow(BuildContext context){
    return Center(
      child: Container(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("1"),
            SizedBox(width: 10,),
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, i) => Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedIndex = i.toString();
                        var impactRangeTemp = (i + 1).toString();
                        ideation.impactRange = impactRangeTemp.toString();
                        ideation.selectedPainPointIdForVoteOfIvsF = ideation.painPointsIdsOfStatus2List2[ideation.pageIndexIvsF];
                      });
                      print(ideation.impactRange);
                      print(ideation.selectedPainPointIdForVoteOfIvsF);
                      setColorState(context, selectedIndex);
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: Color(0xff787CD1)),
                        color: containerColorList[i],
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                ],
              ),
            ),
            SizedBox(width: 10,),
            Text("10"),
          ],
        ),
      ),
    );
  }
  Widget buildVoteRow2(BuildContext context){
    return Center(
      child: Container(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("1"),
            SizedBox(width: 10,),
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, i2) => Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedIndex2 = i2.toString();
                        var feasibilityRangeTemp = (i2 + 1).toString();
                        ideation.feasibilityRange = feasibilityRangeTemp.toString();
                        ideation.selectedPainPointIdForVoteOfIvsF = ideation.painPointsIdsOfStatus2List2[ideation.pageIndexIvsF];
                      });
                      print(ideation.feasibilityRange);
                      print(ideation.selectedPainPointIdForVoteOfIvsF);
                      setColorState2(context, selectedIndex2);
                      votePainPointsApiProvider.votePainPointsAccToIvsF(context);
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: Color(0xff787CD1)),
                        color: containerColorList2[i2],
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                ],
              ),
            ),
            SizedBox(width: 10,),
            Text("10"),
          ],
        ),
      ),
    );
  }

  void setColorState(BuildContext context, selectedIndex){
    if(selectedIndex == "0" || selectedIndex == 0){
      setState(() {
        containerColorList[0] = Color(0xff787cd1);
        containerColorList[0] = Colors.white;
        containerColorList[1] = Colors.white;
        containerColorList[2] = Colors.white;
        containerColorList[3] = Colors.white;
        containerColorList[4] = Colors.white;
        containerColorList[5] = Colors.white;
        containerColorList[6] = Colors.white;
        containerColorList[7] = Colors.white;
        containerColorList[8] = Colors.white;
        containerColorList[9] = Colors.white;
      });
    }else if(selectedIndex == "1" || selectedIndex == 1){
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Colors.white;
      containerColorList[3] = Colors.white;
      containerColorList[4] = Colors.white;
      containerColorList[5] = Colors.white;
      containerColorList[6] = Colors.white;
      containerColorList[7] = Colors.white;
      containerColorList[8] = Colors.white;
      containerColorList[9] = Colors.white;
    }else if(selectedIndex == "2" || selectedIndex == 2){
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Colors.white;
      containerColorList[4] = Colors.white;
      containerColorList[5] = Colors.white;
      containerColorList[6] = Colors.white;
      containerColorList[7] = Colors.white;
      containerColorList[8] = Colors.white;
      containerColorList[9] = Colors.white;
    }else if(selectedIndex == "3" || selectedIndex == 3){
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Color(0xff787cd1);
      containerColorList[4] = Colors.white;
      containerColorList[5] = Colors.white;
      containerColorList[6] = Colors.white;
      containerColorList[7] = Colors.white;
      containerColorList[8] = Colors.white;
      containerColorList[9] = Colors.white;
    }else if(selectedIndex == "4" || selectedIndex == 4){
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Color(0xff787cd1);
      containerColorList[4] = Color(0xff787cd1);
      containerColorList[5] = Colors.white;
      containerColorList[6] = Colors.white;
      containerColorList[7] = Colors.white;
      containerColorList[8] = Colors.white;
      containerColorList[9] = Colors.white;
    }else if(selectedIndex == "5" || selectedIndex == 5){
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Color(0xff787cd1);
      containerColorList[4] = Color(0xff787cd1);
      containerColorList[5] = Color(0xff787cd1);
      containerColorList[6] = Colors.white;
      containerColorList[7] = Colors.white;
      containerColorList[8] = Colors.white;
      containerColorList[9] = Colors.white;
    }else if(selectedIndex == "6" || selectedIndex == 6){
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Color(0xff787cd1);
      containerColorList[4] = Color(0xff787cd1);
      containerColorList[5] = Color(0xff787cd1);
      containerColorList[6] = Color(0xff787cd1);
      containerColorList[7] = Colors.white;
      containerColorList[8] = Colors.white;
      containerColorList[9] = Colors.white;
    }else if(selectedIndex == "7" || selectedIndex == 7){
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Color(0xff787cd1);
      containerColorList[4] = Color(0xff787cd1);
      containerColorList[5] = Color(0xff787cd1);
      containerColorList[6] = Color(0xff787cd1);
      containerColorList[7] = Color(0xff787cd1);
      containerColorList[8] = Colors.white;
      containerColorList[9] = Colors.white;
    }else if(selectedIndex == "8" || selectedIndex == 8){
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Color(0xff787cd1);
      containerColorList[4] = Color(0xff787cd1);
      containerColorList[5] = Color(0xff787cd1);
      containerColorList[6] = Color(0xff787cd1);
      containerColorList[7] = Color(0xff787cd1);
      containerColorList[8] = Color(0xff787cd1);
      containerColorList[9] = Colors.white;
    }else if(selectedIndex == "9" || selectedIndex == 9){
      containerColorList[0] = Color(0xff787cd1);
      containerColorList[1] = Color(0xff787cd1);
      containerColorList[2] = Color(0xff787cd1);
      containerColorList[3] = Color(0xff787cd1);
      containerColorList[4] = Color(0xff787cd1);
      containerColorList[5] = Color(0xff787cd1);
      containerColorList[6] = Color(0xff787cd1);
      containerColorList[7] = Color(0xff787cd1);
      containerColorList[8] = Color(0xff787cd1);
      containerColorList[9] = Color(0xff787cd1);
    }
//    setState(() {
//      containerColorList[int.parse(selectedIndex)] = Color(0xff787cd1);
//    });
  }
  void setColorState2(BuildContext context, selectedIndex2){
    if(selectedIndex2 == "0" || selectedIndex2 == 0){
      setState(() {
        containerColorList2[0] = Color(0xff787cd1);
        containerColorList2[0] = Colors.white;
        containerColorList2[1] = Colors.white;
        containerColorList2[2] = Colors.white;
        containerColorList2[3] = Colors.white;
        containerColorList2[4] = Colors.white;
        containerColorList2[5] = Colors.white;
        containerColorList2[6] = Colors.white;
        containerColorList2[7] = Colors.white;
        containerColorList2[8] = Colors.white;
        containerColorList2[9] = Colors.white;
      });
    }else if(selectedIndex2 == "1" || selectedIndex2 == 1){
      containerColorList2[0] = Color(0xff787cd1);
      containerColorList2[1] = Color(0xff787cd1);
      containerColorList2[2] = Colors.white;
      containerColorList2[3] = Colors.white;
      containerColorList2[4] = Colors.white;
      containerColorList2[5] = Colors.white;
      containerColorList2[6] = Colors.white;
      containerColorList2[7] = Colors.white;
      containerColorList2[8] = Colors.white;
      containerColorList2[9] = Colors.white;
    }else if(selectedIndex2 == "2" || selectedIndex2 == 2){
      containerColorList2[0] = Color(0xff787cd1);
      containerColorList2[1] = Color(0xff787cd1);
      containerColorList2[2] = Color(0xff787cd1);
      containerColorList2[3] = Colors.white;
      containerColorList2[4] = Colors.white;
      containerColorList2[5] = Colors.white;
      containerColorList2[6] = Colors.white;
      containerColorList2[7] = Colors.white;
      containerColorList2[8] = Colors.white;
      containerColorList2[9] = Colors.white;
    }else if(selectedIndex2 == "3" || selectedIndex2 == 3){
      containerColorList2[0] = Color(0xff787cd1);
      containerColorList2[1] = Color(0xff787cd1);
      containerColorList2[2] = Color(0xff787cd1);
      containerColorList2[3] = Color(0xff787cd1);
      containerColorList2[4] = Colors.white;
      containerColorList2[5] = Colors.white;
      containerColorList2[6] = Colors.white;
      containerColorList2[7] = Colors.white;
      containerColorList2[8] = Colors.white;
      containerColorList2[9] = Colors.white;
    }else if(selectedIndex2 == "4" || selectedIndex2 == 4){
      containerColorList2[0] = Color(0xff787cd1);
      containerColorList2[1] = Color(0xff787cd1);
      containerColorList2[2] = Color(0xff787cd1);
      containerColorList2[3] = Color(0xff787cd1);
      containerColorList2[4] = Color(0xff787cd1);
      containerColorList2[5] = Colors.white;
      containerColorList2[6] = Colors.white;
      containerColorList2[7] = Colors.white;
      containerColorList2[8] = Colors.white;
      containerColorList2[9] = Colors.white;
    }else if(selectedIndex2 == "5" || selectedIndex2 == 5){
      containerColorList2[0] = Color(0xff787cd1);
      containerColorList2[1] = Color(0xff787cd1);
      containerColorList2[2] = Color(0xff787cd1);
      containerColorList2[3] = Color(0xff787cd1);
      containerColorList2[4] = Color(0xff787cd1);
      containerColorList2[5] = Color(0xff787cd1);
      containerColorList2[6] = Colors.white;
      containerColorList2[7] = Colors.white;
      containerColorList2[8] = Colors.white;
      containerColorList2[9] = Colors.white;
    }else if(selectedIndex2 == "6" || selectedIndex2 == 6){
      containerColorList2[0] = Color(0xff787cd1);
      containerColorList2[1] = Color(0xff787cd1);
      containerColorList2[2] = Color(0xff787cd1);
      containerColorList2[3] = Color(0xff787cd1);
      containerColorList2[4] = Color(0xff787cd1);
      containerColorList2[5] = Color(0xff787cd1);
      containerColorList2[6] = Color(0xff787cd1);
      containerColorList2[7] = Colors.white;
      containerColorList2[8] = Colors.white;
      containerColorList2[9] = Colors.white;
    }else if(selectedIndex2 == "7" || selectedIndex2 == 7){
      containerColorList2[0] = Color(0xff787cd1);
      containerColorList2[1] = Color(0xff787cd1);
      containerColorList2[2] = Color(0xff787cd1);
      containerColorList2[3] = Color(0xff787cd1);
      containerColorList2[4] = Color(0xff787cd1);
      containerColorList2[5] = Color(0xff787cd1);
      containerColorList2[6] = Color(0xff787cd1);
      containerColorList2[7] = Color(0xff787cd1);
      containerColorList2[8] = Colors.white;
      containerColorList2[9] = Colors.white;
    }else if(selectedIndex2 == "8" || selectedIndex2 == 8){
      containerColorList2[0] = Color(0xff787cd1);
      containerColorList2[1] = Color(0xff787cd1);
      containerColorList2[2] = Color(0xff787cd1);
      containerColorList2[3] = Color(0xff787cd1);
      containerColorList2[4] = Color(0xff787cd1);
      containerColorList2[5] = Color(0xff787cd1);
      containerColorList2[6] = Color(0xff787cd1);
      containerColorList2[7] = Color(0xff787cd1);
      containerColorList2[8] = Color(0xff787cd1);
      containerColorList2[9] = Colors.white;
    }else if(selectedIndex2 == "9" || selectedIndex2 == 9){
      containerColorList2[0] = Color(0xff787cd1);
      containerColorList2[1] = Color(0xff787cd1);
      containerColorList2[2] = Color(0xff787cd1);
      containerColorList2[3] = Color(0xff787cd1);
      containerColorList2[4] = Color(0xff787cd1);
      containerColorList2[5] = Color(0xff787cd1);
      containerColorList2[6] = Color(0xff787cd1);
      containerColorList2[7] = Color(0xff787cd1);
      containerColorList2[8] = Color(0xff787cd1);
      containerColorList2[9] = Color(0xff787cd1);
    }
  }

  Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(ideation.painPointsIdsOfStatus2List2.last == ideation.painPointsIdsOfStatus2List2[ideation.pageIndexIvsF]){
          print("Last index reached, You are a great man ever!");
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => IdeaSelection(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        }else{
          print("You are a loser bro, try again!");
          widget.controller.nextPage(duration: Duration(seconds: 1), curve: Curves.easeIn);
        }
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

var containerColorList = [Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, ];
var containerColorList2 = [Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, ];
var selectedIndex;
var selectedIndex2;
