import 'package:design_sprint/APIs/get_warehouse_prototypes.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Prototyping/prototyping_tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/prototyping_data.dart' as prototype;
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'dart:convert';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/prototyping_data.dart' as prototype;

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ViewPrototypes extends StatefulWidget {
  final sprintid;
  ViewPrototypes(this.sprintid) : super();
  @override
  _ViewPrototypesState createState() => _ViewPrototypesState();
}

class _ViewPrototypesState extends State<ViewPrototypes> {
  Future<String> getAllPrototypeImages(context) async {

    String url = globals.urlSignUp + "getprototypeimagespainpointwise.php";

    http.post(url, body: {

      "sprintID" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      prototype.responseArrayGetPrototypeImagesPainPointWise = jsonDecode(response.body);
      print(prototype.responseArrayGetPrototypeImagesPainPointWise);

      prototype.responseArrayGetPrototypeImagesPainPointWiseMsg = prototype.responseArrayGetPrototypeImagesPainPointWise['message'].toString();
      print(prototype.responseArrayGetPrototypeImagesPainPointWiseMsg);

      if(prototype.responseArrayGetPrototypeImagesPainPointWiseMsg == "Painpoint Data Found"){

        setState(() {
          prototype.prototypeImagesPPWiseList = List.generate(prototype.responseArrayGetPrototypeImagesPainPointWise['data'].length, (i) => prototype.responseArrayGetPrototypeImagesPainPointWise['data'][i]['ptiImgpath'].toString());
        });

        print(prototype.prototypeImagesPPWiseList.toList());

      }else{

        setState(() {
          prototype.prototypeImagesPPWiseList = "1";
        });

      }

    });
  }
  GetWareHousePrototypesApiProvider getWareHousePrototypesApiProvider = GetWareHousePrototypesApiProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      home.selectedSprintId = widget.sprintid.toString();
    });
    print(home.selectedSprintId);
    setState(() {
      prototype.prototypeImagesPPWiseList = null;
    });
    getAllPrototypeImages(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: ProfileDrawerCommon(),
      bottomNavigationBar: buildCommentBottomBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            buildName2Widget(context),
            SizedBox(height: 25,),
            buildPrototypesListViewBuilder(context),
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
        padding: const EdgeInsets.only(top: 0),
        child: Text(prototype.title,
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
          onPressed: (){Navigator.of(context).pop();},
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

  Widget buildName2Widget(BuildContext context){

    return Center(
      child: Text(prototype.title,
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

  Widget buildPrototypesListViewBuilder(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35),
      child: prototype.prototypeImagesPPWiseList == "1" ? Center(
        child: Text("No Prototypes Found",
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )
          ),
        ),
      ) : prototype.prototypeImagesPPWiseList == null ? ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 2,
        itemBuilder: (context, i) => InkWell(
          onTap: (){

          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey.shade300,
              child: Container(
                width: 302,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  //color: Color(0xff96C3CB),
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ),
      ) :
      ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: prototype.prototypeImagesPPWiseList == null ? 0 : prototype.prototypeImagesPPWiseList.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.only(bottom: 45),
          child: GestureDetector(
            onTap: (){
              launch(globals.urlSignUp+prototype.prototypeImagesPPWiseList[i]);
            },
            child: Container(
              width: 302,
              height: 175,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: Color(0xffEBEBEB)),
                  image: DecorationImage(
                    image: NetworkImage(globals.urlSignUp+prototype.prototypeImagesPPWiseList[i]),
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCommentBottomBar(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => PrototypingTutorial(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        color: Color(0xff787cd1),
        child: Center(
          child: Text("Upload Prototypes",
            style: GoogleFonts.nunitoSans(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
