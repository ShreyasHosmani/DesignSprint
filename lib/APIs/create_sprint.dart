import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/input_time_line.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;

class CreateSprintApiProvider{

  Future<String> createSprint(context) async {

    String url = globals.urlLogin + "createsprint.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintname" : home.sprintNameController.text,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      home.responseArrayCreateSprint = jsonDecode(response.body);
      print(home.responseArrayCreateSprint);

      home.responseArrayCreateSprintMsg = home.responseArrayCreateSprint['message'].toString();
      if(statusCode == 200){
        if(home.responseArrayCreateSprintMsg == "Sprint Added Successfully"){
          home.prCreateSprint.hide();

          home.sprintID = home.responseArrayCreateSprint['data'].toString();
          print(home.sprintID);
          home.savedSprintName = home.responseArrayCreateSprint['data1'].toString();
          print(home.savedSprintName);

          Fluttertoast.showToast(msg: home.sprintNameSaved, backgroundColor: Colors.black,
            textColor: Colors.white,).whenComplete((){
            Navigator.of(context).pop();
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => InputTimeline(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          });
        }else{
          home.prCreateSprint.hide();
          Fluttertoast.showToast(msg: home.responseArrayCreateSprintMsg, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

  Future<String> getSprints(context) async {

    String url = globals.urlLogin + "getsprint.php";

    http.post(url, body: {

      "userID" : profile.userID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      home.responseArrayGetSprints = jsonDecode(response.body);
      print(home.responseArrayGetSprints);

      home.responseArrayGetSprintsMsg = home.responseArrayGetSprints['message'].toString();
      if(statusCode == 200){
        if(home.responseArrayGetSprintsMsg == "Data Found"){

          home.sprintIdsList = List.generate(home.responseArrayGetSprints['data'].length, (i) => home.responseArrayGetSprints['data'][i]['sprintID'].toString());
          home.sprintTitlesList = List.generate(home.responseArrayGetSprints['data'].length, (i) => home.responseArrayGetSprints['data'][i]['sprintName'].toString());
          home.sprintStatusList = List.generate(home.responseArrayGetSprints['data'].length, (i) => home.responseArrayGetSprints['data'][i]['sprintStatus'].toString());

          print(home.sprintIdsList.toList());
          print(home.sprintTitlesList.toList());
          print(home.sprintStatusList.toList());

        }else{

          home.sprintIdsList = null;
          home.sprintTitlesList = null;
          home.sprintStatusList = null;

        }
      }
    });
  }

}