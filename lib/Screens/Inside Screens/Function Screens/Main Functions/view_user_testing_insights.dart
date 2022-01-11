import 'package:design_sprint/APIs/get_warehouse_insights.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/design_sprint_sections_screen4.dart';
import 'package:flutter/material.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/user_testing_data.dart' as userTesting;
import 'package:shimmer/shimmer.dart';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/user_testing_data.dart' as userTesting;

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ViewUserTestingInsights extends StatefulWidget {
  final sprintid;
  ViewUserTestingInsights(this.sprintid) : super();
  @override
  _ViewUserTestingInsightsState createState() => _ViewUserTestingInsightsState();
}

class _ViewUserTestingInsightsState extends State<ViewUserTestingInsights> {
  Future getWareHouseInsights(context) async {

    String url = globals.urlSignUp + "getalldata.php";

    http.post(url, body: {

      "sprintID" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      userTesting.responseArrayGetWareHouseInsights = jsonDecode(response.body);
      print(userTesting.responseArrayGetWareHouseInsights.toString());

      userTesting.responseArrayGetWareHouseInsightsMsg = userTesting.responseArrayGetWareHouseInsights['message'].toString();
      print(userTesting.responseArrayGetWareHouseInsightsMsg);

      if(userTesting.responseArrayGetWareHouseInsightsMsg == "Data Found"){

        setState(() {
          userTesting.wareHouseInsightsList = List.generate(userTesting.responseArrayGetWareHouseInsights['data3'].length, (i) => userTesting.responseArrayGetWareHouseInsights['data3'][i]['insightText'].toString());
        });

        print(userTesting.wareHouseInsightsList.toList());

      }else{

        setState(() {
          userTesting.wareHouseInsightsList = "1";
        });

      }

    });

  }
  GetWareHouseInsightsApiProvider getWareHouseInsightsApiProvider = GetWareHouseInsightsApiProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      home.selectedSprintId = widget.sprintid.toString();
      userTesting.wareHouseInsightsList = null;
    });
    getWareHouseInsights(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      bottomNavigationBar: buildCommentBottomBar(context),
      endDrawer: ProfileDrawerCommon(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            buildName2Widget(context),
            SizedBox(height: 25,),
            buildInsightsListViewBuilder(context),
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
        child: Text(userTesting.title,
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
      child: Text(userTesting.insightsForm,
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

  Widget buildInsightsListViewBuilder(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35),
      child: userTesting.wareHouseInsightsList == "1" ? Center(
        child: Text("No Insights Found",
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )
          ),
        ),
      ) : userTesting.wareHouseInsightsList == null || userTesting.wareHouseInsightsList.isEmpty ? ListView.builder(
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
        itemCount: userTesting.wareHouseInsightsList == null ? 0 : userTesting.wareHouseInsightsList.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.only(bottom: 21),
          child: Container(
            width: 302,
            height: 105.54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              border: Border.all(color: Color(0xffEBEBEB)),
//                image: DecorationImage(
//                  image: NetworkImage(""),
//                )
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: Text(userTesting.wareHouseInsightsList[i],
                  textAlign: TextAlign.start,
                  style: GoogleFonts.nunitoSans(),
                ),
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
            pageBuilder: (c, a1, a2) => EmphatizeSections4(),
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
          child: Text("Add Insights",
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
