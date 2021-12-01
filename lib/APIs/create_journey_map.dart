import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/JourneyMap/journey_map_pain_points_listView.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:shared_preferences/shared_preferences.dart';

class CreateJourneyApiProvider{

  Future<String> updateStep3(context) async {

    String url = globals.urlSignUp + "updatesprintstatus.php";

    http.post(url, body: {

      "userID" : profile.email,
      "sprintID" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
      "stepID" : "3",

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

  Future<String> createJourneyMapName(context) async {

    String url = globals.urlLogin + "createjourneymap.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
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
            updateStep3(context);
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

  Future<String> uploadPaperJourneyMap(context) async {

    String url = globals.urlSignUp + "createjourneymaponpaper.php";

    empathize.baseImagePaperJourneyMap = base64Encode(empathize.imagePaperJourneyMap.readAsBytesSync());

    empathize.fileNamePaperJourneyMap = empathize.imagePaperJourneyMap.path.split("/").last;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('test_image', empathize.imagePaperJourneyMap.path);

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
      "image" : empathize.baseImagePaperJourneyMap.toString(),
      "name" : empathize.fileNamePaperJourneyMap.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayUploadPaperJourneyMap = jsonDecode(response.body);
      print(empathize.responseArrayUploadPaperJourneyMap);

      empathize.responseArrayUploadPaperJourneyMapMsg = empathize.responseArrayUploadPaperJourneyMap['message'].toString();
      print(empathize.responseArrayUploadPaperJourneyMapMsg);
      if(statusCode == 200){
        if(empathize.responseArrayUploadPaperJourneyMapMsg == "Journeymap Added Successfully"){
          Fluttertoast.showToast(msg: empathize.personaUploaded, backgroundColor: Colors.black,
            textColor: Colors.white,gravity: ToastGravity.CENTER);
          updateStep3(context);
        }else{
          Fluttertoast.showToast(msg: empathize.responseArrayUploadPaperJourneyMapMsg, backgroundColor: Colors.black,
            textColor: Colors.white,gravity: ToastGravity.CENTER);
        }
      }
    });
  }

  Future<String> getJourneyMapDetails(context) async {

    String url = globals.urlSignUp + "getjourneymap.php";

    http.post(url, body: {

      "sprintID": home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayGetJourneyMap = jsonDecode(response.body);
      print(empathize.responseArrayGetJourneyMap);

      empathize.responseArrayGetJourneyMapMsg = empathize.responseArrayGetJourneyMap['message'].toString();
      print(empathize.responseArrayGetJourneyMapMsg);
      if(statusCode == 200){
        if(empathize.responseArrayGetJourneyMapMsg == "Data Found"){

          empathize.journeyMapImageNamesList = List.generate(empathize.responseArrayGetJourneyMap['data'].length, (i) => empathize.responseArrayGetJourneyMap['data'][i]['jpdocImage']);

          print(empathize.journeyMapImageNamesList.toList());

        }else{

          empathize.journeyMapImageNamesList = null;

        }
      }
    });
  }

  Future<String> deleteJourneyMapName(context) async {

    Navigator.of(context).pop();
    Navigator.of(context).pop();

    String url = globals.urlLogin + "deletejourneymap.php";

    http.post(url, body: {

      "mapID" : empathize.journeyMapId.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayDeleteJourneyMap = jsonDecode(response.body);
      print(empathize.responseArrayDeleteJourneyMap);

      empathize.responseArrayDeleteJourneyMapMsg = empathize.responseArrayDeleteJourneyMap['message'].toString();
      if(statusCode == 200){
        if(empathize.responseArrayDeleteJourneyMapMsg == "Journey Map deleted"){

        }else{

        }
      }
    });
  }

  Future<String> createNewJourneyMapName(context) async {

    String url = globals.urlLogin + "createjourneymap.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
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
            Navigator.pushReplacement(
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