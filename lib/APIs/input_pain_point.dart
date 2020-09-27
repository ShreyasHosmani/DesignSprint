import 'package:flutter/material.dart';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;

class InputPainPointsApiProvider {

  Future<String> inputPainPoints(context) async {

    String url = globals.urlSignUp + "createpainpoint.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID,
      "mapID" : empathize.journeyMapId,
      "painpointname": "Pain Point Number Sprint Three 4",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayInputPainPoints = jsonDecode(response.body);
      print(empathize.responseArrayInputPainPoints);

      empathize.responseArrayInputPainPointsMsg = empathize.responseArrayInputPainPoints['message'].toString();
      print(empathize.responseArrayInputPainPointsMsg);
      if(statusCode == 200){
        if(empathize.responseArrayInputPainPointsMsg == "Painpoint Added Successfully"){

        }else{

        }
      }
    });
  }

}