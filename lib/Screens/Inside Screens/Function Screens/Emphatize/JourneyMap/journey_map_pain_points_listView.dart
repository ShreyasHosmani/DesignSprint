import 'package:design_sprint/APIs/create_journey_map.dart';
import 'package:design_sprint/APIs/input_pain_point.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/EmpathizeScreens/emphatize_inside_sections_scree3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;

class JourneyMapPainPointsListView extends StatefulWidget {
  @override
  _JourneyMapPainPointsListViewState createState() => _JourneyMapPainPointsListViewState();
}

class _JourneyMapPainPointsListViewState extends State<JourneyMapPainPointsListView> {
  InputPainPointsApiProvider inputPainPointsApiProvider = InputPainPointsApiProvider();
  CreateJourneyApiProvider createJourneyApiProvider = CreateJourneyApiProvider();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    touchPointIdListStorage = ['x', 'x', 'x', 'x', 'x'];
    customerThoughtIdListStorage = ['x', 'x', 'x', 'x', 'x'];
    customerExperienceIdListStorage = ['x', 'x', 'x', 'x', 'x'];
    painPointIdListStorage = ['x', 'x', 'x', 'x', 'x'];
    _controllerListTouchPoints = List.generate(5, (i) => TextEditingController());
    _controllerListCustomerThoughts = List.generate(5, (i) => TextEditingController());
    _controllerListPainPoints = List.generate(5, (i) => TextEditingController());
    emojiList1 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList2 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList3 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList4 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    emojiList5 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
    boolEmojis1 = [false,false,false,false,false,false,false,false,];
    boolEmojis2 = [false,false,false,false,false,false,false,false,];
    boolEmojis3 = [false,false,false,false,false,false,false,false,];
    boolEmojis4 = [false,false,false,false,false,false,false,false,];
    boolEmojis5 = [false,false,false,false,false,false,false,false,];
    focusNodesTouchPoints = List.generate(5, (i) => FocusNode());
    focusEnableTouchPoints = [false,false,false,false,false];
    focusNodesCustomerThoughts = List.generate(5, (i) => FocusNode());
    focusEnableCustomerThoughts = [false,false,false,false,false];
    focusNodesCustomerExperience = List.generate(5, (i) => FocusNode());
    focusEnableCustomerExperience = [false,false,false,false,false];
    focusNodesPainPoint = List.generate(5, (i) => FocusNode());
    focusEnablePainPoint = [false,false,false,false,false];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: statusDrawer == true ? buildStatusDrawer(context) : buildProfileDrawer(context),
      body: WillPopScope(
        onWillPop: () => showAlertDialog(context),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  buildName2Widget(context),
                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 0),
                    child: buildTouchPointRow(context),
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 0),
                    child: buildCustomerThoughtsRow(context),
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 0),
                    child: buildCustomerExperienceRow(context),
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 0),
                    child: buildPainPointsRow(context),
                  ),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      saveButton(context),
                      newPersonaButton(context),
                    ],
                  ),
                  SizedBox(height: 40,),
                  buildNextButton(context),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
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
          onPressed: (){
            showAlertDialog(context);
          },
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
      child: Container(
        height: 95,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
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
                    onEditingComplete: (){
                      focusNodesTouchPoints[i].unfocus();
                      setState(() {
                        empathize.selectedTouchPointController = _controllerListTouchPoints[i].text.toString();
                      });
                      print(empathize.selectedTouchPointController);
                      if(touchPointIdListStorage[i] == "x"){
                        inputPainPointsApiProvider.uploadTouchPoints(context).whenComplete((){
                          Future.delayed(const Duration(seconds: 3), () {
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

  Widget buildCustomerThoughtsRow(BuildContext context){
    return Container(
      height: 95,
      child: Container(
        height: 95,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
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
                    onEditingComplete: (){
                      focusNodesCustomerThoughts[i].unfocus();
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
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
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
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
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
                    onEditingComplete: (){
                      focusNodesPainPoint[i].unfocus();
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

  Widget saveButton(BuildContext context){
    return InkWell(
      onTap: (){

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
      content: Text("If you go back, this journey map will be discarded. Are you sure you want to go back?",
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

List<TextEditingController> _controllerListTouchPoints = List.generate(5, (i) => TextEditingController());
List<TextEditingController> _controllerListCustomerThoughts = List.generate(5, (i) => TextEditingController());
List<TextEditingController> _controllerListPainPoints = List.generate(5, (i) => TextEditingController());

List<FocusNode> focusNodesTouchPoints = List.generate(5, (i) => FocusNode());
List<bool> focusEnableTouchPoints = [false,false,false,false,false];
List<FocusNode> focusNodesCustomerThoughts = List.generate(5, (i) => FocusNode());
List<bool> focusEnableCustomerThoughts = [false,false,false,false,false];
List<FocusNode> focusNodesCustomerExperience = List.generate(5, (i) => FocusNode());
List<bool> focusEnableCustomerExperience = [false,false,false,false,false];
List<FocusNode> focusNodesPainPoint = List.generate(5, (i) => FocusNode());
List<bool> focusEnablePainPoint = [false,false,false,false,false];

var selectedEmoji;
List<String> emojiList1 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList2 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList3 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList4 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<String> emojiList5 = ['🙂', '😞', '😥', '😍', '🤔', '😰', '😠', '🚫'];
List<bool> boolEmojis1 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis2 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis3 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis4 = [false,false,false,false,false,false,false,false,];
List<bool> boolEmojis5 = [false,false,false,false,false,false,false,false,];


List<String> touchPointIdListStorage;
List<String> customerThoughtIdListStorage;
List<String> customerExperienceIdListStorage;
List<String> painPointIdListStorage;