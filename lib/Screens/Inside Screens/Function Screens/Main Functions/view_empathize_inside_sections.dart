import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_journey_maps_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_personas_screen.dart';
import 'package:flutter/material.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:google_fonts/google_fonts.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ViewEmpathizeInsideSections extends StatefulWidget {
  final sprintid;
  ViewEmpathizeInsideSections(this.sprintid) : super();
  @override
  _ViewEmpathizeInsideSectionsState createState() => _ViewEmpathizeInsideSectionsState();
}

class _ViewEmpathizeInsideSectionsState extends State<ViewEmpathizeInsideSections> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    home.selectedSprintId = widget.sprintid;
    print(home.selectedSprintId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: ProfileDrawerCommon(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 70,),
            buildUserPersonaCard(context),
            SizedBox(height: 25,),
            buildJourneyMapCard(context),
            SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context){

    Container line = Container(height:1,color: Colors.black,child: Divider());
    void _openEndDrawer() {
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

  Widget buildUserPersonaCard(BuildContext context){
    return Center(
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => ViewPersonas(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Container(
            width: 302,
            height: 286.22,
            decoration: BoxDecoration(
                color: Color(0xffFFB8B8),
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Stack(
              children: [
                Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 29, left: 35),
                      child: Text("User",
                        style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 35),
                      child: Text("Personas",
                        style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            )
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.arrow_forward, color: Colors.white,size: 25,),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildJourneyMapCard(BuildContext context){
    return Center(
      child: GestureDetector(
        onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => ViewJourneyMaps(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Container(
            width: 302,
            height: 286.22,
            decoration: BoxDecoration(
                color: Color(0xffF1A042),
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Stack(
              children: [
                Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 29, left: 35),
                      child: Text("Journey",
                        style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 35),
                      child: Text("Maps",
                        style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            )
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.arrow_forward, color: Colors.white,size: 25,),
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
}
