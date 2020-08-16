import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/IdentifyPainPoints/select_final_painpoints.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

bool statusDrawer = false;

class VotePainPoints extends StatefulWidget {
  @override
  _VotePainPointsState createState() => _VotePainPointsState();
}

class _VotePainPointsState extends State<VotePainPoints> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    containerColorList = [Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, ];
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            buildName2Widget(context),
            SizedBox(height: 20,),
            buildName3Widget(context),
            SizedBox(height: 20,),
            buildLevelContainer(context),
            SizedBox(height: 46,),
            buildPainPointNumberIndicator(context),
            SizedBox(height: 46,),
            buildName4Widget(context),
            SizedBox(height: 74,),
            buildName5Widget(context),
            SizedBox(height: 25,),
            buildVoteRow(context),
            SizedBox(height: MediaQuery.of(context).size.height/10,),
            buildNextButton(context),
            SizedBox(height: 25,),
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
        child: Text("Emphatize",
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
      child: Text("Identify Pain Points",
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
      child: Text("Vote of each idea based on its\n               Importance.",
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
          child: Text("25",
            style: GoogleFonts.nunitoSans(
              fontSize: 16,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

  Widget buildName4Widget(BuildContext context){

    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 36),
      child: Center(
        child: Text("Our users may find it difficult to use the collaborative function and work along with their team using this workspace.",
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
              )
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildName5Widget(BuildContext context){

    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 36),
      child: Center(
        child: Text("Importance",
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildVoteRow(BuildContext context){

    Container colorContainer = Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Color(0xff787CD1),
      ),
    );

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
                      });
                      print(selectedIndex);
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

  Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => SelectFinalPainPoints(),
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

}

var containerColorList = [Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, Colors.white, ];
var selectedIndex;