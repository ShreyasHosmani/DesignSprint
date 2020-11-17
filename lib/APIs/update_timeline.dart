import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/tutorial_sprint_goal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/timeline_data.dart' as timeline;

class UpdateTimelineApiProvider{
  Future<String> updateTimeLine(context) async {

    String url = globals.urlLogin + "updatetimeline.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID" : home.sprintID,
      "timeline" : timeline.selectedTimeline,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      home.responseArrayUpdateTimeLine = jsonDecode(response.body);
      print(home.responseArrayUpdateTimeLine);

      home.responseArrayTimelineMsg = home.responseArrayUpdateTimeLine['message'].toString();
      if(statusCode == 200){
        if(home.responseArrayTimelineMsg == "Timeline updated Successfully"){
          home.prCreateSprint.hide();
          Fluttertoast.showToast(msg: home.timelineSaved, backgroundColor: Colors.black,
            textColor: Colors.white,).whenComplete((){
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => SprintGoalTutorial(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          });
        }else if(home.responseArrayTimelineMsg == "Timeline updated Successfully. E-Mail Not Verified"){
          home.prCreateSprint.hide();
          Fluttertoast.showToast(msg: home.timelineSaved, backgroundColor: Colors.black,
            textColor: Colors.white,).whenComplete((){
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => SprintGoalTutorial(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          });
        }else{
          home.prCreateSprint.hide();
          Fluttertoast.showToast(msg: home.responseArrayTimelineMsg, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }
}