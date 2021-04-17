import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/prototyping_data.dart' as prototype;
import 'package:design_sprint/utils/ideation_data.dart' as ideation;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrototypeApiProvider{

  Future<String> updateStep9(context) async {

    String url = globals.urlSignUp + "updatesprintstatus.php";

    http.post(url, body: {

      "userID" : profile.email,
      "sprintID" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
      "stepID" : "9",

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

  Future<String> uploadPrototypeImage(context) async {

    String url = globals.urlSignUp + "uploadprototypeimage.php";

    prototype.base64PrototypeImage = base64Encode(prototype.imageOne.readAsBytesSync());

    prototype.fileNamePrototypeImage = prototype.imageOne.path.split("/").last;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('test_image', prototype.imageOne.path);

    http.post(url, body: {

      "painpointid" : prototype.selectedPainPointIdForUploadingPrototypeImage.toString(),
      "image" : prototype.base64PrototypeImage,
      "name": prototype.fileNamePrototypeImage,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      prototype.responseArrayUploadPrototypeImage = jsonDecode(response.body);
      print(prototype.responseArrayUploadPrototypeImage.toString());

      prototype.responseArrayUploadPrototypeImageMsg = prototype.responseArrayUploadPrototypeImage['message'].toString();
      if(prototype.responseArrayUploadPrototypeImageMsg == "Prototype Image Added Successfully"){
        Fluttertoast.showToast(msg: "Image uploaded", backgroundColor: Colors.black,
          textColor: Colors.white,);
        updateStep9(context);
      }else{
        Fluttertoast.showToast(msg: "Please check your internet connection", backgroundColor: Colors.black,
          textColor: Colors.white,);
      }

    });
  }

  Future<String> getPrototypeImagesPainPointWise(context) async {

    String url = globals.urlSignUp + "getprototypeimagespainpointwise.php";

    http.post(url, body: {

      "sprintID" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      prototype.responseArrayGetPrototypeImagesPainPointWise = jsonDecode(response.body);
      print(prototype.responseArrayGetPrototypeImagesPainPointWise);

      prototype.responseArrayGetPrototypeImagesPainPointWiseMsg = prototype.responseArrayGetPrototypeImagesPainPointWise['message'].toString();
      print(prototype.responseArrayGetPrototypeImagesPainPointWiseMsg);

      if(prototype.responseArrayGetPrototypeImagesPainPointWiseMsg == "Painpoint Data Found"){

        prototype.prototypeImagesPPWiseList = List.generate(prototype.responseArrayGetPrototypeImagesPainPointWise['data'].length, (i) => prototype.responseArrayGetPrototypeImagesPainPointWise['data'][i]['ptiImgpath'].toString());

        print(prototype.prototypeImagesPPWiseList.toList());

      }else{

        prototype.prototypeImagesPPWiseList = null;

      }

    });
  }

}