import 'package:design_sprint/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'dart:convert';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/main_data.dart' as mainData;

class LogoutApiProvider{

  Future<String> Logout(context) async {

    String url = globals.urlLogin + "updatefcmtoken.php";

    http.post(url, body: {

      "userID" : profile.userID.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      mainData.responseArrayDeleteFcmToken = jsonDecode(response.body);
      print(mainData.responseArrayDeleteFcmToken);

      mainData.responseArrayDeleteFcmTokenMsg = mainData.responseArrayDeleteFcmToken['message'].toString();
      print(mainData.responseArrayDeleteFcmTokenMsg);

      if(statusCode == 200){
        if(mainData.responseArrayDeleteFcmTokenMsg == "FCM updated Successfully"){

        }else{

        }
      }

    });
  }

}