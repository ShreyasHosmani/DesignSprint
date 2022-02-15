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
import 'package:url_launcher/url_launcher.dart';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/warehouse_ivsf_and_selected_ideas_data.dart' as ratingsWH;
import 'dart:convert';

var ppImage;
var ppPId;
var ppNameList;

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ViewSelectedIdeas extends StatefulWidget {
  @override
  _ViewSelectedIdeasState createState() => _ViewSelectedIdeasState();
}

class _ViewSelectedIdeasState extends State<ViewSelectedIdeas> {

  /*Future<String> getIdeaImagesByStatus(context) async {

    String url = globals.urlSignUp + "getideaimagesbystatus.php";

    http.post(url, body: {

      "sprintID" : home.selectedSprintId.toString(),
      "status" : "2",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ratingsWH.responseArrayGetAllIdeaImagesByStatus = jsonDecode(response.body);
      print(ratingsWH.responseArrayGetAllIdeaImagesByStatus);

      ratingsWH.responseArrayGetAllIdeaImagesByStatusMsg = ratingsWH.responseArrayGetAllIdeaImagesByStatus['message'].toString();
      print(ratingsWH.responseArrayGetAllIdeaImagesByStatusMsg);

      if(ratingsWH.responseArrayGetAllIdeaImagesByStatusMsg == "Painpoint Data Found"){

        setState(() {
          ratingsWH.ideaAllImagesOfStatusTwo = List.generate(ratingsWH.responseArrayGetAllIdeaImagesByStatus['data'].length, (i) => ratingsWH.responseArrayGetAllIdeaImagesByStatus['data'][i]['iiImgpath'].toString());
        });

        print(ratingsWH.ideaAllImagesOfStatusTwo.toList());

      }else{

        setState(() {
          ratingsWH.ideaAllImagesOfStatusTwo = "1";
        });

      }

    });
  }*/

  Future<String> getIdeaImagesOfStatusTwoWithPainPoint(context) async {

    String url = globals.urlSignUp + "getIdeaImagesForPrototyping.php";

    http.post(url, body: {

      "sprintID" : home.selectedSprintId.toString(),//home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ideation.responseArrayGetAllIdeaImages = jsonDecode(response.body);
      print(ideation.responseArrayGetAllIdeaImages);

      ideation.responseArrayGetAllIdeaImagesMsg = ideation.responseArrayGetAllIdeaImages['message'].toString();
      print(ideation.responseArrayGetAllIdeaImagesMsg);

      if(ideation.responseArrayGetAllIdeaImagesMsg == "Data Found"){

        setState(() {
          ppImage = List.generate(ideation.responseArrayGetAllIdeaImages['data'].length, (i) => ideation.responseArrayGetAllIdeaImages['data'][i]['iiImgpath'].toString());
          ppPId = List.generate(ideation.responseArrayGetAllIdeaImages['data'].length, (i) => ideation.responseArrayGetAllIdeaImages['data'][i]['ppID'].toString());
          ppNameList = List.generate(ideation.responseArrayGetAllIdeaImages['data'].length, (i) => ideation.responseArrayGetAllIdeaImages['data'][i]['ppName'].toString());
          //setState(() {
          //_isLoaded = true;
          //});
        });

        print("02938923475r9");
        print("0000000000");
        print(ppImage.toList());
        print(ppPId.toList());
        print(ppNameList.toList());
        print("0000000000");

      }else{

        setState(() {
          ppImage = "1";
        });

      }

    });
  }

  WareHouseratingsWHRatingsApiProvider wareHouseratingsWHRatingsApiProvider = WareHouseratingsWHRatingsApiProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      ppImage = null;
    });
    getIdeaImagesOfStatusTwoWithPainPoint(context);
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
            buildSelectedIdeasListViewBuilder(context),
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

  Widget buildSelectedIdeasListViewBuilder(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35),
      child:
      ppImage == "1" ? Center(
        child: Text("No Selected Ideas Found",
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )
          ),
        ),
      ) : ppImage == null ? ListView.builder(
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
        itemCount: ppImage == null ? 0 : ppImage.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.only(bottom: 45),
          child: GestureDetector(
            onTap: (){
              launch(globals.urlSignUp+ppImage[i]);
            },
            child: Container(
              width: 302,
              height: 175,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: Color(0xffEBEBEB)),
                  image: DecorationImage(
                    image: NetworkImage(globals.urlSignUp+ppImage[i]),
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }

}
