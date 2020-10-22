import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/ideation_data.dart' as ideation;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UploadIdeaApiProvider {

  Future<String> uploadIdeaImage(context) async {

    String url = globals.urlSignUp + "uploadideaimage.php";

    ideation.base64ideaImage = base64Encode(ideation.imageOne.readAsBytesSync());

    ideation.ideaImageName = ideation.imageOne.path.split("/").last;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('test_image', ideation.imageOne.path);

    http.post(url, body: {

      "painpointid" : ideation.selectedPainPointIdForUploadIdeaImage.toString(),
      "image" : ideation.base64ideaImage,
      "name": ideation.ideaImageName,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ideation.responseArrayUploadIdeaImage = jsonDecode(response.body);
      print(ideation.responseArrayUploadIdeaImage.toString());

      ideation.responseArrayUploadIdeaImageMsg = ideation.responseArrayUploadIdeaImage['message'].toString();
      if(ideation.responseArrayUploadIdeaImageMsg == "Persona Added Successfully"){
        Fluttertoast.showToast(msg: "Image uploaded", backgroundColor: Colors.black,
          textColor: Colors.white,);
      }else{
        Fluttertoast.showToast(msg: "Please check your internet connection", backgroundColor: Colors.black,
          textColor: Colors.white,);
      }

    });
  }

  Future<String> getIdeaImages(context) async {

    String url = globals.urlSignUp + "getideaimagesbypainpoint.php";

    http.post(url, body: {

      "painpointID" : ideation.selectedPainPointIdForUploadIdeaImage.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ideation.responseArrayGetIdeaImages = jsonDecode(response.body);
      print(ideation.responseArrayGetIdeaImages);

      ideation.responseArrayGetIdeaImagesMsg = ideation.responseArrayGetIdeaImages['message'].toString();
      print(ideation.responseArrayGetIdeaImagesMsg);

      if(ideation.responseArrayGetIdeaImagesMsg == "Painpoint Data Found"){

        ideation.ideaImagesPainPointWiseList = List.generate(ideation.responseArrayGetIdeaImages['data'].length, (i) => ideation.responseArrayGetIdeaImages['data'][i]['iiImgpath'].toString());

        print(ideation.ideaImagesPainPointWiseList.toList());

      }else{

        ideation.ideaImagesPainPointWiseList = null;

      }

    });
  }

  Future<String> getAllIdeaImages(context) async {

    String url = globals.urlSignUp + "getideaimagespainpointwise.php";

    http.post(url, body: {

      "sprintID" : home.sprintID.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ideation.responseArrayGetAllIdeaImages = jsonDecode(response.body);
      print(ideation.responseArrayGetAllIdeaImages);

      ideation.responseArrayGetAllIdeaImagesMsg = ideation.responseArrayGetAllIdeaImages['message'].toString();
      print(ideation.responseArrayGetAllIdeaImagesMsg);

      if(ideation.responseArrayGetAllIdeaImagesMsg == "Painpoint Data Found"){

        ideation.ideaAllImagesPainPointWiseList = List.generate(ideation.responseArrayGetAllIdeaImages['data'].length, (i) => ideation.responseArrayGetAllIdeaImages['data'][i]['iiImgpath'].toString());

        print(ideation.ideaAllImagesPainPointWiseList.toList());

      }else{

        ideation.ideaAllImagesPainPointWiseList = null;

      }

    });
  }

  Future<String> getIdeaImagesByStatus(context) async {

    String url = globals.urlSignUp + "getideaimagesbystatus.php";

    http.post(url, body: {

      "sprintID" : home.sprintID.toString(),
      "status" : "2",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ideation.responseArrayGetAllIdeaImagesByStatus = jsonDecode(response.body);
      print(ideation.responseArrayGetAllIdeaImagesByStatus);

      ideation.responseArrayGetAllIdeaImagesByStatusMsg = ideation.responseArrayGetAllIdeaImagesByStatus['message'].toString();
      print(ideation.responseArrayGetAllIdeaImagesByStatusMsg);

      if(ideation.responseArrayGetAllIdeaImagesByStatusMsg == "Painpoint Data Found"){

        ideation.ideaAllImagesOfStatusTwo = List.generate(ideation.responseArrayGetAllIdeaImagesByStatus['data'].length, (i) => ideation.responseArrayGetAllIdeaImagesByStatus['data'][i]['iiImgpath'].toString());

        print(ideation.ideaAllImagesOfStatusTwo.toList());

      }else{

        ideation.ideaAllImagesOfStatusTwo = null;

      }

    });
  }

}