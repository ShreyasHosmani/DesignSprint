import 'package:flutter/material.dart';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:shared_preferences/shared_preferences.dart';

class CreatePersonaApiProvider {

  Future<String> updateStep2(context) async {

    String url = globals.urlSignUp + "updatesprintstatus.php";

    http.post(url, body: {

      "userID" : profile.email,
      "sprintID" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
      "stepID" : "2",

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

  Future<String> createDigitalPersona(context) async {

    print("empathize.imageOne : "+empathize.imageOne.toString());

    String url = globals.urlSignUp + "createpersonadigitally.php";

    if(empathize.imageOne == null || empathize.imageOne.toString() == "null"){

    }else{
      empathize.baseImage = base64Encode(empathize.imageOne.readAsBytesSync());

      empathize.fileName = empathize.imageOne.path.split("/").last;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('test_image', empathize.imageOne.path);
    }

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
      "emapathizeid" : "null",
      "image" : empathize.baseImage.toString(),
      "imagename" : empathize.fileName.toString(),
      "name" : empathize.nameController.text,
      "age" : empathize.ageController.text,
      "location" : empathize.locationController.text,
      "education" : empathize.educationController.text,
      "job" : empathize.jobController.text,
      "bio" : empathize.bioController.text,
      "goals" : empathize.goalsAndMotivationController.text,
      "fears" : "null",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayCreatePersonaDigitally = jsonDecode(response.body);
      print(empathize.responseArrayCreatePersonaDigitally);

      empathize.responseArrayCreatePersonaDigitallyMsg = empathize.responseArrayCreatePersonaDigitally['message'].toString();
      print(empathize.responseArrayCreatePersonaDigitallyMsg);
      if(statusCode == 200){
        if(empathize.responseArrayCreatePersonaDigitallyMsg == "Persona Added Successfully"){
          empathize.prDigitalPersona.hide().whenComplete((){
            //clearFields(context);
            updateStep2(context);
            Fluttertoast.showToast(msg: empathize.personaSaved, backgroundColor: Colors.black,
              textColor: Colors.white,);
          });
        }else if(empathize.responseArrayCreatePersonaDigitallyMsg == "Unable To Add Persona"){
          empathize.prDigitalPersona.hide().whenComplete((){
            Fluttertoast.showToast(msg: empathize.responseArrayCreatePersonaDigitallyMsg, backgroundColor: Colors.black,
              textColor: Colors.white,);
          });
        }else{
          empathize.prDigitalPersona.hide().whenComplete((){
            Fluttertoast.showToast(msg: empathize.responseArrayCreatePersonaDigitallyMsg, backgroundColor: Colors.black,
              textColor: Colors.white,);
          });
        }
      }
    });
  }

  Future<String> uploadPaperPersona(context) async {

    String url = globals.urlSignUp + "createpersonaonpaper.php";

    empathize.baseImagePaperPersona = base64Encode(empathize.imagePaperPersona.readAsBytesSync());

    empathize.fileNamePaperPersona = empathize.imagePaperPersona.path.split("/").last;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('test_image', empathize.imagePaperPersona.path);

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
      "emapathizeid" : "null",
      "image" : empathize.baseImagePaperPersona.toString(),
      "name" : empathize.fileNamePaperPersona.toString(),
      "callerID" : profile.userID.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayUploadPaperPersona = jsonDecode(response.body);
      print(empathize.responseArrayUploadPaperPersona);

      empathize.responseArrayUploadPaperPersonaMsg = empathize.responseArrayUploadPaperPersona['message'].toString();
      print(empathize.responseArrayUploadPaperPersonaMsg);
      if(statusCode == 200){
        if(empathize.responseArrayUploadPaperPersonaMsg == "Persona Added Successfully"){
          updateStep2(context);
          Fluttertoast.showToast(msg: empathize.personaUploaded, backgroundColor: Colors.black,
            textColor: Colors.white,gravity: ToastGravity.CENTER);
        }else{
          Fluttertoast.showToast(msg: empathize.responseArrayUploadPaperPersonaMsg, backgroundColor: Colors.black,
            textColor: Colors.white,gravity: ToastGravity.CENTER);
        }
      }
    });
  }

  Future<String> getPersonaDetails(context) async {

    String url = globals.urlSignUp + "getpersona.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayGetPersona = jsonDecode(response.body);
      print(empathize.responseArrayGetPersona);

      empathize.responseArrayGetPersonaMsg = empathize.responseArrayGetPersona['message'].toString();
      print(empathize.responseArrayGetPersonaMsg);
      if(statusCode == 200){
        if(empathize.responseArrayGetPersonaMsg == "Profile Found"){


          empathize.paperPersonaImageNamesList = List.generate(empathize.responseArrayGetPersona['data'].length, (i) => empathize.responseArrayGetPersona['data'][i]['personadocImage']);
          print("aaaaaaaaaaaaaaaaaaaa");
          if(empathize.paperPersonaImageNamesList!=null){
            for(int i=0;i<empathize.paperPersonaImageNamesList.length;i++){
              if(empathize.paperPersonaImageNamesList[i].toString() == ""){
                empathize.paperPersonaImageNamesList.removeAt(i);
                print("aaaaaaaaaaaaaaaaaaaa");
              }
            }
          }



          print(empathize.paperPersonaImageNamesList.toList());

        }else{

          empathize.paperPersonaImageNamesList = null;

        }
      }
    });
  }

  void clearFields(BuildContext context){
    empathize.nameController.clear();
    empathize.ageController.clear();
    empathize.locationController.clear();
    empathize.educationController.clear();
    empathize.jobController.clear();
    empathize.bioController.clear();
    empathize.goalsAndMotivationController.clear();
    empathize.imageOne = null;
  }

}