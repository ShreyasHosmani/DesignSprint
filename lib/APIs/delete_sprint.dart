import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/home_screen_data.dart' as home;

class DeleteSprintApiProvider{

  Future<String> deleteSprint(context) async {

    String url = globals.urlSignUp + "deletesprint.php";

    http.post(url, body: {

      "sprintID" : home.sprintID.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayDeleteSprint = jsonDecode(response.body);
      print(responseArrayDeleteSprint);

      var responseArrayDeleteSprintMsg = responseArrayDeleteSprint['message'].toString();
      if(statusCode == 200){
        if(responseArrayDeleteSprintMsg == "Sprint deleted"){
          Fluttertoast.showToast(msg: "Sprint discarded", backgroundColor: Colors.black,
            textColor: Colors.white,).whenComplete((){
            Navigator.of(context).popUntil((route) => route.isFirst);
          });
        }else{
          Fluttertoast.showToast(msg: "Please check your internet connection", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

  Future<String> deleteSprintFromSprints(context) async {

    String url = globals.urlSignUp + "deletesprint.php";

    http.post(url, body: {

      "sprintID" : home.selectedSprintIdForDeleting.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayDeleteSprint = jsonDecode(response.body);
      print(responseArrayDeleteSprint);

      var responseArrayDeleteSprintMsg = responseArrayDeleteSprint['message'].toString();
      if(statusCode == 200){
        if(responseArrayDeleteSprintMsg == "Sprint deleted"){
          Fluttertoast.showToast(msg: "Sprint discarded", backgroundColor: Colors.black,
            textColor: Colors.white,).whenComplete((){
          });
        }else{
          Fluttertoast.showToast(msg: "Please check your internet connection", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

}