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
      "mapID" : "null",
      "painpointname": empathize.painPointController.text,

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
          empathize.prInputPainPoint.hide();
          Fluttertoast.showToast(msg: "saved", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }else{
          empathize.prInputPainPoint.hide();
          Fluttertoast.showToast(msg: empathize.responseArrayInputPainPointsMsg, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

  //APIs for Horizontal Journey Map - Upload Section

  Future<String> uploadTouchPoints(context) async {

    String url = globals.urlSignUp + "createtouchpoint.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID,
      "mapID" : empathize.journeyMapId,
      "text": empathize.selectedTouchPointController,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayUploadTouchPoints = jsonDecode(response.body);
      print(empathize.responseArrayUploadTouchPoints);

      empathize.responseArrayUploadTouchPointsMsg = empathize.responseArrayUploadTouchPoints['message'].toString();
      print(empathize.responseArrayUploadTouchPointsMsg);
      if(statusCode == 200){
        if(empathize.responseArrayUploadTouchPointsMsg == "Touch Point Added Successfully"){
          empathize.receivedTouchPointIdSingle = empathize.responseArrayUploadTouchPoints['data'].toString();
          print(empathize.receivedTouchPointIdSingle);
          Fluttertoast.showToast(msg: "saved", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }else{
          Fluttertoast.showToast(msg: "please check your internet connection", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

  Future<String> uploadCustomerThoughts(context) async {

    String url = globals.urlSignUp + "createcustomerthoughts.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID,
      "mapID" : empathize.journeyMapId,
      "text": empathize.selectedCustomerThoughtController,
      "touchpointID" : empathize.selectedTouchPointId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayUploadCustomerThoughts = jsonDecode(response.body);
      print(empathize.responseArrayUploadCustomerThoughts);

      empathize.responseArrayUploadCustomerThoughtsMsg = empathize.responseArrayUploadCustomerThoughts['message'].toString();
      print(empathize.responseArrayUploadCustomerThoughtsMsg);
      if(statusCode == 200){
        if(empathize.responseArrayUploadCustomerThoughtsMsg == "Customer Thoughts Added Successfully"){
          empathize.receivedCustomerThoughtIdSingle = empathize.responseArrayUploadCustomerThoughts['data'].toString();
          print(empathize.receivedCustomerThoughtIdSingle);
          Fluttertoast.showToast(msg: "saved", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }else{
          Fluttertoast.showToast(msg: "please check your internet connection", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

  Future<String> uploadCustomerExperiences(context) async {

    String url = globals.urlSignUp + "createcustomerexperience.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID,
      "mapID" : empathize.journeyMapId,
      "text": empathize.selectedCustomerExperienceController,
      "touchpointID" : empathize.selectedTouchPointId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayUploadCustomerExperiences = jsonDecode(response.body);
      print(empathize.responseArrayUploadCustomerExperiences);

      empathize.responseArrayUploadCustomerExperiencesMsg = empathize.responseArrayUploadCustomerExperiences['message'].toString();
      print(empathize.responseArrayUploadCustomerExperiencesMsg);
      if(statusCode == 200){
        if(empathize.responseArrayUploadCustomerExperiencesMsg == "Customer Experience Added Successfully"){
          empathize.receivedCustomerExperienceIdSingle = empathize.responseArrayUploadCustomerExperiences['data'].toString();
          print(empathize.receivedCustomerExperienceIdSingle);
          Fluttertoast.showToast(msg: "saved", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }else{
          Fluttertoast.showToast(msg: "please check your internet connection", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

  Future<String> inputPainPointsFromDigitalJourneyMap(context) async {

    String url = globals.urlSignUp + "createpainpointbytouchpoint.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID,
      "mapID" : empathize.journeyMapId,
      "painpointname": empathize.selectedPainPointController,
      "touchpointID" : empathize.selectedTouchPointId,

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
          empathize.receivedPainPointIdSingle = empathize.responseArrayInputPainPoints['data'].toString();
          print(empathize.receivedPainPointIdSingle);
          Fluttertoast.showToast(msg: "saved", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }else{
          Fluttertoast.showToast(msg: "please check your internet connection", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

  //APIs for Horizontal Journey Map - Edit/Update Section

  Future<String> updateTouchPoints(context) async {

    String url = globals.urlSignUp + "edittouchpoint.php";

    http.post(url, body: {

      "touchpointID" : empathize.selectedTouchPointId,
      "text": empathize.selectedTouchPointController,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayUploadTouchPoints = jsonDecode(response.body);
      print(empathize.responseArrayUploadTouchPoints);

      empathize.responseArrayUploadTouchPointsMsg = empathize.responseArrayUploadTouchPoints['message'].toString();
      print(empathize.responseArrayUploadTouchPointsMsg);
      if(statusCode == 200){
        if(empathize.responseArrayUploadTouchPointsMsg == "Touch Point Edited Successfully"){
          Fluttertoast.showToast(msg: "saved", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }else{
          Fluttertoast.showToast(msg: "please check your internet connection", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

  Future<String> updateCustomerThoughts(context) async {

    String url = globals.urlSignUp + "editcustomerthoughts.php";

    http.post(url, body: {

      "text": empathize.selectedCustomerThoughtController,
      "customerthoughtID" : empathize.selectedTouchPointId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayUploadCustomerThoughts = jsonDecode(response.body);
      print(empathize.responseArrayUploadCustomerThoughts);

      empathize.responseArrayUploadCustomerThoughtsMsg = empathize.responseArrayUploadCustomerThoughts['message'].toString();
      print(empathize.responseArrayUploadCustomerThoughtsMsg);
      if(statusCode == 200){
        if(empathize.responseArrayUploadCustomerThoughtsMsg == "Customer Thoughts Edited Successfully"){
          Fluttertoast.showToast(msg: "saved", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }else{
          Fluttertoast.showToast(msg: "please check your internet connection", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

  Future<String> updateCustomerExperiences(context) async {

    String url = globals.urlSignUp + "editcustomerexperience.php";

    http.post(url, body: {

      "text": empathize.selectedCustomerExperienceController,
      "customerexperienceID" : empathize.selectedTouchPointId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayUploadCustomerExperiences = jsonDecode(response.body);
      print(empathize.responseArrayUploadCustomerExperiences);

      empathize.responseArrayUploadCustomerExperiencesMsg = empathize.responseArrayUploadCustomerExperiences['message'].toString();
      print(empathize.responseArrayUploadCustomerExperiencesMsg);
      if(statusCode == 200){
        if(empathize.responseArrayUploadCustomerExperiencesMsg == "Customer Experience Edited Successfully"){
          Fluttertoast.showToast(msg: "saved", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }else{
          Fluttertoast.showToast(msg: "please check your internet connection", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

  Future<String> updatePainPointsFromDigitalJourneyMap(context) async {

    String url = globals.urlSignUp + "createpainpointbytouchpoint.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID,
      "mapID" : empathize.journeyMapId,
      "painpointname": empathize.selectedPainPointController,
      "touchpointID" : empathize.selectedTouchPointId,

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
          empathize.receivedPainPointIdSingle = empathize.responseArrayInputPainPoints['data'].toString();
          print(empathize.receivedPainPointIdSingle);
          Fluttertoast.showToast(msg: "saved", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }else{
          Fluttertoast.showToast(msg: "please check your internet connection", backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

}