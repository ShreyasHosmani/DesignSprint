import 'package:flutter/material.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'dart:convert';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/warehouse_journey_map_data.dart' as journeyMapWH;

class GetWareHouseJourneyMapDataApiProvider {

  Future getJourneyMapWareHouseData(context) async {

    String url = globals.urlSignUp + "getjourneymap.php";

    http.post(url, body: {

      "userID" : "0",//profile.userID.toString(),
      "sprintID" : home.selectedSprintId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      journeyMapWH.responseArrayGetWareHouseJourneyMapData = jsonDecode(response.body);
      print(journeyMapWH.responseArrayGetWareHouseJourneyMapData.toString());

      journeyMapWH.responseArrayGetWareHouseJourneyMapDataMsg = journeyMapWH.responseArrayGetWareHouseJourneyMapData['message'].toString();
      print(journeyMapWH.responseArrayGetWareHouseJourneyMapDataMsg);

      if(journeyMapWH.responseArrayGetWareHouseJourneyMapDataMsg == "Data Found"){

        journeyMapWH.journeyMapWareHouseIdsList = List.generate(journeyMapWH.responseArrayGetWareHouseJourneyMapData['data'].length, (i) => journeyMapWH.responseArrayGetWareHouseJourneyMapData['data'][i]['jpID'].toString());
        journeyMapWH.journeyMapWareHouseUserNameList = List.generate(journeyMapWH.responseArrayGetWareHouseJourneyMapData['data'].length, (i) => journeyMapWH.responseArrayGetWareHouseJourneyMapData['data'][i]['userFullname'].toString());
        journeyMapWH.journeyMapWareHouseImagesList = List.generate(journeyMapWH.responseArrayGetWareHouseJourneyMapData['data'].length, (i) => journeyMapWH.responseArrayGetWareHouseJourneyMapData['data'][i]['jpdocImage'] == null ? "null" : journeyMapWH.responseArrayGetWareHouseJourneyMapData['data'][i]['jpdocImage'].toString());

        print(journeyMapWH.journeyMapWareHouseIdsList.toList());
        print(journeyMapWH.journeyMapWareHouseUserNameList.toList());
        print(journeyMapWH.journeyMapWareHouseImagesList.toList());

      }else{

        journeyMapWH.journeyMapWareHouseIdsList = null;

      }

    });

  }

  Future getJourneyMapWareHouseDataMapIdWise(context) async {

    String url = globals.urlSignUp + "getwarehousejourneymapdata.php";

    http.post(url, body: {

      "mapID" : journeyMapWH.selectedWareHouseMapId.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      journeyMapWH.responseArrayGetWareHouseJourneyMapDataMapIdWise = jsonDecode(response.body);
      print(journeyMapWH.responseArrayGetWareHouseJourneyMapDataMapIdWise.toString());

      journeyMapWH.responseArrayGetWareHouseJourneyMapDataMapIdWiseMsg = journeyMapWH.responseArrayGetWareHouseJourneyMapDataMapIdWise['message'].toString();
      print(journeyMapWH.responseArrayGetWareHouseJourneyMapDataMapIdWiseMsg);

      if(journeyMapWH.responseArrayGetWareHouseJourneyMapDataMapIdWiseMsg == "Data Found"){

        journeyMapWH.journeyMapWareHouseTouchPointsList = List.generate(4, (i) => journeyMapWH.responseArrayGetWareHouseJourneyMapDataMapIdWise['data'][i]['tpText'].toString());
        journeyMapWH.journeyMapWareHouseCustomerThoughtsList = List.generate(4, (i) => journeyMapWH.responseArrayGetWareHouseJourneyMapDataMapIdWise['data'][i]['ctText'].toString());
        journeyMapWH.journeyMapWareHouseCustomerExperiencesList = List.generate(4, (i) => journeyMapWH.responseArrayGetWareHouseJourneyMapDataMapIdWise['data'][i]['cxText'].toString());
        journeyMapWH.journeyMapWareHousePainPointsList = List.generate(4, (i) => journeyMapWH.responseArrayGetWareHouseJourneyMapDataMapIdWise['data'][i]['ppName'].toString());

        print(journeyMapWH.journeyMapWareHouseTouchPointsList.toList());
        print(journeyMapWH.journeyMapWareHouseCustomerThoughtsList.toList());
        print(journeyMapWH.journeyMapWareHouseCustomerExperiencesList.toList());
        print(journeyMapWH.journeyMapWareHousePainPointsList.toList());

      }else{

        journeyMapWH.journeyMapWareHouseTouchPointsList = null;

      }

    });

  }

}