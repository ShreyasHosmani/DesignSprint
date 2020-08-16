import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/input_time_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignSprintInside extends StatefulWidget {
  @override
  _DesignSprintInsideState createState() => _DesignSprintInsideState();
}

class _DesignSprintInsideState extends State<DesignSprintInside> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: buildProfileDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            buildName2Widget(context),
            SizedBox(height: 25,),
            buildDesignSprintCard(context),
            SizedBox(height: 25,),
            buildViewSprintCard(context),
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
        child: Text("Design Sprint",
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

  Widget buildName2Widget(BuildContext context){

    return Center(
      child: Text("Home",
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

  Widget buildDesignSprintCard(BuildContext context){
    return GestureDetector(
      onTap: (){
        showAlertDialog(context);
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
                    child: Text("Start new",
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
                    child: Text("Design Sprint",
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

  Widget buildViewSprintCard(BuildContext context){
    return Card(
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
                  child: Text("Continue/View",
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
                  child: Text("Design Sprints",
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

  showAlertDialog(BuildContext context) {

    Widget textField = Theme(
      data: ThemeData(
        primaryColor: Color(0xff787CD1),
      ),
        child: TextFormField(
      decoration: InputDecoration(
          hintText: 'Sprint Name'
      ),
    ));

    GestureDetector buildSaveButton = GestureDetector(
      onTap: (){
        Navigator.of(context).pop();
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => InputTimeline(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
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
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(icon: Icon(Icons.close,color: Colors.grey,),onPressed: (){Navigator.of(context).pop();},)),
          SizedBox(height: 10,),
          Text("What would you like to name", style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 16, letterSpacing: 1),)),
          Text("your sprint?",style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 16, letterSpacing: 1),)),
          SizedBox(height: 10,)
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: MediaQuery.of(context).size.height/3.5,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              textField,
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
