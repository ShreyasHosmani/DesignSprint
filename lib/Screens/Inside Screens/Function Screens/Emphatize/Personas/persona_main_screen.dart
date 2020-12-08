import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_team.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/Personas/create_digital_persona.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/Personas/persona_digital_or_upload_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/Personas/persona_tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;

bool statusDrawer = false;

class PersonaMainScreen extends StatefulWidget {
  @override
  _PersonaMainScreenState createState() => _PersonaMainScreenState();
}

class _PersonaMainScreenState extends State<PersonaMainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: statusDrawer == true ? StatusDrawerTeam() : ProfileDrawerCommon(),
      body: WillPopScope(
        onWillPop: () => Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => PersonaTutorial(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  buildName2Widget(context),
                  SizedBox(height: 25,),
                  buildCreateDigitallyCard(context),
                  SizedBox(height: 25,),
                  buildCreateOnPaperCard(context),
                  SizedBox(height: 25,),
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
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => PersonaTutorial(),
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
      child: Text(empathize.createPersonas,
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

  Widget buildCreateDigitallyCard(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => CreateDigitalPersona(),
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
              color: Color(0xff96C3CB),
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
                    child: Text(empathize.createPersonas,
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
                    child: Text(empathize.digitally,
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
    );
  }

  Widget buildCreateOnPaperCard(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => CreateOrDownloadPersona(),
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
              color: Color(0xff787CD1),
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
                    child: Text(empathize.createPersonas,
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
                    child: Text(empathize.createPersonasOnPaper,
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
    );
  }

}
