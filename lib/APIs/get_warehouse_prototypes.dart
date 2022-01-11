import 'package:flutter/material.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'dart:convert';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/prototyping_data.dart' as prototype;

class GetWareHousePrototypesApiProvider{

  Future<String> getAllPrototypeImages(context) async {

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

        prototype.prototypeImagesPPWiseList = "1";

      }

    });
  }

}