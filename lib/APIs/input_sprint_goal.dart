import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/create_team_sections_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'dart:convert';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:design_sprint/utils/sprint_goal_data.dart' as goal;

class InputGoalApiProvider {

  Future<String> inputSprintGoal(context) async {

    String url = globals.urlLogin + "creategoal.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID" : home.sprintID,
      "goalname" : goal.goalController.text,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      goal.responseArrayCreateGoal = jsonDecode(response.body);
      print(goal.responseArrayCreateGoal);

      goal.responseArrayCreateGoalMsg = goal.responseArrayCreateGoal['message'].toString();

      if(statusCode == 200){
        if(goal.responseArrayCreateGoalMsg == "Goal Added Successfully"){
          goal.prInputGoal.hide();
          Fluttertoast.showToast(msg: goal.goalSaved, backgroundColor: Colors.black,
            textColor: Colors.white,).whenComplete((){
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => CreateTeamSections(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          });
        }else if(goal.responseArrayCreateGoalMsg == "Goal Added Successfully, E-Mail Not Verified"){
          goal.prInputGoal.hide();
          Fluttertoast.showToast(msg: goal.goalSaved, backgroundColor: Colors.black,
            textColor: Colors.white,).whenComplete((){
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => CreateTeamSections(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          });
        }else{
          goal.prInputGoal.hide();
          Fluttertoast.showToast(msg: goal.responseArrayCreateGoalMsg, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }

    });
  }

}