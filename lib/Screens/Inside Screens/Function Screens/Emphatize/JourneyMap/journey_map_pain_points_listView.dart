import 'package:design_sprint/APIs/create_journey_map.dart';
import 'package:design_sprint/APIs/input_pain_point.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_team.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/EmpathizeScreens/emphatize_inside_sections_scree3.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:keyboard_visibility/keyboard_visibility.dart';

int counter = 6;
int i =0;

class JourneyMapPainPointsListView extends StatefulWidget {
  @override
  _JourneyMapPainPointsListViewState createState() => _JourneyMapPainPointsListViewState();
}

class _JourneyMapPainPointsListViewState extends State<JourneyMapPainPointsListView> {
  InputPainPointsApiProvider inputPainPointsApiProvider = InputPainPointsApiProvider();
  CreateJourneyApiProvider createJourneyApiProvider = CreateJourneyApiProvider();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  KeyboardVisibilityNotification _keyboardVisibility = new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  bool _keyboardState;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    counter = 6;
//    _keyboardState = _keyboardVisibility.isKeyboardVisible;
//    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
//      onChange: (bool visible) {
//        setState(() {
//          _keyboardState = visible;
//        });
//        print(_keyboardState);
//      },
//    );
    touchPointIdListStorage = ['x', 'x', 'x', 'x', 'x','x', 'x', 'x', 'x', 'x','x', 'x', 'x', 'x', 'x',];
    customerThoughtIdListStorage = ['x', 'x', 'x', 'x', 'x','x', 'x', 'x', 'x', 'x','x', 'x', 'x', 'x', 'x',];
    customerExperienceIdListStorage = ['x', 'x', 'x', 'x', 'x','x', 'x', 'x', 'x', 'x','x', 'x', 'x', 'x', 'x',];
    painPointIdListStorage = ['x', 'x', 'x', 'x', 'x','x', 'x', 'x', 'x', 'x','x', 'x', 'x', 'x', 'x',];
    _controllerListTouchPoints = List.generate(15, (i) => TextEditingController());
    _controllerListCustomerThoughts = List.generate(15, (i) => TextEditingController());
    _controllerListPainPoints = List.generate(15, (i) => TextEditingController());
    emojiList1 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList2 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList3 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList4 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList5 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList6 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList7 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList8 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList9 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList10 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList11 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList12 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList13 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList14 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList15 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    boolEmojis1 = [false,false,false,false,false,false,false,false,];
    boolEmojis2 = [false,false,false,false,false,false,false,false,];
    boolEmojis3 = [false,false,false,false,false,false,false,false,];
    boolEmojis4 = [false,false,false,false,false,false,false,false,];
    boolEmojis5 = [false,false,false,false,false,false,false,false,];
    boolEmojis6 = [false,false,false,false,false,false,false,false,];
    boolEmojis7 = [false,false,false,false,false,false,false,false,];
    boolEmojis8 = [false,false,false,false,false,false,false,false,];
    boolEmojis9 = [false,false,false,false,false,false,false,false,];
    boolEmojis10 = [false,false,false,false,false,false,false,false,];
    boolEmojis11 = [false,false,false,false,false,false,false,false,];
    boolEmojis12 = [false,false,false,false,false,false,false,false,];
    boolEmojis13 = [false,false,false,false,false,false,false,false,];
    boolEmojis14 = [false,false,false,false,false,false,false,false,];
    boolEmojis15 = [false,false,false,false,false,false,false,false,];
    focusNodesTouchPoints = List.generate(15, (i) => FocusNode());
    focusEnableTouchPoints = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,];
    focusNodesCustomerThoughts = List.generate(15, (i) => FocusNode());
    focusEnableCustomerThoughts = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,];
    focusNodesCustomerExperience = List.generate(15, (i) => FocusNode());
    focusEnableCustomerExperience = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,];
    focusNodesPainPoint = List.generate(15, (i) => FocusNode());
    focusEnablePainPoint = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,];
  }
//  @override
//  void dispose() {
//    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: statusDrawer == true ? StatusDrawerTeam() : ProfileDrawerCommon(),
      body: WillPopScope(
        onWillPop: () => showAlertDialog(context),
        child: GestureDetector(
          onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
          child: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: buildName2Widget(context))),
                    SizedBox(height: 40,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                buildTouchPointRow(context),
                                SizedBox(height: 30,),
                                buildCustomerThoughtsRow(context),
                                SizedBox(height: 30,),
                                buildCustomerExperienceRow(context),
                                SizedBox(height: 30,),
                                buildPainPointsRow(context),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                counter++;
                              });
                            },
                            child: Container(
                              width: 45,
                              height: 465,
                              decoration: BoxDecoration(
                                //color: Color(0xff787cd1),
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Text("Add Column",
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 16,
                                        color: Color(0xff787cd1),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 40,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          saveButton(context),
                          newPersonaButton(context),
                        ],
                      ),
                    ),
                    SizedBox(height: 40,),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: buildNextButton(context))),
                    SizedBox(height: 40,),
                  ],
                ),
              ),
              Positioned(
                top: 80, right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: statusBarDrawer(context),
                ),
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
          onPressed: (){
            //Navigator.of(context).pop();
            showAlertDialog(context);
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
      child: Text(empathize.finalPainPointHint1,
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

  Widget buildTouchPointRow(BuildContext context){
    return Container(
      height: 95,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: counter,
        itemBuilder: (context, i) => i == 0 ? Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Container(
            height: 95,
            width: 127,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: Text(empathize.touchPoints,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                    textStyle: TextStyle(
                      color: Color(0xff787cd1),
                      fontSize: 20,
                    )
                ),
              ),
            ),
          ),
        ) : Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Container(
            height: 95,
            width: 254,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  maxLines: 2,
                  focusNode: focusNodesTouchPoints[i],
                  textInputAction: TextInputAction.done,
                  controller: _controllerListTouchPoints[i],
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Receives an introductory set of emails and connect request on linkedIn"
                  ),
                  validator: (val){
                    if(val.isEmpty){
                      return 'Touch Point cannot be empty!';
                    }
                    return null;
                  },
                  onChanged: (val){
                    //focusNodesTouchPoints[i].unfocus();
                    if(_controllerListTouchPoints[i].text.toString() == null || _controllerListTouchPoints[i].text.toString() == "" || _controllerListTouchPoints[i].text.toString() == " "){

                    }else{
                      setState(() {
                        empathize.selectedTouchPointController = _controllerListTouchPoints[i].text.toString();
                      });
                      print(empathize.selectedTouchPointController);
                      if(touchPointIdListStorage[i] == "x"){
                        inputPainPointsApiProvider.uploadTouchPoints(context).whenComplete((){
                          Future.delayed(const Duration(seconds: 0), () {
                            touchPointIdListStorage.insert(i, empathize.receivedTouchPointIdSingle);
                            print(touchPointIdListStorage.toList());
                          });
                        });
                      }else{
                        setState(() {
                          empathize.selectedTouchPointId = touchPointIdListStorage[i].toString();
                        });
                        print(empathize.selectedTouchPointId);
                        inputPainPointsApiProvider.updateTouchPoints(context).whenComplete((){

                        });
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCustomerThoughtsRow(BuildContext context){
    return Container(
      height: 95,
      child: Container(
        height: 95,
        //width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: counter,
          itemBuilder: (context, i) => i == 0 ? Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Container(
              height: 95,
              width: 127,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text(empathize.customerThoughts,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                        color: Color(0xff787cd1),
                        fontSize: 20,
                      )
                  ),
                ),
              ),
            ),
          ) : Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Container(
              height: 95,
              width: 254,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    maxLines: 2,
                    focusNode: focusNodesCustomerThoughts[i],
                    controller: _controllerListCustomerThoughts[i],
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Receives an introductory set of emails and connect request on linkedIn"
                    ),
                    validator: (val){
                      if(val.isEmpty){
                        return 'Customer Thought cannot be empty!';
                      }
                      return null;
                    },
                    onChanged: (val){
                      //focusNodesCustomerThoughts[i].unfocus();
                      if(_controllerListCustomerThoughts[i].text.toString() == null || _controllerListCustomerThoughts[i].text.toString() == "" || _controllerListCustomerThoughts[i].text.toString() == " "){

                      }else{
                        setState(() {
                          empathize.selectedCustomerThoughtController = _controllerListCustomerThoughts[i].text.toString();
                          empathize.selectedTouchPointId = touchPointIdListStorage[i];
                        });
                        print(empathize.selectedCustomerThoughtController);
                        if(customerThoughtIdListStorage[i] == "x"){
                          inputPainPointsApiProvider.uploadCustomerThoughts(context).whenComplete((){
                            Future.delayed(const Duration(seconds: 3), () {
                              customerThoughtIdListStorage.insert(i, empathize.receivedCustomerThoughtIdSingle);
                              print(customerThoughtIdListStorage.toList());
                            });
                          });
                        }else{
                          setState(() {
                            empathize.selectedTouchPointId = customerThoughtIdListStorage[i].toString();
                          });
                          print(empathize.selectedTouchPointId);
                          inputPainPointsApiProvider.updateCustomerThoughts(context).whenComplete((){

                          });
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCustomerExperienceRow(BuildContext context){
    return Container(
      height: 95,
      child: Container(
        height: 95,
        //width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: counter,
          itemBuilder: (context, i) => i == 0 ? Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Container(
              height: 95,
              width: 127,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text(empathize.customerExperience,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                        color: Color(0xff787cd1),
                        fontSize: 20,
                      )
                  ),
                ),
              ),
            ),
          )  : Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Container(
              height: 95,
              width: 254,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child:
                  i == 1 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis1[0] = !boolEmojis1[0];
                                boolEmojis1[1] = false;
                                boolEmojis1[2] = false;
                                boolEmojis1[3] = false;
                                boolEmojis1[4] = false;
                                boolEmojis1[5] = false;
                                boolEmojis1[6] = false;
                                boolEmojis1[7] = false;
                                selectedEmoji = emojiList1[0];
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[1];
                              });
                              print(boolEmojis1[0]);
                              print(empathize.selectedCustomerExperienceController);
                              print(empathize.selectedTouchPointId);
                              if(customerExperienceIdListStorage[1] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis1[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList1[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList1[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis1[1] = !boolEmojis1[1];
                                boolEmojis1[0] = false;
                                boolEmojis1[2] = false;
                                boolEmojis1[3] = false;
                                boolEmojis1[4] = false;
                                boolEmojis1[5] = false;
                                boolEmojis1[6] = false;
                                boolEmojis1[7] = false;
                                selectedEmoji = emojiList1[1];
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[1];
                              });
                              print(boolEmojis1[1]);
                              print(selectedEmoji);
                              if(customerExperienceIdListStorage[1] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis1[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList1[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList1[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis1[2] = !boolEmojis1[2];
                                boolEmojis1[1] = false;
                                boolEmojis1[0] = false;
                                boolEmojis1[3] = false;
                                boolEmojis1[4] = false;
                                boolEmojis1[5] = false;
                                boolEmojis1[6] = false;
                                boolEmojis1[7] = false;
                                selectedEmoji = emojiList1[2];
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[1];
                              });
                              print(boolEmojis1[2]);
                              print(selectedEmoji);
                              if(customerExperienceIdListStorage[1] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis1[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList1[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList1[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis1[3] = !boolEmojis1[3];
                                boolEmojis1[1] = false;
                                boolEmojis1[2] = false;
                                boolEmojis1[0] = false;
                                boolEmojis1[4] = false;
                                boolEmojis1[5] = false;
                                boolEmojis1[6] = false;
                                boolEmojis1[7] = false;
                                selectedEmoji = emojiList1[3];
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[1];
                              });
                              print(boolEmojis1[3]);
                              print(selectedEmoji);
                              if(customerExperienceIdListStorage[1] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis1[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList1[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList1[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis1[4] = !boolEmojis1[4];
                                boolEmojis1[1] = false;
                                boolEmojis1[2] = false;
                                boolEmojis1[3] = false;
                                boolEmojis1[0] = false;
                                boolEmojis1[5] = false;
                                boolEmojis1[6] = false;
                                boolEmojis1[7] = false;
                                selectedEmoji = emojiList1[4];
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[1];
                              });
                              print(boolEmojis1[4]);
                              print(selectedEmoji);
                              if(customerExperienceIdListStorage[1] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis1[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList1[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList1[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis1[5] = !boolEmojis1[5];
                                boolEmojis1[1] = false;
                                boolEmojis1[2] = false;
                                boolEmojis1[3] = false;
                                boolEmojis1[4] = false;
                                boolEmojis1[0] = false;
                                boolEmojis1[6] = false;
                                boolEmojis1[7] = false;
                                selectedEmoji = emojiList1[5];
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[1];
                              });
                              print(boolEmojis1[5]);
                              print(selectedEmoji);
                              if(customerExperienceIdListStorage[1] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis1[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList1[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList1[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis1[6] = !boolEmojis1[6];
                                boolEmojis1[1] = false;
                                boolEmojis1[2] = false;
                                boolEmojis1[3] = false;
                                boolEmojis1[4] = false;
                                boolEmojis1[5] = false;
                                boolEmojis1[0] = false;
                                boolEmojis1[7] = false;
                                selectedEmoji = emojiList1[6];
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[1];
                              });
                              print(boolEmojis1[6]);
                              print(selectedEmoji);
                              if(customerExperienceIdListStorage[1] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis1[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList1[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList1[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis1[7] = !boolEmojis1[7];
                                boolEmojis1[1] = false;
                                boolEmojis1[2] = false;
                                boolEmojis1[3] = false;
                                boolEmojis1[4] = false;
                                boolEmojis1[5] = false;
                                boolEmojis1[6] = false;
                                boolEmojis1[0] = false;
                                selectedEmoji = emojiList1[7];
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[1];
                              });
                              print(empathize.selectedCustomerExperienceController);
                              print(empathize.selectedTouchPointId);
                              if(customerExperienceIdListStorage[1] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis1[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList1[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList1[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  i == 2 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis2[0] = !boolEmojis2[0];
                                boolEmojis2[1] = false;
                                boolEmojis2[2] = false;
                                boolEmojis2[3] = false;
                                boolEmojis2[4] = false;
                                boolEmojis2[5] = false;
                                boolEmojis2[6] = false;
                                boolEmojis2[7] = false;
                                selectedEmoji = emojiList2[0];
                              });
                              print(boolEmojis2[0]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[2];
                              });
                              if(customerExperienceIdListStorage[2] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis2[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList2[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList2[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis2[1] = !boolEmojis2[1];
                                boolEmojis2[0] = false;
                                boolEmojis2[2] = false;
                                boolEmojis2[3] = false;
                                boolEmojis2[4] = false;
                                boolEmojis2[5] = false;
                                boolEmojis2[6] = false;
                                boolEmojis2[7] = false;
                                selectedEmoji = emojiList2[1];
                              });
                              print(boolEmojis2[1]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[2];
                              });
                              if(customerExperienceIdListStorage[2] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis2[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList2[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList2[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis2[2] = !boolEmojis2[2];
                                boolEmojis2[1] = false;
                                boolEmojis2[0] = false;
                                boolEmojis2[3] = false;
                                boolEmojis2[4] = false;
                                boolEmojis2[5] = false;
                                boolEmojis2[6] = false;
                                boolEmojis2[7] = false;
                                selectedEmoji = emojiList2[2];
                              });
                              print(boolEmojis2[2]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[2];
                              });
                              if(customerExperienceIdListStorage[2] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis2[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList2[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList2[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis2[3] = !boolEmojis2[3];
                                boolEmojis2[1] = false;
                                boolEmojis2[2] = false;
                                boolEmojis2[0] = false;
                                boolEmojis2[4] = false;
                                boolEmojis2[5] = false;
                                boolEmojis2[6] = false;
                                boolEmojis2[7] = false;
                                selectedEmoji = emojiList2[3];
                              });
                              print(boolEmojis2[3]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[2];
                              });
                              if(customerExperienceIdListStorage[2] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis2[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList2[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList2[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis2[4] = !boolEmojis2[4];
                                boolEmojis2[1] = false;
                                boolEmojis2[2] = false;
                                boolEmojis2[3] = false;
                                boolEmojis2[0] = false;
                                boolEmojis2[5] = false;
                                boolEmojis2[6] = false;
                                boolEmojis2[7] = false;
                                selectedEmoji = emojiList2[4];
                              });
                              print(boolEmojis2[4]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[2];
                              });
                              if(customerExperienceIdListStorage[2] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis2[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList2[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList2[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis2[5] = !boolEmojis2[5];
                                boolEmojis2[1] = false;
                                boolEmojis2[2] = false;
                                boolEmojis2[3] = false;
                                boolEmojis2[4] = false;
                                boolEmojis2[0] = false;
                                boolEmojis2[6] = false;
                                boolEmojis2[7] = false;
                                selectedEmoji = emojiList2[5];
                              });
                              print(boolEmojis2[5]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[2];
                              });
                              if(customerExperienceIdListStorage[2] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis2[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList2[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList2[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis2[6] = !boolEmojis2[6];
                                boolEmojis2[1] = false;
                                boolEmojis2[2] = false;
                                boolEmojis2[3] = false;
                                boolEmojis2[4] = false;
                                boolEmojis2[5] = false;
                                boolEmojis2[0] = false;
                                boolEmojis2[7] = false;
                                selectedEmoji = emojiList2[6];
                              });
                              print(boolEmojis2[6]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[2];
                              });
                              if(customerExperienceIdListStorage[2] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis2[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList2[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList2[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis2[7] = !boolEmojis2[7];
                                boolEmojis2[1] = false;
                                boolEmojis2[2] = false;
                                boolEmojis2[3] = false;
                                boolEmojis2[4] = false;
                                boolEmojis2[5] = false;
                                boolEmojis2[6] = false;
                                boolEmojis2[0] = false;
                                selectedEmoji = emojiList2[7];
                              });
                              print(boolEmojis2[7]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[2];
                              });
                              if(customerExperienceIdListStorage[2] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis2[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList2[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList2[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  i == 3 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis3[0] = !boolEmojis3[0];
                                boolEmojis3[1] = false;
                                boolEmojis3[2] = false;
                                boolEmojis3[3] = false;
                                boolEmojis3[4] = false;
                                boolEmojis3[5] = false;
                                boolEmojis3[6] = false;
                                boolEmojis3[7] = false;
                                selectedEmoji = emojiList3[0];
                              });
                              print(boolEmojis3[0]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[3];
                              });
                              if(customerExperienceIdListStorage[3] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis3[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList3[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList3[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis3[1] = !boolEmojis3[1];
                                boolEmojis3[0] = false;
                                boolEmojis3[2] = false;
                                boolEmojis3[3] = false;
                                boolEmojis3[4] = false;
                                boolEmojis3[5] = false;
                                boolEmojis3[6] = false;
                                boolEmojis3[7] = false;
                                selectedEmoji = emojiList3[1];
                              });
                              print(boolEmojis3[1]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[3];
                              });
                              if(customerExperienceIdListStorage[3] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis3[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList3[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList3[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis3[2] = !boolEmojis3[2];
                                boolEmojis3[1] = false;
                                boolEmojis3[0] = false;
                                boolEmojis3[3] = false;
                                boolEmojis3[4] = false;
                                boolEmojis3[5] = false;
                                boolEmojis3[6] = false;
                                boolEmojis3[7] = false;
                                selectedEmoji = emojiList3[2];
                              });
                              print(boolEmojis3[2]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[3];
                              });
                              if(customerExperienceIdListStorage[3] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis3[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList3[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList3[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis3[3] = !boolEmojis3[3];
                                boolEmojis3[1] = false;
                                boolEmojis3[2] = false;
                                boolEmojis3[0] = false;
                                boolEmojis3[4] = false;
                                boolEmojis3[5] = false;
                                boolEmojis3[6] = false;
                                boolEmojis3[7] = false;
                                selectedEmoji = emojiList3[3];
                              });
                              print(boolEmojis3[3]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[3];
                              });
                              if(customerExperienceIdListStorage[3] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis3[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList3[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList3[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis3[4] = !boolEmojis3[4];
                                boolEmojis3[1] = false;
                                boolEmojis3[2] = false;
                                boolEmojis3[3] = false;
                                boolEmojis3[0] = false;
                                boolEmojis3[5] = false;
                                boolEmojis3[6] = false;
                                boolEmojis3[7] = false;
                                selectedEmoji = emojiList3[4];
                              });
                              print(boolEmojis3[4]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[3];
                              });
                              if(customerExperienceIdListStorage[3] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis3[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList3[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList3[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis3[5] = !boolEmojis3[5];
                                boolEmojis3[1] = false;
                                boolEmojis3[2] = false;
                                boolEmojis3[3] = false;
                                boolEmojis3[4] = false;
                                boolEmojis3[0] = false;
                                boolEmojis3[6] = false;
                                boolEmojis3[7] = false;
                                selectedEmoji = emojiList3[5];
                              });
                              print(boolEmojis3[5]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[3];
                              });
                              if(customerExperienceIdListStorage[3] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis3[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList3[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList3[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis3[6] = !boolEmojis3[6];
                                boolEmojis3[1] = false;
                                boolEmojis3[2] = false;
                                boolEmojis3[3] = false;
                                boolEmojis3[4] = false;
                                boolEmojis3[5] = false;
                                boolEmojis3[0] = false;
                                boolEmojis3[7] = false;
                                selectedEmoji = emojiList3[6];
                              });
                              print(boolEmojis3[6]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[3];
                              });
                              if(customerExperienceIdListStorage[3] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis3[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList3[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList3[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis3[7] = !boolEmojis3[7];
                                boolEmojis3[1] = false;
                                boolEmojis3[2] = false;
                                boolEmojis3[3] = false;
                                boolEmojis3[4] = false;
                                boolEmojis3[5] = false;
                                boolEmojis3[6] = false;
                                boolEmojis3[0] = false;
                                selectedEmoji = emojiList3[7];
                              });
                              print(boolEmojis3[7]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[3];
                              });
                              if(customerExperienceIdListStorage[3] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis3[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList3[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList3[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  i == 4 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis4[0] = !boolEmojis4[0];
                                boolEmojis4[1] = false;
                                boolEmojis4[2] = false;
                                boolEmojis4[3] = false;
                                boolEmojis4[4] = false;
                                boolEmojis4[5] = false;
                                boolEmojis4[6] = false;
                                boolEmojis4[7] = false;
                                selectedEmoji = emojiList4[0];
                              });
                              print(boolEmojis4[0]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              if(customerExperienceIdListStorage[4] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis4[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList4[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList4[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis4[1] = !boolEmojis4[1];
                                boolEmojis4[0] = false;
                                boolEmojis4[2] = false;
                                boolEmojis4[3] = false;
                                boolEmojis4[4] = false;
                                boolEmojis4[5] = false;
                                boolEmojis4[6] = false;
                                boolEmojis4[7] = false;
                                selectedEmoji = emojiList4[1];
                              });
                              print(boolEmojis4[1]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              if(customerExperienceIdListStorage[4] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis4[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList4[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList4[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis4[2] = !boolEmojis4[2];
                                boolEmojis4[1] = false;
                                boolEmojis4[0] = false;
                                boolEmojis4[3] = false;
                                boolEmojis4[4] = false;
                                boolEmojis4[5] = false;
                                boolEmojis4[6] = false;
                                boolEmojis4[7] = false;
                                selectedEmoji = emojiList4[2];
                              });
                              print(boolEmojis4[2]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              if(customerExperienceIdListStorage[4] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis4[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList4[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList4[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis4[3] = !boolEmojis4[3];
                                boolEmojis4[1] = false;
                                boolEmojis4[2] = false;
                                boolEmojis4[0] = false;
                                boolEmojis4[4] = false;
                                boolEmojis4[5] = false;
                                boolEmojis4[6] = false;
                                boolEmojis4[7] = false;
                                selectedEmoji = emojiList4[3];
                              });
                              print(boolEmojis4[3]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              if(customerExperienceIdListStorage[4] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis4[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList4[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList4[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis4[4] = !boolEmojis4[4];
                                boolEmojis4[1] = false;
                                boolEmojis4[2] = false;
                                boolEmojis4[3] = false;
                                boolEmojis4[0] = false;
                                boolEmojis4[5] = false;
                                boolEmojis4[6] = false;
                                boolEmojis4[7] = false;
                                selectedEmoji = emojiList4[4];
                              });
                              print(boolEmojis4[4]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              if(customerExperienceIdListStorage[4] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis4[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList4[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList4[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis4[5] = !boolEmojis4[5];
                                boolEmojis4[1] = false;
                                boolEmojis4[2] = false;
                                boolEmojis4[3] = false;
                                boolEmojis4[4] = false;
                                boolEmojis4[0] = false;
                                boolEmojis4[6] = false;
                                boolEmojis4[7] = false;
                                selectedEmoji = emojiList4[5];
                              });
                              print(boolEmojis4[5]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              if(customerExperienceIdListStorage[4] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis4[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList4[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList4[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis4[6] = !boolEmojis4[6];
                                boolEmojis4[1] = false;
                                boolEmojis4[2] = false;
                                boolEmojis4[3] = false;
                                boolEmojis4[4] = false;
                                boolEmojis4[5] = false;
                                boolEmojis4[0] = false;
                                boolEmojis4[7] = false;
                                selectedEmoji = emojiList4[6];
                              });
                              print(boolEmojis4[6]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              if(customerExperienceIdListStorage[4] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis4[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList4[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList4[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis4[7] = !boolEmojis4[7];
                                boolEmojis4[1] = false;
                                boolEmojis4[2] = false;
                                boolEmojis4[3] = false;
                                boolEmojis4[4] = false;
                                boolEmojis4[5] = false;
                                boolEmojis4[6] = false;
                                boolEmojis4[0] = false;
                                selectedEmoji = emojiList4[7];
                              });
                              print(boolEmojis4[7]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              if(customerExperienceIdListStorage[4] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis4[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList4[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList4[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  i == 5 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[0] = !boolEmojis5[0];
                                boolEmojis5[1] = false;
                                boolEmojis5[2] = false;
                                boolEmojis5[3] = false;
                                boolEmojis5[4] = false;
                                boolEmojis5[5] = false;
                                boolEmojis5[6] = false;
                                boolEmojis5[7] = false;
                                selectedEmoji = emojiList5[0];
                              });
                              print(boolEmojis5[0]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[5];
                              });
                              if(customerExperienceIdListStorage[5] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis5[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[1] = !boolEmojis5[1];
                                boolEmojis5[0] = false;
                                boolEmojis5[2] = false;
                                boolEmojis5[3] = false;
                                boolEmojis5[4] = false;
                                boolEmojis5[5] = false;
                                boolEmojis5[6] = false;
                                boolEmojis5[7] = false;
                                selectedEmoji = emojiList5[1];
                              });
                              print(boolEmojis5[1]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[5];
                              });
                              if(customerExperienceIdListStorage[5] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis5[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[2] = !boolEmojis5[2];
                                boolEmojis5[1] = false;
                                boolEmojis5[0] = false;
                                boolEmojis5[3] = false;
                                boolEmojis5[4] = false;
                                boolEmojis5[5] = false;
                                boolEmojis5[6] = false;
                                boolEmojis5[7] = false;
                                selectedEmoji = emojiList5[2];
                              });
                              print(boolEmojis5[2]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[5];
                              });
                              if(customerExperienceIdListStorage[5] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis5[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[3] = !boolEmojis5[3];
                                boolEmojis5[1] = false;
                                boolEmojis5[2] = false;
                                boolEmojis5[0] = false;
                                boolEmojis5[4] = false;
                                boolEmojis5[5] = false;
                                boolEmojis5[6] = false;
                                boolEmojis5[7] = false;
                                selectedEmoji = emojiList5[3];
                              });
                              print(boolEmojis5[3]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[5];
                              });
                              if(customerExperienceIdListStorage[5] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis5[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[4] = !boolEmojis5[4];
                                boolEmojis5[1] = false;
                                boolEmojis5[2] = false;
                                boolEmojis5[3] = false;
                                boolEmojis5[0] = false;
                                boolEmojis5[5] = false;
                                boolEmojis5[6] = false;
                                boolEmojis5[7] = false;
                                selectedEmoji = emojiList5[4];
                              });
                              print(boolEmojis5[4]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[5];
                              });
                              if(customerExperienceIdListStorage[5] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis5[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[5] = !boolEmojis5[5];
                                boolEmojis5[1] = false;
                                boolEmojis5[2] = false;
                                boolEmojis5[3] = false;
                                boolEmojis5[4] = false;
                                boolEmojis5[0] = false;
                                boolEmojis5[6] = false;
                                boolEmojis5[7] = false;
                                selectedEmoji = emojiList5[5];
                              });
                              print(boolEmojis5[5]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[5];
                              });
                              if(customerExperienceIdListStorage[5] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis5[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[6] = !boolEmojis5[6];
                                boolEmojis5[1] = false;
                                boolEmojis5[2] = false;
                                boolEmojis5[3] = false;
                                boolEmojis5[4] = false;
                                boolEmojis5[5] = false;
                                boolEmojis5[0] = false;
                                boolEmojis5[7] = false;
                                selectedEmoji = emojiList5[6];
                              });
                              print(boolEmojis5[6]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[5];
                              });
                              if(customerExperienceIdListStorage[5] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis5[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[7] = !boolEmojis5[7];
                                boolEmojis5[1] = false;
                                boolEmojis5[2] = false;
                                boolEmojis5[3] = false;
                                boolEmojis5[4] = false;
                                boolEmojis5[5] = false;
                                boolEmojis5[6] = false;
                                boolEmojis5[0] = false;
                                selectedEmoji = emojiList5[7];
                              });
                              print(boolEmojis5[7]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[5];
                              });
                              if(customerExperienceIdListStorage[5] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis5[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  i == 6 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis6[0] = !boolEmojis6[0];
                                boolEmojis6[1] = false;
                                boolEmojis6[2] = false;
                                boolEmojis6[3] = false;
                                boolEmojis6[4] = false;
                                boolEmojis6[5] = false;
                                boolEmojis6[6] = false;
                                boolEmojis6[7] = false;
                                selectedEmoji = emojiList6[0];
                              });
                              print(boolEmojis6[0]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[6];
                              });
                              if(customerExperienceIdListStorage[6] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis6[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList6[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList6[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis6[1] = !boolEmojis6[1];
                                boolEmojis6[0] = false;
                                boolEmojis6[2] = false;
                                boolEmojis6[3] = false;
                                boolEmojis6[4] = false;
                                boolEmojis6[5] = false;
                                boolEmojis6[6] = false;
                                boolEmojis6[7] = false;
                                selectedEmoji = emojiList6[1];
                              });
                              print(boolEmojis6[1]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[6];
                              });
                              if(customerExperienceIdListStorage[6] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis6[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList6[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList6[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis6[2] = !boolEmojis6[2];
                                boolEmojis6[1] = false;
                                boolEmojis6[0] = false;
                                boolEmojis6[3] = false;
                                boolEmojis6[4] = false;
                                boolEmojis6[5] = false;
                                boolEmojis6[6] = false;
                                boolEmojis6[7] = false;
                                selectedEmoji = emojiList6[2];
                              });
                              print(boolEmojis6[2]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[6];
                              });
                              if(customerExperienceIdListStorage[6] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis6[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList6[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList6[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis6[3] = !boolEmojis6[3];
                                boolEmojis6[1] = false;
                                boolEmojis6[2] = false;
                                boolEmojis6[0] = false;
                                boolEmojis6[4] = false;
                                boolEmojis6[5] = false;
                                boolEmojis6[6] = false;
                                boolEmojis6[7] = false;
                                selectedEmoji = emojiList6[3];
                              });
                              print(boolEmojis6[3]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[6];
                              });
                              if(customerExperienceIdListStorage[6] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis6[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList6[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList6[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis6[4] = !boolEmojis6[4];
                                boolEmojis6[1] = false;
                                boolEmojis6[2] = false;
                                boolEmojis6[3] = false;
                                boolEmojis6[0] = false;
                                boolEmojis6[5] = false;
                                boolEmojis6[6] = false;
                                boolEmojis6[7] = false;
                                selectedEmoji = emojiList6[4];
                              });
                              print(boolEmojis6[4]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[6];
                              });
                              if(customerExperienceIdListStorage[6] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis6[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList6[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList6[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis6[5] = !boolEmojis6[5];
                                boolEmojis6[1] = false;
                                boolEmojis6[2] = false;
                                boolEmojis6[3] = false;
                                boolEmojis6[4] = false;
                                boolEmojis6[0] = false;
                                boolEmojis6[6] = false;
                                boolEmojis6[7] = false;
                                selectedEmoji = emojiList6[5];
                              });
                              print(boolEmojis6[5]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[6];
                              });
                              if(customerExperienceIdListStorage[6] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis6[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList6[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList6[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis6[6] = !boolEmojis6[6];
                                boolEmojis6[1] = false;
                                boolEmojis6[2] = false;
                                boolEmojis6[3] = false;
                                boolEmojis6[4] = false;
                                boolEmojis6[5] = false;
                                boolEmojis6[0] = false;
                                boolEmojis6[7] = false;
                                selectedEmoji = emojiList6[6];
                              });
                              print(boolEmojis6[6]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[6];
                              });
                              if(customerExperienceIdListStorage[6] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis6[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList6[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList6[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis6[7] = !boolEmojis6[7];
                                boolEmojis6[1] = false;
                                boolEmojis6[2] = false;
                                boolEmojis6[3] = false;
                                boolEmojis6[4] = false;
                                boolEmojis6[5] = false;
                                boolEmojis6[6] = false;
                                boolEmojis6[0] = false;
                                selectedEmoji = emojiList6[7];
                              });
                              print(boolEmojis6[7]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[6];
                              });
                              if(customerExperienceIdListStorage[6] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis6[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList6[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList6[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  i == 7 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis7[0] = !boolEmojis7[0];
                                boolEmojis7[1] = false;
                                boolEmojis7[2] = false;
                                boolEmojis7[3] = false;
                                boolEmojis7[4] = false;
                                boolEmojis7[5] = false;
                                boolEmojis7[6] = false;
                                boolEmojis7[7] = false;
                                selectedEmoji = emojiList7[0];
                              });
                              print(boolEmojis7[0]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[7];
                              });
                              if(customerExperienceIdListStorage[7] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis7[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList7[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList7[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis7[1] = !boolEmojis7[1];
                                boolEmojis7[0] = false;
                                boolEmojis7[2] = false;
                                boolEmojis7[3] = false;
                                boolEmojis7[4] = false;
                                boolEmojis7[5] = false;
                                boolEmojis7[6] = false;
                                boolEmojis7[7] = false;
                                selectedEmoji = emojiList7[1];
                              });
                              print(boolEmojis7[1]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[7];
                              });
                              if(customerExperienceIdListStorage[7] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis7[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList7[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList7[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis7[2] = !boolEmojis7[2];
                                boolEmojis7[1] = false;
                                boolEmojis7[0] = false;
                                boolEmojis7[3] = false;
                                boolEmojis7[4] = false;
                                boolEmojis7[5] = false;
                                boolEmojis7[6] = false;
                                boolEmojis7[7] = false;
                                selectedEmoji = emojiList7[2];
                              });
                              print(boolEmojis7[2]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[7];
                              });
                              if(customerExperienceIdListStorage[7] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis7[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList7[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList7[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis7[3] = !boolEmojis7[3];
                                boolEmojis7[1] = false;
                                boolEmojis7[2] = false;
                                boolEmojis7[0] = false;
                                boolEmojis7[4] = false;
                                boolEmojis7[5] = false;
                                boolEmojis7[6] = false;
                                boolEmojis7[7] = false;
                                selectedEmoji = emojiList7[3];
                              });
                              print(boolEmojis7[3]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[7];
                              });
                              if(customerExperienceIdListStorage[7] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis7[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList7[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList7[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis7[4] = !boolEmojis7[4];
                                boolEmojis7[1] = false;
                                boolEmojis7[2] = false;
                                boolEmojis7[3] = false;
                                boolEmojis7[0] = false;
                                boolEmojis7[5] = false;
                                boolEmojis7[6] = false;
                                boolEmojis7[7] = false;
                                selectedEmoji = emojiList7[4];
                              });
                              print(boolEmojis7[4]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[7];
                              });
                              if(customerExperienceIdListStorage[7] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis7[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList7[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList7[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis7[5] = !boolEmojis7[5];
                                boolEmojis7[1] = false;
                                boolEmojis7[2] = false;
                                boolEmojis7[3] = false;
                                boolEmojis7[4] = false;
                                boolEmojis7[0] = false;
                                boolEmojis7[6] = false;
                                boolEmojis7[7] = false;
                                selectedEmoji = emojiList7[5];
                              });
                              print(boolEmojis7[5]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[7];
                              });
                              if(customerExperienceIdListStorage[7] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis7[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList7[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList7[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis7[6] = !boolEmojis7[6];
                                boolEmojis7[1] = false;
                                boolEmojis7[2] = false;
                                boolEmojis7[3] = false;
                                boolEmojis7[4] = false;
                                boolEmojis7[5] = false;
                                boolEmojis7[0] = false;
                                boolEmojis7[7] = false;
                                selectedEmoji = emojiList7[6];
                              });
                              print(boolEmojis7[6]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[7];
                              });
                              if(customerExperienceIdListStorage[7] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis7[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList7[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList7[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis7[7] = !boolEmojis7[7];
                                boolEmojis7[1] = false;
                                boolEmojis7[2] = false;
                                boolEmojis7[3] = false;
                                boolEmojis7[4] = false;
                                boolEmojis7[5] = false;
                                boolEmojis7[6] = false;
                                boolEmojis7[0] = false;
                                selectedEmoji = emojiList7[7];
                              });
                              print(boolEmojis7[7]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[7];
                              });
                              if(customerExperienceIdListStorage[7] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis7[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList7[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList7[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  i == 8 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis8[0] = !boolEmojis8[0];
                                boolEmojis8[1] = false;
                                boolEmojis8[2] = false;
                                boolEmojis8[3] = false;
                                boolEmojis8[4] = false;
                                boolEmojis8[5] = false;
                                boolEmojis8[6] = false;
                                boolEmojis8[7] = false;
                                selectedEmoji = emojiList8[0];
                              });
                              print(boolEmojis8[0]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[8];
                              });
                              if(customerExperienceIdListStorage[8] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis8[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList8[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList8[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis8[1] = !boolEmojis8[1];
                                boolEmojis8[0] = false;
                                boolEmojis8[2] = false;
                                boolEmojis8[3] = false;
                                boolEmojis8[4] = false;
                                boolEmojis8[5] = false;
                                boolEmojis8[6] = false;
                                boolEmojis8[7] = false;
                                selectedEmoji = emojiList8[1];
                              });
                              print(boolEmojis8[1]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[8];
                              });
                              if(customerExperienceIdListStorage[8] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis8[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList8[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList8[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis8[2] = !boolEmojis8[2];
                                boolEmojis8[1] = false;
                                boolEmojis8[0] = false;
                                boolEmojis8[3] = false;
                                boolEmojis8[4] = false;
                                boolEmojis8[5] = false;
                                boolEmojis8[6] = false;
                                boolEmojis8[7] = false;
                                selectedEmoji = emojiList8[2];
                              });
                              print(boolEmojis8[2]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[8];
                              });
                              if(customerExperienceIdListStorage[8] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis8[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList8[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList8[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis8[3] = !boolEmojis8[3];
                                boolEmojis8[1] = false;
                                boolEmojis8[2] = false;
                                boolEmojis8[0] = false;
                                boolEmojis8[4] = false;
                                boolEmojis8[5] = false;
                                boolEmojis8[6] = false;
                                boolEmojis8[7] = false;
                                selectedEmoji = emojiList8[3];
                              });
                              print(boolEmojis8[3]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[8];
                              });
                              if(customerExperienceIdListStorage[8] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis8[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList8[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList8[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis8[4] = !boolEmojis8[4];
                                boolEmojis8[1] = false;
                                boolEmojis8[2] = false;
                                boolEmojis8[3] = false;
                                boolEmojis8[0] = false;
                                boolEmojis8[5] = false;
                                boolEmojis8[6] = false;
                                boolEmojis8[7] = false;
                                selectedEmoji = emojiList8[4];
                              });
                              print(boolEmojis8[4]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[8];
                              });
                              if(customerExperienceIdListStorage[8] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis8[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList8[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList8[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis8[5] = !boolEmojis8[5];
                                boolEmojis8[1] = false;
                                boolEmojis8[2] = false;
                                boolEmojis8[3] = false;
                                boolEmojis8[4] = false;
                                boolEmojis8[0] = false;
                                boolEmojis8[6] = false;
                                boolEmojis8[7] = false;
                                selectedEmoji = emojiList8[5];
                              });
                              print(boolEmojis8[5]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[8];
                              });
                              if(customerExperienceIdListStorage[8] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis8[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList8[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList8[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis8[6] = !boolEmojis8[6];
                                boolEmojis8[1] = false;
                                boolEmojis8[2] = false;
                                boolEmojis8[3] = false;
                                boolEmojis8[4] = false;
                                boolEmojis8[5] = false;
                                boolEmojis8[0] = false;
                                boolEmojis8[7] = false;
                                selectedEmoji = emojiList8[6];
                              });
                              print(boolEmojis8[6]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[8];
                              });
                              if(customerExperienceIdListStorage[8] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis8[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList8[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList8[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis8[7] = !boolEmojis8[7];
                                boolEmojis8[1] = false;
                                boolEmojis8[2] = false;
                                boolEmojis8[3] = false;
                                boolEmojis8[4] = false;
                                boolEmojis8[5] = false;
                                boolEmojis8[6] = false;
                                boolEmojis8[0] = false;
                                selectedEmoji = emojiList8[7];
                              });
                              print(boolEmojis8[7]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[8];
                              });
                              if(customerExperienceIdListStorage[8] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis8[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList8[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList8[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  i == 9 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis9[0] = !boolEmojis9[0];
                                boolEmojis9[1] = false;
                                boolEmojis9[2] = false;
                                boolEmojis9[3] = false;
                                boolEmojis9[4] = false;
                                boolEmojis9[5] = false;
                                boolEmojis9[6] = false;
                                boolEmojis9[7] = false;
                                selectedEmoji = emojiList9[0];
                              });
                              print(boolEmojis9[0]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[9];
                              });
                              if(customerExperienceIdListStorage[9] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis9[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList9[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList9[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis9[1] = !boolEmojis9[1];
                                boolEmojis9[0] = false;
                                boolEmojis9[2] = false;
                                boolEmojis9[3] = false;
                                boolEmojis9[4] = false;
                                boolEmojis9[5] = false;
                                boolEmojis9[6] = false;
                                boolEmojis9[7] = false;
                                selectedEmoji = emojiList9[1];
                              });
                              print(boolEmojis9[1]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[9];
                              });
                              if(customerExperienceIdListStorage[9] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis9[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList9[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList9[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis9[2] = !boolEmojis9[2];
                                boolEmojis9[1] = false;
                                boolEmojis9[0] = false;
                                boolEmojis9[3] = false;
                                boolEmojis9[4] = false;
                                boolEmojis9[5] = false;
                                boolEmojis9[6] = false;
                                boolEmojis9[7] = false;
                                selectedEmoji = emojiList9[2];
                              });
                              print(boolEmojis9[2]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[9];
                              });
                              if(customerExperienceIdListStorage[9] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis9[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList9[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList9[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis9[3] = !boolEmojis9[3];
                                boolEmojis9[1] = false;
                                boolEmojis9[2] = false;
                                boolEmojis9[0] = false;
                                boolEmojis9[4] = false;
                                boolEmojis9[5] = false;
                                boolEmojis9[6] = false;
                                boolEmojis9[7] = false;
                                selectedEmoji = emojiList9[3];
                              });
                              print(boolEmojis9[3]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[9];
                              });
                              if(customerExperienceIdListStorage[9] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis9[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList9[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList9[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis9[4] = !boolEmojis9[4];
                                boolEmojis9[1] = false;
                                boolEmojis9[2] = false;
                                boolEmojis9[3] = false;
                                boolEmojis9[0] = false;
                                boolEmojis9[5] = false;
                                boolEmojis9[6] = false;
                                boolEmojis9[7] = false;
                                selectedEmoji = emojiList9[4];
                              });
                              print(boolEmojis9[4]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[9];
                              });
                              if(customerExperienceIdListStorage[9] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis9[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList9[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList9[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis9[5] = !boolEmojis9[5];
                                boolEmojis9[1] = false;
                                boolEmojis9[2] = false;
                                boolEmojis9[3] = false;
                                boolEmojis9[4] = false;
                                boolEmojis9[0] = false;
                                boolEmojis9[6] = false;
                                boolEmojis9[7] = false;
                                selectedEmoji = emojiList9[5];
                              });
                              print(boolEmojis9[5]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[9];
                              });
                              if(customerExperienceIdListStorage[9] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis9[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList9[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList9[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis9[6] = !boolEmojis9[6];
                                boolEmojis9[1] = false;
                                boolEmojis9[2] = false;
                                boolEmojis9[3] = false;
                                boolEmojis9[4] = false;
                                boolEmojis9[5] = false;
                                boolEmojis9[0] = false;
                                boolEmojis9[7] = false;
                                selectedEmoji = emojiList9[6];
                              });
                              print(boolEmojis9[6]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[9];
                              });
                              if(customerExperienceIdListStorage[9] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis9[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList9[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList9[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis9[7] = !boolEmojis9[7];
                                boolEmojis9[1] = false;
                                boolEmojis9[2] = false;
                                boolEmojis9[3] = false;
                                boolEmojis9[4] = false;
                                boolEmojis9[5] = false;
                                boolEmojis9[6] = false;
                                boolEmojis9[0] = false;
                                selectedEmoji = emojiList9[7];
                              });
                              print(boolEmojis9[7]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[9];
                              });
                              if(customerExperienceIdListStorage[9] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis9[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList9[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList9[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  i == 10 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis10[0] = !boolEmojis10[0];
                                boolEmojis10[1] = false;
                                boolEmojis10[2] = false;
                                boolEmojis10[3] = false;
                                boolEmojis10[4] = false;
                                boolEmojis10[5] = false;
                                boolEmojis10[6] = false;
                                boolEmojis10[7] = false;
                                selectedEmoji = emojiList10[0];
                              });
                              print(boolEmojis10[0]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[10];
                              });
                              if(customerExperienceIdListStorage[10] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis10[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList10[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList10[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis10[1] = !boolEmojis10[1];
                                boolEmojis10[0] = false;
                                boolEmojis10[2] = false;
                                boolEmojis10[3] = false;
                                boolEmojis10[4] = false;
                                boolEmojis10[5] = false;
                                boolEmojis10[6] = false;
                                boolEmojis10[7] = false;
                                selectedEmoji = emojiList10[1];
                              });
                              print(boolEmojis10[1]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[10];
                              });
                              if(customerExperienceIdListStorage[10] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis10[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList10[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList10[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis10[2] = !boolEmojis10[2];
                                boolEmojis10[1] = false;
                                boolEmojis10[0] = false;
                                boolEmojis10[3] = false;
                                boolEmojis10[4] = false;
                                boolEmojis10[5] = false;
                                boolEmojis10[6] = false;
                                boolEmojis10[7] = false;
                                selectedEmoji = emojiList10[2];
                              });
                              print(boolEmojis10[2]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[10];
                              });
                              if(customerExperienceIdListStorage[10] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis10[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList10[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList10[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis10[3] = !boolEmojis10[3];
                                boolEmojis10[1] = false;
                                boolEmojis10[2] = false;
                                boolEmojis10[0] = false;
                                boolEmojis10[4] = false;
                                boolEmojis10[5] = false;
                                boolEmojis10[6] = false;
                                boolEmojis10[7] = false;
                                selectedEmoji = emojiList10[3];
                              });
                              print(boolEmojis10[3]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[10];
                              });
                              if(customerExperienceIdListStorage[10] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis10[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList10[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList10[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis10[4] = !boolEmojis10[4];
                                boolEmojis10[1] = false;
                                boolEmojis10[2] = false;
                                boolEmojis10[3] = false;
                                boolEmojis10[0] = false;
                                boolEmojis10[5] = false;
                                boolEmojis10[6] = false;
                                boolEmojis10[7] = false;
                                selectedEmoji = emojiList10[4];
                              });
                              print(boolEmojis10[4]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[10];
                              });
                              if(customerExperienceIdListStorage[10] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis10[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList10[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList10[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis10[5] = !boolEmojis10[5];
                                boolEmojis10[1] = false;
                                boolEmojis10[2] = false;
                                boolEmojis10[3] = false;
                                boolEmojis10[4] = false;
                                boolEmojis10[0] = false;
                                boolEmojis10[6] = false;
                                boolEmojis10[7] = false;
                                selectedEmoji = emojiList10[5];
                              });
                              print(boolEmojis10[5]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[10];
                              });
                              if(customerExperienceIdListStorage[10] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis10[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList10[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList10[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis10[6] = !boolEmojis10[6];
                                boolEmojis10[1] = false;
                                boolEmojis10[2] = false;
                                boolEmojis10[3] = false;
                                boolEmojis10[4] = false;
                                boolEmojis10[5] = false;
                                boolEmojis10[0] = false;
                                boolEmojis10[7] = false;
                                selectedEmoji = emojiList10[6];
                              });
                              print(boolEmojis10[6]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[10];
                              });
                              if(customerExperienceIdListStorage[10] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis10[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList10[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList10[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis10[7] = !boolEmojis10[7];
                                boolEmojis10[1] = false;
                                boolEmojis10[2] = false;
                                boolEmojis10[3] = false;
                                boolEmojis10[4] = false;
                                boolEmojis10[5] = false;
                                boolEmojis10[6] = false;
                                boolEmojis10[0] = false;
                                selectedEmoji = emojiList10[7];
                              });
                              print(boolEmojis10[7]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[10];
                              });
                              if(customerExperienceIdListStorage[10] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis10[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList10[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList10[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  i == 11 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis11[0] = !boolEmojis11[0];
                                boolEmojis11[1] = false;
                                boolEmojis11[2] = false;
                                boolEmojis11[3] = false;
                                boolEmojis11[4] = false;
                                boolEmojis11[5] = false;
                                boolEmojis11[6] = false;
                                boolEmojis11[7] = false;
                                selectedEmoji = emojiList11[0];
                              });
                              print(boolEmojis11[0]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[11];
                              });
                              if(customerExperienceIdListStorage[11] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis11[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList11[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList11[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis11[1] = !boolEmojis11[1];
                                boolEmojis11[0] = false;
                                boolEmojis11[2] = false;
                                boolEmojis11[3] = false;
                                boolEmojis11[4] = false;
                                boolEmojis11[5] = false;
                                boolEmojis11[6] = false;
                                boolEmojis11[7] = false;
                                selectedEmoji = emojiList11[1];
                              });
                              print(boolEmojis11[1]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[11];
                              });
                              if(customerExperienceIdListStorage[11] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis11[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList11[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList11[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis11[2] = !boolEmojis11[2];
                                boolEmojis11[1] = false;
                                boolEmojis11[0] = false;
                                boolEmojis11[3] = false;
                                boolEmojis11[4] = false;
                                boolEmojis11[5] = false;
                                boolEmojis11[6] = false;
                                boolEmojis11[7] = false;
                                selectedEmoji = emojiList11[2];
                              });
                              print(boolEmojis11[2]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[11];
                              });
                              if(customerExperienceIdListStorage[11] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis11[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList11[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList11[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis11[3] = !boolEmojis11[3];
                                boolEmojis11[1] = false;
                                boolEmojis11[2] = false;
                                boolEmojis11[0] = false;
                                boolEmojis11[4] = false;
                                boolEmojis11[5] = false;
                                boolEmojis11[6] = false;
                                boolEmojis11[7] = false;
                                selectedEmoji = emojiList11[3];
                              });
                              print(boolEmojis11[3]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[11];
                              });
                              if(customerExperienceIdListStorage[11] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis11[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList11[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList11[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis11[4] = !boolEmojis11[4];
                                boolEmojis11[1] = false;
                                boolEmojis11[2] = false;
                                boolEmojis11[3] = false;
                                boolEmojis11[0] = false;
                                boolEmojis11[5] = false;
                                boolEmojis11[6] = false;
                                boolEmojis11[7] = false;
                                selectedEmoji = emojiList11[4];
                              });
                              print(boolEmojis11[4]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[11];
                              });
                              if(customerExperienceIdListStorage[11] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis11[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList11[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList11[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis11[5] = !boolEmojis11[5];
                                boolEmojis11[1] = false;
                                boolEmojis11[2] = false;
                                boolEmojis11[3] = false;
                                boolEmojis11[4] = false;
                                boolEmojis11[0] = false;
                                boolEmojis11[6] = false;
                                boolEmojis11[7] = false;
                                selectedEmoji = emojiList11[5];
                              });
                              print(boolEmojis11[5]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[11];
                              });
                              if(customerExperienceIdListStorage[11] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis11[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList11[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList11[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis11[6] = !boolEmojis11[6];
                                boolEmojis11[1] = false;
                                boolEmojis11[2] = false;
                                boolEmojis11[3] = false;
                                boolEmojis11[4] = false;
                                boolEmojis11[5] = false;
                                boolEmojis11[0] = false;
                                boolEmojis11[7] = false;
                                selectedEmoji = emojiList11[6];
                              });
                              print(boolEmojis11[6]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[11];
                              });
                              if(customerExperienceIdListStorage[11] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis11[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList11[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList11[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis11[7] = !boolEmojis11[7];
                                boolEmojis11[1] = false;
                                boolEmojis11[2] = false;
                                boolEmojis11[3] = false;
                                boolEmojis11[4] = false;
                                boolEmojis11[5] = false;
                                boolEmojis11[6] = false;
                                boolEmojis11[0] = false;
                                selectedEmoji = emojiList11[7];
                              });
                              print(boolEmojis11[7]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[11];
                              });
                              if(customerExperienceIdListStorage[11] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis11[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList11[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList11[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  i == 12 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis12[0] = !boolEmojis12[0];
                                boolEmojis12[1] = false;
                                boolEmojis12[2] = false;
                                boolEmojis12[3] = false;
                                boolEmojis12[4] = false;
                                boolEmojis12[5] = false;
                                boolEmojis12[6] = false;
                                boolEmojis12[7] = false;
                                selectedEmoji = emojiList12[0];
                              });
                              print(boolEmojis12[0]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[12];
                              });
                              if(customerExperienceIdListStorage[12] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis12[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList12[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList12[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis12[1] = !boolEmojis12[1];
                                boolEmojis12[0] = false;
                                boolEmojis12[2] = false;
                                boolEmojis12[3] = false;
                                boolEmojis12[4] = false;
                                boolEmojis12[5] = false;
                                boolEmojis12[6] = false;
                                boolEmojis12[7] = false;
                                selectedEmoji = emojiList12[1];
                              });
                              print(boolEmojis12[1]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[12];
                              });
                              if(customerExperienceIdListStorage[12] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis12[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList12[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList12[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis12[2] = !boolEmojis12[2];
                                boolEmojis12[1] = false;
                                boolEmojis12[0] = false;
                                boolEmojis12[3] = false;
                                boolEmojis12[4] = false;
                                boolEmojis12[5] = false;
                                boolEmojis12[6] = false;
                                boolEmojis12[7] = false;
                                selectedEmoji = emojiList12[2];
                              });
                              print(boolEmojis12[2]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[12];
                              });
                              if(customerExperienceIdListStorage[12] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis12[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList12[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList12[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis12[3] = !boolEmojis12[3];
                                boolEmojis12[1] = false;
                                boolEmojis12[2] = false;
                                boolEmojis12[0] = false;
                                boolEmojis12[4] = false;
                                boolEmojis12[5] = false;
                                boolEmojis12[6] = false;
                                boolEmojis12[7] = false;
                                selectedEmoji = emojiList12[3];
                              });
                              print(boolEmojis12[3]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[12];
                              });
                              if(customerExperienceIdListStorage[12] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis12[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList12[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList12[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis12[4] = !boolEmojis12[4];
                                boolEmojis12[1] = false;
                                boolEmojis12[2] = false;
                                boolEmojis12[3] = false;
                                boolEmojis12[0] = false;
                                boolEmojis12[5] = false;
                                boolEmojis12[6] = false;
                                boolEmojis12[7] = false;
                                selectedEmoji = emojiList12[4];
                              });
                              print(boolEmojis12[4]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[12];
                              });
                              if(customerExperienceIdListStorage[12] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis12[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList12[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList12[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis12[5] = !boolEmojis12[5];
                                boolEmojis12[1] = false;
                                boolEmojis12[2] = false;
                                boolEmojis12[3] = false;
                                boolEmojis12[4] = false;
                                boolEmojis12[0] = false;
                                boolEmojis12[6] = false;
                                boolEmojis12[7] = false;
                                selectedEmoji = emojiList12[5];
                              });
                              print(boolEmojis12[5]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[12];
                              });
                              if(customerExperienceIdListStorage[12] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis12[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList12[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList12[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis12[6] = !boolEmojis12[6];
                                boolEmojis12[1] = false;
                                boolEmojis12[2] = false;
                                boolEmojis12[3] = false;
                                boolEmojis12[4] = false;
                                boolEmojis12[5] = false;
                                boolEmojis12[0] = false;
                                boolEmojis12[7] = false;
                                selectedEmoji = emojiList12[6];
                              });
                              print(boolEmojis12[6]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[12];
                              });
                              if(customerExperienceIdListStorage[12] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis12[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList12[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList12[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis12[7] = !boolEmojis12[7];
                                boolEmojis12[1] = false;
                                boolEmojis12[2] = false;
                                boolEmojis12[3] = false;
                                boolEmojis12[4] = false;
                                boolEmojis12[5] = false;
                                boolEmojis12[6] = false;
                                boolEmojis12[0] = false;
                                selectedEmoji = emojiList12[7];
                              });
                              print(boolEmojis12[7]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[12];
                              });
                              if(customerExperienceIdListStorage[12] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis12[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList12[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList12[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  i == 13 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis13[0] = !boolEmojis13[0];
                                boolEmojis13[1] = false;
                                boolEmojis13[2] = false;
                                boolEmojis13[3] = false;
                                boolEmojis13[4] = false;
                                boolEmojis13[5] = false;
                                boolEmojis13[6] = false;
                                boolEmojis13[7] = false;
                                selectedEmoji = emojiList13[0];
                              });
                              print(boolEmojis13[0]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[13];
                              });
                              if(customerExperienceIdListStorage[13] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis13[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList13[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList13[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis13[1] = !boolEmojis13[1];
                                boolEmojis13[0] = false;
                                boolEmojis13[2] = false;
                                boolEmojis13[3] = false;
                                boolEmojis13[4] = false;
                                boolEmojis13[5] = false;
                                boolEmojis13[6] = false;
                                boolEmojis13[7] = false;
                                selectedEmoji = emojiList13[1];
                              });
                              print(boolEmojis13[1]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[13];
                              });
                              if(customerExperienceIdListStorage[13] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis13[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList13[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList13[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis13[2] = !boolEmojis13[2];
                                boolEmojis13[1] = false;
                                boolEmojis13[0] = false;
                                boolEmojis13[3] = false;
                                boolEmojis13[4] = false;
                                boolEmojis13[5] = false;
                                boolEmojis13[6] = false;
                                boolEmojis13[7] = false;
                                selectedEmoji = emojiList13[2];
                              });
                              print(boolEmojis13[2]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[13];
                              });
                              if(customerExperienceIdListStorage[13] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis13[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList13[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList13[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis13[3] = !boolEmojis13[3];
                                boolEmojis13[1] = false;
                                boolEmojis13[2] = false;
                                boolEmojis13[0] = false;
                                boolEmojis13[4] = false;
                                boolEmojis13[5] = false;
                                boolEmojis13[6] = false;
                                boolEmojis13[7] = false;
                                selectedEmoji = emojiList13[3];
                              });
                              print(boolEmojis13[3]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[13];
                              });
                              if(customerExperienceIdListStorage[13] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis13[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList13[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList13[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis13[4] = !boolEmojis13[4];
                                boolEmojis13[1] = false;
                                boolEmojis13[2] = false;
                                boolEmojis13[3] = false;
                                boolEmojis13[0] = false;
                                boolEmojis13[5] = false;
                                boolEmojis13[6] = false;
                                boolEmojis13[7] = false;
                                selectedEmoji = emojiList13[4];
                              });
                              print(boolEmojis13[4]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[13];
                              });
                              if(customerExperienceIdListStorage[13] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis13[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList13[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList13[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis13[5] = !boolEmojis13[5];
                                boolEmojis13[1] = false;
                                boolEmojis13[2] = false;
                                boolEmojis13[3] = false;
                                boolEmojis13[4] = false;
                                boolEmojis13[0] = false;
                                boolEmojis13[6] = false;
                                boolEmojis13[7] = false;
                                selectedEmoji = emojiList13[5];
                              });
                              print(boolEmojis13[5]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[13];
                              });
                              if(customerExperienceIdListStorage[13] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis13[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList13[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList13[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis13[6] = !boolEmojis13[6];
                                boolEmojis13[1] = false;
                                boolEmojis13[2] = false;
                                boolEmojis13[3] = false;
                                boolEmojis13[4] = false;
                                boolEmojis13[5] = false;
                                boolEmojis13[0] = false;
                                boolEmojis13[7] = false;
                                selectedEmoji = emojiList13[6];
                              });
                              print(boolEmojis13[6]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[13];
                              });
                              if(customerExperienceIdListStorage[13] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis13[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList13[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList13[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis13[7] = !boolEmojis13[7];
                                boolEmojis13[1] = false;
                                boolEmojis13[2] = false;
                                boolEmojis13[3] = false;
                                boolEmojis13[4] = false;
                                boolEmojis13[5] = false;
                                boolEmojis13[6] = false;
                                boolEmojis13[0] = false;
                                selectedEmoji = emojiList13[7];
                              });
                              print(boolEmojis13[7]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[13];
                              });
                              if(customerExperienceIdListStorage[13] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis13[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList13[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList13[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  i == 14 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis14[0] = !boolEmojis14[0];
                                boolEmojis14[1] = false;
                                boolEmojis14[2] = false;
                                boolEmojis14[3] = false;
                                boolEmojis14[4] = false;
                                boolEmojis14[5] = false;
                                boolEmojis14[6] = false;
                                boolEmojis14[7] = false;
                                selectedEmoji = emojiList14[0];
                              });
                              print(boolEmojis14[0]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[14];
                              });
                              if(customerExperienceIdListStorage[14] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis14[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList14[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList14[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis14[1] = !boolEmojis14[1];
                                boolEmojis14[0] = false;
                                boolEmojis14[2] = false;
                                boolEmojis14[3] = false;
                                boolEmojis14[4] = false;
                                boolEmojis14[5] = false;
                                boolEmojis14[6] = false;
                                boolEmojis14[7] = false;
                                selectedEmoji = emojiList14[1];
                              });
                              print(boolEmojis14[1]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[14];
                              });
                              if(customerExperienceIdListStorage[14] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis14[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList14[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList14[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis14[2] = !boolEmojis14[2];
                                boolEmojis14[1] = false;
                                boolEmojis14[0] = false;
                                boolEmojis14[3] = false;
                                boolEmojis14[4] = false;
                                boolEmojis14[5] = false;
                                boolEmojis14[6] = false;
                                boolEmojis14[7] = false;
                                selectedEmoji = emojiList14[2];
                              });
                              print(boolEmojis14[2]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[14];
                              });
                              if(customerExperienceIdListStorage[14] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis14[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList14[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList14[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis14[3] = !boolEmojis14[3];
                                boolEmojis14[1] = false;
                                boolEmojis14[2] = false;
                                boolEmojis14[0] = false;
                                boolEmojis14[4] = false;
                                boolEmojis14[5] = false;
                                boolEmojis14[6] = false;
                                boolEmojis14[7] = false;
                                selectedEmoji = emojiList14[3];
                              });
                              print(boolEmojis14[3]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[14];
                              });
                              if(customerExperienceIdListStorage[14] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis14[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList14[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList14[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis14[4] = !boolEmojis14[4];
                                boolEmojis14[1] = false;
                                boolEmojis14[2] = false;
                                boolEmojis14[3] = false;
                                boolEmojis14[0] = false;
                                boolEmojis14[5] = false;
                                boolEmojis14[6] = false;
                                boolEmojis14[7] = false;
                                selectedEmoji = emojiList14[4];
                              });
                              print(boolEmojis14[4]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[14];
                              });
                              if(customerExperienceIdListStorage[14] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis14[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList14[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList14[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis14[5] = !boolEmojis14[5];
                                boolEmojis14[1] = false;
                                boolEmojis14[2] = false;
                                boolEmojis14[3] = false;
                                boolEmojis14[4] = false;
                                boolEmojis14[0] = false;
                                boolEmojis14[6] = false;
                                boolEmojis14[7] = false;
                                selectedEmoji = emojiList14[5];
                              });
                              print(boolEmojis14[5]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[14];
                              });
                              if(customerExperienceIdListStorage[14] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis14[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList14[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList14[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis14[6] = !boolEmojis14[6];
                                boolEmojis14[1] = false;
                                boolEmojis14[2] = false;
                                boolEmojis14[3] = false;
                                boolEmojis14[4] = false;
                                boolEmojis14[5] = false;
                                boolEmojis14[0] = false;
                                boolEmojis14[7] = false;
                                selectedEmoji = emojiList14[6];
                              });
                              print(boolEmojis14[6]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[14];
                              });
                              if(customerExperienceIdListStorage[14] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis14[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList14[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList14[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis14[7] = !boolEmojis14[7];
                                boolEmojis14[1] = false;
                                boolEmojis14[2] = false;
                                boolEmojis14[3] = false;
                                boolEmojis14[4] = false;
                                boolEmojis14[5] = false;
                                boolEmojis14[6] = false;
                                boolEmojis14[0] = false;
                                selectedEmoji = emojiList14[7];
                              });
                              print(boolEmojis14[7]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[14];
                              });
                              if(customerExperienceIdListStorage[14] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis14[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList14[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList14[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  i == 15 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis15[0] = !boolEmojis15[0];
                                boolEmojis15[1] = false;
                                boolEmojis15[2] = false;
                                boolEmojis15[3] = false;
                                boolEmojis15[4] = false;
                                boolEmojis15[5] = false;
                                boolEmojis15[6] = false;
                                boolEmojis15[7] = false;
                                selectedEmoji = emojiList15[0];
                              });
                              print(boolEmojis15[0]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[15];
                              });
                              if(customerExperienceIdListStorage[15] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis15[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList15[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList15[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis15[1] = !boolEmojis15[1];
                                boolEmojis15[0] = false;
                                boolEmojis15[2] = false;
                                boolEmojis15[3] = false;
                                boolEmojis15[4] = false;
                                boolEmojis15[5] = false;
                                boolEmojis15[6] = false;
                                boolEmojis15[7] = false;
                                selectedEmoji = emojiList15[1];
                              });
                              print(boolEmojis15[1]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[15];
                              });
                              if(customerExperienceIdListStorage[15] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis15[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList15[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList15[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis15[2] = !boolEmojis15[2];
                                boolEmojis15[1] = false;
                                boolEmojis15[0] = false;
                                boolEmojis15[3] = false;
                                boolEmojis15[4] = false;
                                boolEmojis15[5] = false;
                                boolEmojis15[6] = false;
                                boolEmojis15[7] = false;
                                selectedEmoji = emojiList15[2];
                              });
                              print(boolEmojis15[2]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[15];
                              });
                              if(customerExperienceIdListStorage[15] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis15[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList15[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList15[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis15[3] = !boolEmojis15[3];
                                boolEmojis15[1] = false;
                                boolEmojis15[2] = false;
                                boolEmojis15[0] = false;
                                boolEmojis15[4] = false;
                                boolEmojis15[5] = false;
                                boolEmojis15[6] = false;
                                boolEmojis15[7] = false;
                                selectedEmoji = emojiList15[3];
                              });
                              print(boolEmojis15[3]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[15];
                              });
                              if(customerExperienceIdListStorage[15] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis15[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList15[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList15[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis15[4] = !boolEmojis15[4];
                                boolEmojis15[1] = false;
                                boolEmojis15[2] = false;
                                boolEmojis15[3] = false;
                                boolEmojis15[0] = false;
                                boolEmojis15[5] = false;
                                boolEmojis15[6] = false;
                                boolEmojis15[7] = false;
                                selectedEmoji = emojiList15[4];
                              });
                              print(boolEmojis15[4]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[15];
                              });
                              if(customerExperienceIdListStorage[15] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis15[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList15[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList15[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis15[5] = !boolEmojis15[5];
                                boolEmojis15[1] = false;
                                boolEmojis15[2] = false;
                                boolEmojis15[3] = false;
                                boolEmojis15[4] = false;
                                boolEmojis15[0] = false;
                                boolEmojis15[6] = false;
                                boolEmojis15[7] = false;
                                selectedEmoji = emojiList15[5];
                              });
                              print(boolEmojis15[5]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[15];
                              });
                              if(customerExperienceIdListStorage[15] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis15[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList15[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList15[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis15[6] = !boolEmojis15[6];
                                boolEmojis15[1] = false;
                                boolEmojis15[2] = false;
                                boolEmojis15[3] = false;
                                boolEmojis15[4] = false;
                                boolEmojis15[5] = false;
                                boolEmojis15[0] = false;
                                boolEmojis15[7] = false;
                                selectedEmoji = emojiList15[6];
                              });
                              print(boolEmojis15[6]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[15];
                              });
                              if(customerExperienceIdListStorage[15] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis15[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList15[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList15[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis15[7] = !boolEmojis15[7];
                                boolEmojis15[1] = false;
                                boolEmojis15[2] = false;
                                boolEmojis15[3] = false;
                                boolEmojis15[4] = false;
                                boolEmojis15[5] = false;
                                boolEmojis15[6] = false;
                                boolEmojis15[0] = false;
                                selectedEmoji = emojiList15[7];
                              });
                              print(boolEmojis15[7]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[15];
                              });
                              if(customerExperienceIdListStorage[15] == "x"){
                                inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                  Future.delayed(const Duration(seconds: 3), () {
                                    customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                    print(customerExperienceIdListStorage.toList());
                                  });
                                });
                              }else{
                                setState(() {
                                  empathize.selectedTouchPointId = customerExperienceIdListStorage[i].toString();
                                });
                                print(empathize.selectedTouchPointId);
                                inputPainPointsApiProvider.updateCustomerExperiences(context).whenComplete((){

                                });
                              }
                            },
                            child: boolEmojis15[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList15[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList15[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[0] = !boolEmojis5[0];
                                boolEmojis5[1] = false;
                                boolEmojis5[2] = false;
                                boolEmojis5[3] = false;
                                boolEmojis5[4] = false;
                                boolEmojis5[5] = false;
                                boolEmojis5[6] = false;
                                boolEmojis5[7] = false;
                                selectedEmoji = emojiList5[0];
                              });
                              print(boolEmojis5[0]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                Future.delayed(const Duration(seconds: 3), () {
                                  customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                  print(customerExperienceIdListStorage.toList());
                                });
                              });
                            },
                            child: boolEmojis5[0] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[0],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[0],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[1] = !boolEmojis5[1];
                                boolEmojis5[0] = false;
                                boolEmojis5[2] = false;
                                boolEmojis5[3] = false;
                                boolEmojis5[4] = false;
                                boolEmojis5[5] = false;
                                boolEmojis5[6] = false;
                                boolEmojis5[7] = false;
                                selectedEmoji = emojiList5[1];
                              });
                              print(boolEmojis5[1]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                Future.delayed(const Duration(seconds: 3), () {
                                  customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                  print(customerExperienceIdListStorage.toList());
                                });
                              });
                            },
                            child: boolEmojis5[1] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[1],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[1],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[2] = !boolEmojis5[2];
                                boolEmojis5[1] = false;
                                boolEmojis5[0] = false;
                                boolEmojis5[3] = false;
                                boolEmojis5[4] = false;
                                boolEmojis5[5] = false;
                                boolEmojis5[6] = false;
                                boolEmojis5[7] = false;
                                selectedEmoji = emojiList5[2];
                              });
                              print(boolEmojis5[2]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                Future.delayed(const Duration(seconds: 3), () {
                                  customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                  print(customerExperienceIdListStorage.toList());
                                });
                              });
                            },
                            child: boolEmojis5[2] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[2],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[2],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[3] = !boolEmojis5[3];
                                boolEmojis5[1] = false;
                                boolEmojis5[2] = false;
                                boolEmojis5[0] = false;
                                boolEmojis5[4] = false;
                                boolEmojis5[5] = false;
                                boolEmojis5[6] = false;
                                boolEmojis5[7] = false;
                                selectedEmoji = emojiList5[3];
                              });
                              print(boolEmojis5[3]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                Future.delayed(const Duration(seconds: 3), () {
                                  customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                  print(customerExperienceIdListStorage.toList());
                                });
                              });
                            },
                            child: boolEmojis5[3] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[3],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[3],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[4] = !boolEmojis5[4];
                                boolEmojis5[1] = false;
                                boolEmojis5[2] = false;
                                boolEmojis5[3] = false;
                                boolEmojis5[0] = false;
                                boolEmojis5[5] = false;
                                boolEmojis5[6] = false;
                                boolEmojis5[7] = false;
                                selectedEmoji = emojiList5[4];
                              });
                              print(boolEmojis5[4]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                Future.delayed(const Duration(seconds: 3), () {
                                  customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                  print(customerExperienceIdListStorage.toList());
                                });
                              });
                            },
                            child: boolEmojis5[4] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[4],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[4],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[5] = !boolEmojis5[5];
                                boolEmojis5[1] = false;
                                boolEmojis5[2] = false;
                                boolEmojis5[3] = false;
                                boolEmojis5[4] = false;
                                boolEmojis5[0] = false;
                                boolEmojis5[6] = false;
                                boolEmojis5[7] = false;
                                selectedEmoji = emojiList5[5];
                              });
                              print(boolEmojis5[5]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                Future.delayed(const Duration(seconds: 3), () {
                                  customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                  print(customerExperienceIdListStorage.toList());
                                });
                              });
                            },
                            child: boolEmojis5[5] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[5],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[5],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[6] = !boolEmojis5[6];
                                boolEmojis5[1] = false;
                                boolEmojis5[2] = false;
                                boolEmojis5[3] = false;
                                boolEmojis5[4] = false;
                                boolEmojis5[5] = false;
                                boolEmojis5[0] = false;
                                boolEmojis5[7] = false;
                                selectedEmoji = emojiList5[6];
                              });
                              print(boolEmojis5[6]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                Future.delayed(const Duration(seconds: 3), () {
                                  customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                  print(customerExperienceIdListStorage.toList());
                                });
                              });
                            },
                            child: boolEmojis5[6] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[6],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[6],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                boolEmojis5[7] = !boolEmojis5[7];
                                boolEmojis5[1] = false;
                                boolEmojis5[2] = false;
                                boolEmojis5[3] = false;
                                boolEmojis5[4] = false;
                                boolEmojis5[5] = false;
                                boolEmojis5[6] = false;
                                boolEmojis5[0] = false;
                                selectedEmoji = emojiList5[7];
                              });
                              print(boolEmojis5[7]);
                              print(selectedEmoji);
                              setState(() {
                                empathize.selectedCustomerExperienceController = selectedEmoji;
                                empathize.selectedTouchPointId = touchPointIdListStorage[4];
                              });
                              inputPainPointsApiProvider.uploadCustomerExperiences(context).whenComplete((){
                                Future.delayed(const Duration(seconds: 3), () {
                                  customerExperienceIdListStorage.insert(i, empathize.receivedCustomerExperienceIdSingle);
                                  print(customerExperienceIdListStorage.toList());
                                });
                              });
                            },
                            child: boolEmojis5[7] == true ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                border: Border.all(color: Color(0xff787cd1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(emojiList5[7],
                                  style: TextStyle(
                                      fontSize: 25,
                                      letterSpacing: 2.0
                                  ),
                                ),
                              ),
                            ) : Text(emojiList5[7],
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //Icon(Icons.add, color: Colors.white,),
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }

  Widget buildPainPointsRow(BuildContext context){
    return Container(
      height: 95,
      child: Container(
        height: 95,
        //width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: counter,
          itemBuilder: (context, i) => i == 0 ? Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Container(
              height: 95,
              width: 127,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text(empathize.painPoints,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                        color: Color(0xff787cd1),
                        fontSize: 20,
                      )
                  ),
                ),
              ),
            ),
          ) : Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Container(
              height: 95,
              width: 254,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    maxLines: 2,
                    focusNode: focusNodesPainPoint[i],
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    controller: _controllerListPainPoints[i],
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Receives an introductory set of emails and connect request on linkedIn"
                    ),
                    validator: (val){
                      if(val.isEmpty){
                        return 'Pain Point cannot be empty!';
                      }
                      return null;
                    },
                    //onSaved: (val){print("onsaved called");},
                    onChanged: (val){
                      //focusNodesPainPoint[i].unfocus();
                      if(_controllerListPainPoints[i].text.toString() == null || _controllerListPainPoints[i].text.toString() == "" || _controllerListPainPoints[i].text.toString() == " "){

                      }else{
                        setState(() {
                          empathize.selectedPainPointController = _controllerListPainPoints[i].text.toString();
                          empathize.selectedTouchPointId = touchPointIdListStorage[i];
                        });
                        print(empathize.selectedPainPointController);
                        if(painPointIdListStorage[i] == "x"){
                          inputPainPointsApiProvider.inputPainPointsFromDigitalJourneyMap(context).whenComplete((){
                            Future.delayed(const Duration(seconds: 3), () {
                              painPointIdListStorage.insert(i, empathize.receivedPainPointIdSingle);
                              print(painPointIdListStorage.toList());
                            });
                          });
                        }else{
                          setState(() {
                            empathize.selectedTouchPointId = painPointIdListStorage[i];
                          });
                          inputPainPointsApiProvider.updatePainPointsFromDigitalJourneyMap(context).whenComplete((){

                          });
                        }
                      }
                    },
//                    onEditingComplete: (){
//                      focusNodesPainPoint[i].unfocus();
//                      if(_controllerListPainPoints[i].text.toString() == null || _controllerListPainPoints[i].text.toString() == "" || _controllerListPainPoints[i].text.toString() == " "){
//
//                      }else{
//                        setState(() {
//                          empathize.selectedPainPointController = _controllerListPainPoints[i].text.toString();
//                          empathize.selectedTouchPointId = touchPointIdListStorage[i];
//                        });
//                        print(empathize.selectedPainPointController);
//                        if(painPointIdListStorage[i] == "x"){
//                          inputPainPointsApiProvider.inputPainPointsFromDigitalJourneyMap(context).whenComplete((){
//                            Future.delayed(const Duration(seconds: 3), () {
//                              painPointIdListStorage.insert(i, empathize.receivedPainPointIdSingle);
//                              print(painPointIdListStorage.toList());
//                            });
//                          });
//                        }else{
//                          setState(() {
//                            empathize.selectedTouchPointId = painPointIdListStorage[i];
//                          });
//                          inputPainPointsApiProvider.updatePainPointsFromDigitalJourneyMap(context).whenComplete((){
//
//                          });
//                        }
//                      }
//                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget saveButton(BuildContext context){
    return InkWell(
      onTap: (){
        if(_controllerListTouchPoints[0].text.toString() == "" || _controllerListCustomerThoughts[0].text.toString() == "" || _controllerListPainPoints[0].text.toString() == "" ||
            _controllerListTouchPoints[1].text.toString() == "" || _controllerListCustomerThoughts[1].text.toString() == "" || _controllerListPainPoints[1].text.toString() == "" ||
            _controllerListTouchPoints[2].text.toString() == "" || _controllerListCustomerThoughts[2].text.toString() == "" || _controllerListPainPoints[2].text.toString() == ""){
          Fluttertoast.showToast(msg: "Please fill atleast 3 column of fields", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }else{
          Fluttertoast.showToast(msg: "Saved", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      },
      child: Container(
        height: 35,
        width: 114,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffd4d4d4),
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Center(
          child: Text(empathize.saveButton,
            style: GoogleFonts.nunitoSans(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget newPersonaButton(BuildContext context){
    return InkWell(
      onTap: () => showAlertDialogNewMap(context),
      child: Container(
        height: 35,
        width: 114,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffd4d4d4),
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Center(
          child: Text("New map",
            style: GoogleFonts.nunitoSans(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //inputPainPointsApiProvider.inputPainPoints(context);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => EmphatizeInsideSections3(),
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

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel",style: GoogleFonts.nunitoSans(),),
      onPressed:  () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue",style: GoogleFonts.nunitoSans(),),
      onPressed:  () async {
        createJourneyApiProvider.deleteJourneyMapName(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Journey Map",
        style: GoogleFonts.nunitoSans(
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text("Press Continue to discard this journey map, else press Cancel to go back without deleting.",
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

  showAlertDialogNewMap(BuildContext context) {

    Widget textFormField = Theme(
        data: ThemeData(
          primaryColor: Color(0xff787CD1),
        ),
        child: TextFormField(
          controller: empathize.journeyNameController,
          decoration: InputDecoration(
            hintText: empathize.journeyMapPaperHint,
          ),
          validator: (val){
            if(val.isEmpty){
              return empathize.journeyMapFieldValidation;
            }
            return null;
          },
        ));

    GestureDetector buildSaveButton = GestureDetector(
      onTap: (){
        if(empathize.formKey2.currentState.validate()){
          empathize.prJourneyMapName.show();
          createJourneyApiProvider.createNewJourneyMapName(context).whenComplete((){

          });
        }
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
            child: Text("Next",
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
          Text(empathize.popUpHint, style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 16, letterSpacing: 1),)),
          Text("",style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 16, letterSpacing: 1),)),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: MediaQuery.of(context).size.height/4,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: empathize.formKey2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                textFormField,
                buildSaveButton,
              ],
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

List<TextEditingController> _controllerListTouchPoints = List.generate(15, (i) => TextEditingController());
List<TextEditingController> _controllerListCustomerThoughts = List.generate(15, (i) => TextEditingController());
List<TextEditingController> _controllerListPainPoints = List.generate(15, (i) => TextEditingController());

List<FocusNode> focusNodesTouchPoints = List.generate(15, (i) => FocusNode());
List<bool> focusEnableTouchPoints = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,];
List<FocusNode> focusNodesCustomerThoughts = List.generate(15, (i) => FocusNode());
List<bool> focusEnableCustomerThoughts = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,];
List<FocusNode> focusNodesCustomerExperience = List.generate(15, (i) => FocusNode());
List<bool> focusEnableCustomerExperience = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,];
List<FocusNode> focusNodesPainPoint = List.generate(15, (i) => FocusNode());
List<bool> focusEnablePainPoint = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,];

var selectedEmoji;
List<String> emojiList1 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList2 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList3 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList4 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList5 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList6 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList7 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList8 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList9 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList10 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList11 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList12 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList13 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList14 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList15 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<bool> boolEmojis1 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis2 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis3 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis4 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis5 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis6 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis7 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis8 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis9 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis10 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis11 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis12 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis13 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis14 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis15 = [false,false,false,false,false,false,false,false,];


List<String> touchPointIdListStorage;
List<String> customerThoughtIdListStorage;
List<String> customerExperienceIdListStorage;
List<String> painPointIdListStorage;