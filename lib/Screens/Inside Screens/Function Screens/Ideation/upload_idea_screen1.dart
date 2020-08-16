import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Ideation/crazy_eight_evaluation_screen2.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Ideation/ideation_inside_sections_screen2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

bool statusDrawer = false;
bool showImages = false;

class UploadIdea1 extends StatefulWidget {
  @override
  _UploadIdea1State createState() => _UploadIdea1State();
}

class _UploadIdea1State extends State<UploadIdea1> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showImages = false;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: statusDrawer == true ? buildStatusDrawer(context) : buildProfileDrawer(context),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                buildName2Widget(context),
                SizedBox(height: 68,),
                buildName3Widget(context),
                SizedBox(height: 35,),
                buildLevelContainer(context),
                SizedBox(height: 72,),
                buildNumberIndicator(context),
                SizedBox(height: 35,),
                buildName4Widget(context),
                SizedBox(height: 34,),
                buildUploadButton(context),
                SizedBox(height: 23,),
                showImages == false ? Container() : Text("Image.jpg",
                  style: GoogleFonts.nunitoSans(
                      color: Colors.grey,
                      fontSize: 12
                  ),
                ),
                showImages == false ? Container() : Text("Image-2.jpg",
                  style: GoogleFonts.nunitoSans(
                      color: Colors.grey,
                      fontSize: 12
                  ),
                ),
                showImages == false ? Container() : Text("Image-3.jpg",
                  style: GoogleFonts.nunitoSans(
                      color: Colors.grey,
                      fontSize: 12
                  ),
                ),
                SizedBox(height: 118,),
                buildNextButton(context),
                SizedBox(height: 52,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: statusBarDrawer(context),
          ),
        ],
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
        child: Text("Ideation",
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
      child: Text("Crazy 8",
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
      child: Text("Upload the picture of all the\nideas you created.",
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
    return Center(
      child: Container(
        width: 286,
        height: 10,
        decoration: BoxDecoration(
            color: Color(0xff302B70),
            borderRadius: BorderRadius.all(Radius.circular(5))
        ),
      ),
    );
  }

  Widget buildNumberIndicator(BuildContext context){
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Color(0xff787cd1)
      ),
      child: Center(
        child: Text("1",
          style: GoogleFonts.nunitoSans(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget buildName4Widget(BuildContext context){
    return Center(
      child: Text("Our users may find it difficult to use the\ncollaborative function and work along with\ntheir team using this workspace.",
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

  Widget buildUploadButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showGeneralDialog(
          barrierLabel: "Label",
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 400),
          context: context,
          pageBuilder: (context, anim1, anim2) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 195,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                          setState(() {
                            showImages = true;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 44,
                                height: 44,
                                child: Image.asset("assets/images/photo.png")),
                            SizedBox(height: 8.97,),
                            Text("Gallery",
                              style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 44,
                              height: 44,
                              child: Image.asset("assets/images/folder.png")),
                          SizedBox(height: 8.97,),
                          Text("File Manager",
                            style: GoogleFonts.nunitoSans(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff707070),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            );
          },
          transitionBuilder: (context, anim1, anim2, child) {
            return SlideTransition(
              position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
              child: child,
            );
          },
        );
//        Navigator.push(
//          context,
//          PageRouteBuilder(
//            pageBuilder: (c, a1, a2) => PersonaMainScreen(),
//            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
//            transitionDuration: Duration(milliseconds: 300),
//          ),
//        );
      },
      child: Center(
        child: Container(
          height: 37,
          width: 166,
          decoration: BoxDecoration(
              border: Border.all(color :Color(0xff302B70),width: 2),
              borderRadius: BorderRadius.all(Radius.circular(19))
          ),
          child: Center(
            child: Text("Upload",
              style: TextStyle(
                  color: Color(0xff302B70), letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => IdeationInsideSections2(),
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

  showAlertDialog(BuildContext context) {

    GestureDetector buildSaveButton = GestureDetector(
      onTap: (){
        Navigator.of(context).pop();
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => CrazyEightEvaluation2(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
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
              borderRadius: BorderRadius.all(Radius.circular(50))
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
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(icon: Icon(Icons.close,color: Colors.grey,),onPressed: (){Navigator.of(context).pop();},)),
          SizedBox(height: 10,),
          Text("Time Up", style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 16, letterSpacing: 1, color: Color(0xff787cd1)),)),
          Text("",style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 16, letterSpacing: 1),)),
          SizedBox(height: 10,)
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: MediaQuery.of(context).size.height/3.8,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                  height: 96,
                  width: 96,
                  child: Image.asset("assets/images/timer-image.png")),
              SizedBox(height: 40,),
              buildSaveButton,
            ],
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
