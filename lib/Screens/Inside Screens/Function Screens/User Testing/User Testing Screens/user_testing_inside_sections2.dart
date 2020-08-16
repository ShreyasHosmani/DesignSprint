import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/User%20Testing/User%20Testing%20Screens/user_testing_inside_sections3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

bool statusDrawer = false;

class UserTestingInsideSections2 extends StatefulWidget {
  @override
  _UserTestingInsideSections2State createState() => _UserTestingInsideSections2State();
}

class _UserTestingInsideSections2State extends State<UserTestingInsideSections2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                buildName2Widget(context),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildFilledContainer(context),
                        buildFilledContainerSeperater(context),
                        buildFilledContainer(context),
                        buildContainerSeperater(context),
                        buildNonFilledContainer(context),
                      ],
                    ),
                    SizedBox(width: 30,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildUserInterviewCard(context),
                        SizedBox(height: 20,),
                        buildShadowingCard(context),
                        SizedBox(height: 20,),
                        buildMappingInsightsCard(context),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                buildNextButton(context),
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
        child: Text("User Testing",
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
                          Text("Hi Pratheek!",
                            style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                )
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text("pratheeksharma@gmail.com",
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
                    Text("Home",
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
                    Text("Design Sprint",
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
                    Text("Tips",
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
                    Text("Manage Team",
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
                    Text("FaQ's",
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
                    Text("Legal Policy",
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
      child: Text("Agenda",
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

  Widget buildUserInterviewCard(BuildContext context){
    return GestureDetector(
      onTap: (){
//        Navigator.push(
//          context,
//          PageRouteBuilder(
//            pageBuilder: (c, a1, a2) => SprintGoalTutorial(),
//            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
//            transitionDuration: Duration(milliseconds: 300),
//          ),
//        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
          width: 257,
          height: 170,
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
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, right: 11),
                      child: Image.asset("assets/images/empathizetimeline-1.png", scale: 1,),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, bottom: 20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("User Interview",
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildShadowingCard(BuildContext context){
    return GestureDetector(
      onTap: (){
//        Navigator.push(
//          context,
//          PageRouteBuilder(
//            pageBuilder: (c, a1, a2) => SprintGoalTutorial(),
//            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
//            transitionDuration: Duration(milliseconds: 300),
//          ),
//        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
          width: 257,
          height: 170,
          decoration: BoxDecoration(
              color: Color(0xff787CD1),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, right: 11),
                      child: Image.asset("assets/images/empathizetimeline-2.png", scale: 1,),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, bottom: 20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Shadowing",
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMappingInsightsCard(BuildContext context){
    return GestureDetector(
      onTap: (){
//        Navigator.push(
//          context,
//          PageRouteBuilder(
//            pageBuilder: (c, a1, a2) => SprintGoalTutorial(),
//            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
//            transitionDuration: Duration(milliseconds: 300),
//          ),
//        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
          width: 257,
          height: 170,
          decoration: BoxDecoration(
              color: Color(0xffFFB8B8),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, right: 11),
                      child: Image.asset("assets/images/empathizetimeline-3.png", scale: 1,),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, bottom: 20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Mapping Insights",
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNonFilledContainer(BuildContext context){
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(50))
      ),
    );
  }

  Widget buildFilledContainer(BuildContext context){
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff787CD1),
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(50))
      ),
    );
  }

  Widget buildContainerSeperater(BuildContext context){
    return Container(
      height: 170,
      width: 1,
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
    );
  }

  Widget buildFilledContainerSeperater(BuildContext context){
    return Container(
      height: 170,
      width: 2,
      decoration: BoxDecoration(
        color: Color(0xff787cd1),
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => UserTestingInsideSections3(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Center(
        child: Container(
          height: 45,
          width: 146,
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
