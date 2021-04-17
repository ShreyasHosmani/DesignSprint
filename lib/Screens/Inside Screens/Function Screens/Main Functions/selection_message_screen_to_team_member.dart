import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Ideation/crazy_8_tutorial_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_sprint_inside_sections.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Prototyping/prototyping_tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/home_screen_data.dart' as home;

var s5;
var s8;

class ShowSelectionMessage extends StatefulWidget {
  @override
  _ShowSelectionMessageState createState() => _ShowSelectionMessageState();
}

class _ShowSelectionMessageState extends State<ShowSelectionMessage> {

  Future<String> getSprintsStatuses(context) async {

    String url = globals.urlLogin + "getsprintstatus.php";

    http.post(url, body: {

      //"userID" : profile.userID,
      "userEmail" : dmEmailId.toString(),
      "sprintID" : home.selectedSprintId.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayGetSprintStatuses = jsonDecode(response.body);
      print(responseArrayGetSprintStatuses);

      var responseArrayGetSprintStatusesMsg = responseArrayGetSprintStatuses['message'].toString();
      if(statusCode == 200){
        if(responseArrayGetSprintStatusesMsg == "Data Found"){

          setState(() {
            s5 = responseArrayGetSprintStatuses['data']['sprintstatusStep5'].toString();
            s8 = responseArrayGetSprintStatuses['data']['sprintstatusStep8'].toString();
          });

          print(s5);
          print(s8);

        }else{

          setState(() {

          });

        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSprintsStatuses(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: s5 == "0" && s8 == "0" ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.warning, color: Color(0xff787cd1), size: 100,),
              Text("Please wait for the decision maker to select the final pain points. We will let you know once decision maker has selected the final pain points!",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  color: Colors.black,
                  fontSize: 18
                ),
              ),
            ],
          ) : s5 == "1" && s8 == "0" ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.done, color: Colors.green, size: 100,),
              SizedBox(height: 10,),
              Text("The final pain points have been selected. Press NEXT to proceed.",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                    color: Colors.black,
                    fontSize: 18
                ),
              ),
              SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (c, a1, a2) => Crazy8Tutorial(),
                      transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                      transitionDuration: Duration(milliseconds: 300),
                    ),
                  );
                },
                child: Container(
                  width: 150,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color(0xff787cd1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text("Next",
                      style: TextStyle(
                          color: Colors.white, letterSpacing: 1, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ) : s5 == "1" && s8 == "1" ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.done, color: Colors.green, size: 100,),
              SizedBox(height: 10,),
              Text("The final ideas have been selected. Press NEXT to proceed.",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                    color: Colors.black,
                    fontSize: 18
                ),
              ),
              SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (c, a1, a2) => PrototypingTutorial(),
                      transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                      transitionDuration: Duration(milliseconds: 300),
                    ),
                  );
                },
                child: Container(
                  width: 150,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color(0xff787cd1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text("Next",
                      style: TextStyle(
                          color: Colors.white, letterSpacing: 1, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ) : Container(),
        ),
      ),
    );
  }
}
