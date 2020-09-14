import 'package:flutter/material.dart';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;

class CreatePersonaApiProvider {

  Future<String> createDigitalPersona(context) async {

    String url = globals.urlSignUp + "createpersonadigitally.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID,
      "emapathizeid" : "null",
      "image" : "null",
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
            clearFields(context);
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

  void clearFields(BuildContext context){
    empathize.nameController.clear();
    empathize.ageController.clear();
    empathize.locationController.clear();
    empathize.educationController.clear();
    empathize.jobController.clear();
    empathize.bioController.clear();
    empathize.goalsAndMotivationController.clear();
  }

}