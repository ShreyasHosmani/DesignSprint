import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileApiProvider{

  Future<String> editProfile(context) async {

    String url = globals.urlSignUp + "edittouchpoint.php";

    home.profileBaseImage = base64Encode(home.profileImage.readAsBytesSync());

    home.profileFileName = home.profileImage.path.split("/").last;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profile_image', home.profileImage.path);

    http.post(url, body: {

      "userID" : profile.userID,
      "fullname" : home.profileNameController.text,
      "email": home.profileEmailController.text,
      "password" : home.profilePasswordController.text,
      "phone" : home.profileMobileNumberController.text,
      "image" : home.profileBaseImage.toString(),
      "imagename" : home.profileFileName.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      home.responseArrayEditProfile = jsonDecode(response.body);
      print(home.responseArrayEditProfile);

      home.responseArrayEditProfileMsg = home.responseArrayEditProfile['message'].toString();
      print(home.responseArrayEditProfileMsg);
      if(statusCode == 200){
        if(home.responseArrayEditProfileMsg == "Profile Edited Successfully"){
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