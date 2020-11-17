import 'package:design_sprint/APIs/create_journey_map.dart';
import 'package:design_sprint/APIs/get_warehouse_journeymap_data.dart';
import 'package:design_sprint/APIs/input_pain_point.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/EmpathizeScreens/emphatize_inside_sections_scree3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/warehouse_journey_map_data.dart' as journeyMapWH;

class ViewDigitalJourneyMapDetails extends StatefulWidget {
  @override
  _ViewDigitalJourneyMapDetailsState createState() => _ViewDigitalJourneyMapDetailsState();
}

class _ViewDigitalJourneyMapDetailsState extends State<ViewDigitalJourneyMapDetails> {
  InputPainPointsApiProvider inputPainPointsApiProvider = InputPainPointsApiProvider();
  CreateJourneyApiProvider createJourneyApiProvider = CreateJourneyApiProvider();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GetWareHouseJourneyMapDataApiProvider getWareHouseJourneyMapDataApiProvider = GetWareHouseJourneyMapDataApiProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWareHouseJourneyMapDataApiProvider.getJourneyMapWareHouseDataMapIdWise(context);
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
      body: SingleChildScrollView(
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: statusBarDrawer(context),
            ),
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
          onPressed: (){
            Navigator.of(context).pop();
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
                child: Text(i == 1 ? journeyMapWH.journeyMapWareHouseTouchPointsList[0] :i == 2 ? journeyMapWH.journeyMapWareHouseTouchPointsList[1] : i == 3 ? journeyMapWH.journeyMapWareHouseTouchPointsList[2] : journeyMapWH.journeyMapWareHouseTouchPointsList[3]),
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
                child: Text(i == 1 ? journeyMapWH.journeyMapWareHouseCustomerThoughtsList[0] :i == 2 ? journeyMapWH.journeyMapWareHouseCustomerThoughtsList[1] : i == 3 ? journeyMapWH.journeyMapWareHouseCustomerThoughtsList[2] : journeyMapWH.journeyMapWareHouseCustomerThoughtsList[3]),
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
                child: Text(i == 1 ? journeyMapWH.journeyMapWareHouseCustomerExperiencesList[0] :i == 2 ? journeyMapWH.journeyMapWareHouseCustomerExperiencesList[1] : i == 3 ? journeyMapWH.journeyMapWareHouseCustomerExperiencesList[2] : journeyMapWH.journeyMapWareHouseCustomerExperiencesList[3]),
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
                child: Text(i == 1 ? journeyMapWH.journeyMapWareHousePainPointsList[0] :i == 2 ? journeyMapWH.journeyMapWareHousePainPointsList[1] : i == 3 ? journeyMapWH.journeyMapWareHousePainPointsList[2] : journeyMapWH.journeyMapWareHousePainPointsList[3]),
              ),
            ),
          ),
        ),
      ),
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