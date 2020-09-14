import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/JourneyMap/journey_map_pain_points_listView.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;

class CreateJourneyApiProvider{
  Future<String> createJourneyMapName(context) async {

    String url = globals.urlLogin + "createjourneymap.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID" : home.sprintID,
      "journeymapname" : empathize.journeyNameController.text,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayJourneyMapName = jsonDecode(response.body);
      print(empathize.responseArrayJourneyMapName);

      empathize.responseArrayJourneyMapNameMsg = empathize.responseArrayJourneyMapName['message'].toString();
      if(statusCode == 200){
        if(empathize.responseArrayJourneyMapNameMsg == "Journey Map Added Successfully"){
          empathize.prJourneyMapName.hide().whenComplete((){
            empathize.journeyMapId = empathize.responseArrayJourneyMapName['data'].toString();
            print(empathize.journeyMapId);
            Navigator.of(context).pop();
            Fluttertoast.showToast(msg: empathize.journeyMapSaved, backgroundColor: Colors.black,
              textColor: Colors.white,);
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => JourneyMapPainPointsListView(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          });
        }else{
          empathize.prJourneyMapName.hide().whenComplete((){
            Fluttertoast.showToast(msg: empathize.responseArrayJourneyMapNameMsg, backgroundColor: Colors.black,
              textColor: Colors.white,);
          });

        }
      }
    });
  }
}