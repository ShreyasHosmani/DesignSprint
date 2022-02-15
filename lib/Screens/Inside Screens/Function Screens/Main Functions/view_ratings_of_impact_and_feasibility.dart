import 'package:design_sprint/APIs/warehouse_get_ivsf_and_selected_ideaimages.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:flutter/material.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/ideation_data.dart' as ideation;
import 'package:design_sprint/utils/warehouse_ivsf_and_selected_ideas_data.dart' as ratingsWH;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:shimmer/shimmer.dart';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/warehouse_ivsf_and_selected_ideas_data.dart' as ratingsWH;
import 'dart:convert';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ViewRatingsOfImpactAndFeasibility extends StatefulWidget {
  @override
  _ViewRatingsOfImpactAndFeasibilityState createState() => _ViewRatingsOfImpactAndFeasibilityState();
}

class _ViewRatingsOfImpactAndFeasibilityState extends State<ViewRatingsOfImpactAndFeasibility> {

  /*Future<String> getImpactAndFeasibilityRatings(context) async {

    String url = globals.urlSignUp + "getWareHouseImpactsAndFeasibilityRatings.php";

    http.post(url, body: {

      "sprintID": home.selectedSprintId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ratingsWH.responseArrayGetWareHouseIvsF = jsonDecode(response.body);
      print(ratingsWH.responseArrayGetWareHouseIvsF);

      ratingsWH.responseArrayGetWareHouseIvsFMsg = ratingsWH.responseArrayGetWareHouseIvsF['message'].toString();
      print(ratingsWH.responseArrayGetWareHouseIvsFMsg);
      if(statusCode == 200){
        if(ratingsWH.responseArrayGetWareHouseIvsFMsg == "Painpoint Data Found"){

          setState(() {
            ratingsWH.impactRatingsList = List.generate(ratingsWH.responseArrayGetWareHouseIvsF['data'].length, (i) => ratingsWH.responseArrayGetWareHouseIvsF['data'][i]['imapctVote'].toString());
            ratingsWH.feasibilityRatingsList = List.generate(ratingsWH.responseArrayGetWareHouseIvsF['data'].length, (i) => ratingsWH.responseArrayGetWareHouseIvsF['data'][i]['feasibilityVote'].toString());
            ratingsWH.ideaImagesList = List.generate(ratingsWH.responseArrayGetWareHouseIvsF['data'].length, (i) => ratingsWH.responseArrayGetWareHouseIvsF['data'][i]['iiImgpath'].toString());

            print(ratingsWH.impactRatingsList.toList());
            print(ratingsWH.feasibilityRatingsList.toList());
            print(ratingsWH.ideaImagesList.toList());
          });

        }else{

          setState(() {
            ratingsWH.impactRatingsList = "1";
          });

        }
      }
    });
  }*/

  Future<String> getImpactVsFeasibilityIdeaWarehouseData(context) async {

    print("Getting ratings...");
    print("ivSprintId : "+home.selectedSprintId.toString());

    String url = globals.urlSignUp + "getIvsFIdeaWarehouseData.php";

    http.post(url, body: {

      "ivSprintId": home.selectedSprintId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ratingsWH.responseArrayGetWareHouseIvsF = jsonDecode(response.body);
      print(ratingsWH.responseArrayGetWareHouseIvsF);

      ratingsWH.responseArrayGetWareHouseIvsFMsg = ratingsWH.responseArrayGetWareHouseIvsF['message'].toString();
      print(ratingsWH.responseArrayGetWareHouseIvsFMsg);
      if(statusCode == 200){
        if(ratingsWH.responseArrayGetWareHouseIvsFMsg == "successfully"){

          setState(() {
            ratingsWH.impactRatingsList = List.generate(ratingsWH.responseArrayGetWareHouseIvsF['data'].length, (i) => ratingsWH.responseArrayGetWareHouseIvsF['data'][i]['avgImpactvote'].toString());
            ratingsWH.feasibilityRatingsList = List.generate(ratingsWH.responseArrayGetWareHouseIvsF['data'].length, (i) => ratingsWH.responseArrayGetWareHouseIvsF['data'][i]['avgFeasiblevote'].toString());
            ratingsWH.ideaImagesList = List.generate(ratingsWH.responseArrayGetWareHouseIvsF['data'].length, (i) => ratingsWH.responseArrayGetWareHouseIvsF['data'][i]['iiImgpath'].toString());

            print(ratingsWH.impactRatingsList.toList());
            print(ratingsWH.feasibilityRatingsList.toList());
            print(ratingsWH.ideaImagesList.toList());
          });

        }else{

          setState(() {
            ratingsWH.impactRatingsList = "1";
          });

        }
      }
    });
  }

  WareHouseratingsWHRatingsApiProvider wareHouseratingsWHRatingsApiProvider = WareHouseratingsWHRatingsApiProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      ratingsWH.impactRatingsList = null;
    });
    //setState(() {
      borderColors = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),];
      colors1 = [Color(0xff787cd1),Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,];
      colors2 = [Color(0xff787cd1),Color(0xff787cd1),Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,];
      colors3 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,];
      colors4 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,];
      colors5 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,];
      colors6 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Colors.white,Colors.white,Colors.white,Colors.white,];
      colors7 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Colors.white,Colors.white,Colors.white,];
      colors8 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Colors.white,Colors.white,];
      colors9 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Colors.white,];
      colors10 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1)];
    //});
    //getImpactAndFeasibilityRatings(context);
    getImpactVsFeasibilityIdeaWarehouseData(context);
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
            SizedBox(height: 10,),
            buildName2Widget(context),
            SizedBox(height: 25,),
            buildRatingsListViewBuilder(context),
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
        child: Text(ideation.title,
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
      child: Text(ideation.ivsfanalysis + " Documents",
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

  Widget buildRatingsListViewBuilder(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: ratingsWH.impactRatingsList == "1" ? Center(
        child: Text("No Ratings Found",
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )
          ),
        ),
      ) : ratingsWH.impactRatingsList == null ? ListView.builder(
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
      ) : ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: ratingsWH.impactRatingsList == null ? 0 : ratingsWH.impactRatingsList.length,
        itemBuilder: (context, i) => InkWell(
          onTap: (){
            print(ratingsWH.impactRatingsList[i]);
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 45),
            child: Container(
              width: 302,
              height: 276,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE5E5E5)),
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 161,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE5E5E5)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                      color: Color(0xff787cd1),
                    image: DecorationImage(
                      image: NetworkImage(globals.urlSignUp+ratingsWH.ideaImagesList[i]),
                    )
                    ),
                  ),
                  SizedBox(height: 25,),
                  Center(
                    child: Container(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 15,),
                          Text("Average Impact      :    "+ratingsWH.impactRatingsList[i].toString()+" / 10"),
                          /*SizedBox(width: 10,),
                          ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, i2) => Row(
                              children: [
                                ratingsWH.impactRatingsList[i] == "1" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors1[i2],
                                  ),
                                ) : ratingsWH.impactRatingsList[i] == "2" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors2[i2],
                                  ),
                                ) : ratingsWH.impactRatingsList[i] == "3" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors3[i2],
                                  ),
                                ) : ratingsWH.impactRatingsList[i] == "4" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors4[i2],
                                  ),
                                ) : ratingsWH.impactRatingsList[i] == "5" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors5[i2],
                                  ),
                                ) : ratingsWH.impactRatingsList[i] == "6" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors6[i2],
                                  ),
                                ) : ratingsWH.impactRatingsList[i] == "7" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors7[i2],
                                  ),
                                ) :ratingsWH.impactRatingsList[i] == "8" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors8[i2],
                                  ),
                                ) : ratingsWH.impactRatingsList[i] == "9" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors9[i2],
                                  ),
                                ) : Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors10[i2],
                                  ),
                                ),
                                SizedBox(width: 5,),
                              ],
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text("10"),*/
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Center(
                    child: Container(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 15,),
                          Text("Average Feasibility      :    "+ratingsWH.feasibilityRatingsList[i].toString()+" / 10"),
                          /*ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, i2) => Row(
                              children: [
                                ratingsWH.feasibilityRatingsList[i] == "1" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors1[i2],
                                  ),
                                ) : ratingsWH.feasibilityRatingsList[i] == "2" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors2[i2],
                                  ),
                                ) : ratingsWH.feasibilityRatingsList[i] == "3" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors3[i2],
                                  ),
                                ) : ratingsWH.feasibilityRatingsList[i] == "4" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors4[i2],
                                  ),
                                ) : ratingsWH.feasibilityRatingsList[i] == "5" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors5[i2],
                                  ),
                                ) : ratingsWH.feasibilityRatingsList[i] == "6" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors6[i2],
                                  ),
                                ) : ratingsWH.feasibilityRatingsList[i] == "7" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors7[i2],
                                  ),
                                ) :ratingsWH.feasibilityRatingsList[i] == "8" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors8[i2],
                                  ),
                                ) : ratingsWH.feasibilityRatingsList[i] == "9" ? Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors9[i2],
                                  ),
                                ) : Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(color: Color(0xff787cd1)),
                                    color: colors10[i2],
                                  ),
                                ),
                                SizedBox(width: 5,),
                              ],
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text("10"),*/
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

List<Color> borderColors = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),];
List<Color> colors1 = [Color(0xff787cd1),Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,];
List<Color> colors2 = [Color(0xff787cd1),Color(0xff787cd1),Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,];
List<Color> colors3 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,];
List<Color> colors4 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,];
List<Color> colors5 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,];
List<Color> colors6 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Colors.white,Colors.white,Colors.white,Colors.white,];
List<Color> colors7 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Colors.white,Colors.white,Colors.white,];
List<Color> colors8 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Colors.white,Colors.white,];
List<Color> colors9 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Colors.white,];
List<Color> colors10 = [Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1),Color(0xff787cd1)];
