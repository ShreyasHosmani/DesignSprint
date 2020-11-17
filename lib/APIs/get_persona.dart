import 'package:design_sprint/utils/empathize_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;

class GetPersonaAPIProvider{

  Future<String> getPersonas(context) async {

    String url = globals.urlLogin + "getpersona.php";

    http.post(url, body: {

      "sprintID" : home.selectedSprintId,
      "userID" : profile.userID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayGetPersonaPast = jsonDecode(response.body);
      print(empathize.responseArrayGetPersonaPast);

      empathize.responseArrayGetPersonaPastMsg = empathize.responseArrayGetPersonaPast['message'].toString();
      if(statusCode == 200){
        if(empathize.responseArrayGetPersonaPastMsg == "Profile Found"){

          empathize.personaNameList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaName'].toString());
          empathize.personaAgeList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaAge'].toString());
          empathize.personaLocationList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaLocation'].toString());
          empathize.personaEducationList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaEducation'].toString());
          empathize.personaJobList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaJob'].toString());
          empathize.personaBioList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaBio'].toString());
          empathize.personaGoalsList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => empathize.responseArrayGetPersonaPast['data'][i]['personaGoals'].toString());
          empathize.personaImagesList = List.generate(empathize.responseArrayGetPersonaPast['data'].length, (i) => responseArrayGetPersonaPast['data'][i]['personaImage'] == null || responseArrayGetPersonaPast['data'][i]['personaImage'] == "null" ?  globals.urlImage+empathize.responseArrayGetPersonaPast['data'][i]['personadocImage'].toString() : globals.urlImage+empathize.responseArrayGetPersonaPast['data'][i]['personaImage'].toString());

          print(empathize.personaNameList.toList());
          print(empathize.personaAgeList.toList());
          print(empathize.personaLocationList.toList());
          print(empathize.personaEducationList.toList());
          print(empathize.personaJobList.toList());
          print(empathize.personaBioList.toList());
          print(empathize.personaGoalsList.toList());
          print(empathize.personaImagesList.toList());

        }else{

          empathize.personaNameList = null;

        }
      }
    });
  }

}