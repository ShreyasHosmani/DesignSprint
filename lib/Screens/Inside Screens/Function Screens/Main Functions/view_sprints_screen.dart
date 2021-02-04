import 'package:design_sprint/APIs/create_sprint.dart';
import 'package:design_sprint/APIs/delete_sprint.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_sprint_inside_sections.dart';
import 'package:flutter/material.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ViewSprints extends StatefulWidget {
  @override
  _ViewSprintsState createState() => _ViewSprintsState();
}

class _ViewSprintsState extends State<ViewSprints> {
  CreateSprintApiProvider createSprintApiProvider = CreateSprintApiProvider();
  DeleteSprintApiProvider deleteSprintApiProvider = DeleteSprintApiProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    home.sprintTitlesList = "1";
    createSprintApiProvider.getSprints(context).whenComplete((){
      Future.delayed(const Duration(seconds: 3), () {setState(() {});});
    });
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            buildName2Widget(context),
            SizedBox(height: 25,),
            buildSprintsListViewBuilder(context),
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
        child: Text(home.designSprint,
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

  Widget buildName2Widget(BuildContext context){

    return Center(
      child: Text(home.home,
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

  Widget buildSprintsListViewBuilder(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35),
      child: home.sprintTitlesList == "1" ? ListView.builder(
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
      ) :ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: home.sprintTitlesList == null ? 0 : home.sprintTitlesList.length,
        itemBuilder: (context, i) => home.sprintTitlesList == null ? Center(child: Text("You've not created any sprints yet.")) : InkWell(
          onTap: (){
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => ViewSprintInsideSections(home.sprintIdsList.reversed.toList()[i]),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 21),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 302,
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xff96C3CB),
                    ),
                    child: Stack(
                      children: [
                        Container(
                            width: 302,
                            child: Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,)),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 30),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 250),
                              child: Text(home.sprintTitlesList.reversed.toList()[i],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nunitoSans(
                                    textStyle: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30, bottom: 30),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(home.sprintStatusList.reversed.toList()[i] == "0" ? "Completed" : "Ongoing",
                              style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white,size: 20,),
                      onPressed: (){
                        setState(() {
                          home.selectedSprintIdForDeleting = home.sprintIdsList.reversed.toList()[i];
                        });
                        print(home.selectedSprintIdForDeleting);
                        deleteSprintApiProvider.deleteSprintFromSprints(context).whenComplete((){
                          Future.delayed(const Duration(seconds: 3), () {
                            createSprintApiProvider.getSprints(context).whenComplete((){
                              Fluttertoast.showToast(msg: "removing...", backgroundColor: Colors.black,
                                textColor: Colors.white,);
                              Future.delayed(const Duration(seconds: 3), () {setState(() {});});
                            });
                          });
                        });
                      },
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
