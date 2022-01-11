import 'package:design_sprint/APIs/get_sprint_goal.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/Personas/persona_tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:design_sprint/utils/sprint_goal_data.dart' as goal;

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
var goalIdForEdit;
TextEditingController goalEditController = TextEditingController();

class ViewSprintGoal extends StatefulWidget {
  final sprintid;
  final dmID;
  ViewSprintGoal(this.sprintid, this.dmID) : super();
  @override
  _ViewSprintGoalState createState() => _ViewSprintGoalState();
}

class _ViewSprintGoalState extends State<ViewSprintGoal> {
  GetSprintGoalApiProvider getSprintGoalApiProvider = GetSprintGoalApiProvider();
  Future<String> editSprintGoal(context) async {

    String url = globals.urlLogin + "editsprintgoal.php";

    http.post(url, body: {

      "sprintID" : widget.sprintid,
      "text" : goalEditController.text.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayEditGoal = jsonDecode(response.body);
      print(responseArrayEditGoal);

      var responseArrayEditGoalMsg = responseArrayEditGoal['message'].toString();

      if(statusCode == 200){
        if(responseArrayEditGoalMsg == "Goal Edited Successfully"){

          goal.prInputGoal.hide();
          Fluttertoast.showToast(msg: goal.goalSaved, backgroundColor: Colors.black,
            textColor: Colors.white,);

        }else{

          goal.prInputGoal.hide();
          Fluttertoast.showToast(msg: 'Please check your network connection!', backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }

    });
  }
  Future<String> editSprintGoal2(context) async {

    String url = globals.urlLogin + "editsprintgoal.php";

    http.post(url, body: {

      "sprintID" : widget.sprintid,
      "text" : goalEditController.text.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayEditGoal = jsonDecode(response.body);
      print(responseArrayEditGoal);

      var responseArrayEditGoalMsg = responseArrayEditGoal['message'].toString();

      if(statusCode == 200){
        if(responseArrayEditGoalMsg == "Goal Edited Successfully"){

          goal.prInputGoal.hide();
          // Fluttertoast.showToast(msg: goal.goalSaved, backgroundColor: Colors.black,
          //   textColor: Colors.white,);

        }else{

          goal.prInputGoal.hide();
          // Fluttertoast.showToast(msg: 'Please check your network connection!', backgroundColor: Colors.black,
          //   textColor: Colors.white,);
        }
      }

    });
  }
  Future<String> updateStep1(context) async {

    String url = globals.urlSignUp + "updatesprintstatus.php";

    http.post(url, body: {

      "userID" : profile.email,
      "sprintID" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
      "stepID" : "1",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayUpdateStatus = jsonDecode(response.body);
      print(responseArrayUpdateStatus);

      var responseArrayUpdateStatusMsg = responseArrayUpdateStatus['message'].toString();
      print(responseArrayUpdateStatusMsg);
      if(statusCode == 200){
        if(responseArrayUpdateStatusMsg == "Timeline updated Successfully"){
          print("Status updated!!");
        }else{

        }
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateStep1(context);
    home.sprintGoalList = "1";
    home.selectedSprintId = widget.sprintid;
    print(home.selectedSprintId);
    print(widget.dmID + "---" + profile.userID);
    getSprintGoalApiProvider.getSprintGoal(context).whenComplete((){
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {});
        goalEditController = TextEditingController(text: home.sprintGoalList);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    goal.prInputGoal = ProgressDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: ProfileDrawerCommon(),
      body: GestureDetector(
        onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              buildName2Widget(context),
              SizedBox(height: 25,),
              buildName3Widget(context),
              SizedBox(height: 40,),
              buildGoalTextField(context),
              SizedBox(height: 40,),
              buildNextButton(context),
            ],
          ),
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
          onPressed: (){
            editSprintGoal2(context).whenComplete((){
              Navigator.of(context).pop();
            });
          },
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
      child: Text(home.defineGoal,
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
      child: Text(home.sprintGoal,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500
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

  Widget buildGoalTextField(BuildContext context){

    int currentTextLength = 0;

    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 36),
      child: Container(
        height: 443,
        width: 302,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Color(0xffCFCFCF)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
          child: home.sprintGoalList == "1" ? Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.grey.shade500,
            child: Text("The Sprint Goal is an objective set for the Sprint that can be met through the implementation of Product Backlog.",
              style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    color: Color(0xff707070),
                    fontSize: 16,
                  )
              ),
            ),
          ) : widget.dmID == profile.userID ? TextFormField(
            maxLines: (MediaQuery.of(context).size.height/50).toInt(),
            controller: goalEditController,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: (String newText){
              if(newText[0] != '•'){
                newText = '• ' + newText;
                goalEditController.text = newText;
                goalEditController.selection = TextSelection.fromPosition(TextPosition(offset: goalEditController.text.length));
              }
              if(newText[newText.length - 1] == '\n' && newText.length > currentTextLength){
                goalEditController.text = newText + '• ';
                goalEditController.selection = TextSelection.fromPosition(TextPosition(offset: goalEditController.text.length));
              }
              currentTextLength = goalEditController.text.length;
            },
            validator: (value){
              if(value.isEmpty){
                return 'Goal cannot be empty!';
              }
              return null;
            },
            onEditingComplete: (){
              editSprintGoal(context);
            },
            // onChanged: (val){
            //   editSprintGoal(context);
            // },
          ) : Text(home.sprintGoalList,
            style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(
                  color: Color(0xff707070),
                  fontSize: 16,
                )
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        editSprintGoal(context).whenComplete((){
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => PersonaTutorial(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        });
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
