import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/manage_team_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/manage_team_screen_seperate.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'dart:convert';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/team_data.dart' as team;

class TeamApiProvider {

  Future<String> createTeamName2(context) async {

    String url = globals.urlLogin + "createteambyuserid.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "teamname" : team.teamNameController.text,
      "useremail" : profile.email.toString(),
      "fullname": profile.name.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      team.responseArrayTeamName = jsonDecode(response.body);
      print(team.responseArrayTeamName);

      team.responseArrayTeamNameMsg = team.responseArrayTeamName['message'].toString();
      if(statusCode == 200){
        if(team.responseArrayTeamNameMsg == "Team Added Successfully"){
          team.prTeam.hide();
          team.teamID = team.responseArrayTeamName['data'];
          print(team.teamID.toString());
          Fluttertoast.showToast(msg: team.teamSaved, backgroundColor: Colors.black,
            textColor: Colors.white,).whenComplete((){
            Navigator.of(context).pop();
//            Navigator.push(
//              context,
//              PageRouteBuilder(
//                pageBuilder: (c, a1, a2) => ManageTeamSeperate(),
//                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
//                transitionDuration: Duration(milliseconds: 300),
//              ),
//            );
          });
        }else{
          team.prTeam.hide();
          Fluttertoast.showToast(msg: team.responseArrayTeamNameMsg, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }

    });
  }

  Future<String> addTeamMember(context) async {

    String url = globals.urlLogin + "addteammember.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID" : "0",//home.sprintID,
      "teamid" : team.teamID,
      "membername" : team.memberNameController.text,
      "memberemail" : team.memberEmailController.text,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      team.responseArrayAddTeam = jsonDecode(response.body);
      print(team.responseArrayAddTeam);

      team.responseArrayAddTeamMsg = team.responseArrayAddTeam['message'].toString();
      if(statusCode == 200){
        if(team.responseArrayAddTeamMsg == "Team Added Successfully"){
          team.prTeam.hide();
          Fluttertoast.showToast(msg: team.memberAdded, backgroundColor: Colors.black,
            textColor: Colors.white,).whenComplete((){
              team.memberEmailController.clear();
              team.memberNameController.clear();
              getTeamMembers(context);
            Navigator.of(context).pop();
          });
        }else{
          team.prTeam.hide();
          Fluttertoast.showToast(msg: team.responseArrayAddTeamMsg, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }

    });
  }

  Future<String> getTeamMembers(context) async {

    String url = globals.urlLogin + "getteamstatus.php";

    http.post(url, body: {

      "userID" : profile.userID,
      //"sprintID" : home.sprintID,
      "teamID" : team.teamID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      team.responseArrayTeamDetails = jsonDecode(response.body);
      print(team.responseArrayTeamDetails);

      team.responseArrayTeamDetailsMsg = team.responseArrayTeamDetails['message'].toString();
      if(statusCode == 200){
        if(team.responseArrayTeamDetailsMsg == "Profile Found"){
          team.teamMemberIdsList = List.generate(team.responseArrayTeamDetails['data'].length, (i) => team.responseArrayTeamDetails['data'][i]['teamID'].toString());
          team.teamMemberNameList = List.generate(team.responseArrayTeamDetails['data'].length, (i) => team.responseArrayTeamDetails['data'][i]['teamMemberName'].toString());
          team.teamMemberEmailList = List.generate(team.responseArrayTeamDetails['data'].length, (i) => team.responseArrayTeamDetails['data'][i]['teamMemberEmail'].toString());
          print(team.teamMemberIdsList.toList());
          print(team.teamMemberNameList.toList());
          print(team.teamMemberEmailList.toList());
        }else{
          team.teamMemberIdsList = null;
          team.teamMemberNameList = null;
          team.teamMemberEmailList = null;
        }
      }

    });
  }

  Future<String> getTeamNames(context) async {

    String url = globals.urlLogin + "getteamname.php";

    http.post(url, body: {

      "userID" : profile.userID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      team.responseArrayTeamNames = jsonDecode(response.body);
      print(team.responseArrayTeamNames);

      team.responseArrayTeamNamesMsg = team.responseArrayTeamNames['message'].toString();
      if(statusCode == 200){
        if(team.responseArrayTeamNamesMsg == "Profile Found"){

          team.teamNamesList = List.generate(team.responseArrayTeamNames['data'].length, (i) => team.responseArrayTeamNames['data'][i]['tnName'].toString());
          team.teamNamesIdsList = List.generate(team.responseArrayTeamNames['data'].length, (i) => team.responseArrayTeamNames['data'][i]['tnID'].toString());

          print(team.teamNamesList.toList());
          print(team.teamNamesIdsList.toList());

        }else{

          team.teamNamesList = null;
          team.teamNamesIdsList = null;

        }
      }

    });
  }

  Future<String> addTeamMemberBySprint(context) async {

    String url = globals.urlLogin + "addteammember.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID" : home.sprintID,
      "teamid" : team.teamID,
      "membername" : team.memberNameController.text,
      "memberemail" : team.memberEmailController.text,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      team.responseArrayAddTeam = jsonDecode(response.body);
      print(team.responseArrayAddTeam);

      team.responseArrayAddTeamMsg = team.responseArrayAddTeam['message'].toString();
      if(statusCode == 200){
        if(team.responseArrayAddTeamMsg == "Team Added Successfully"){
          team.prTeam.hide();
          Fluttertoast.showToast(msg: team.memberAdded, backgroundColor: Colors.black,
            textColor: Colors.white,).whenComplete((){
            team.memberEmailController.clear();
            team.memberNameController.clear();
            getTeamMembers(context);
            Navigator.of(context).pop();
          });
        }else{
          team.prTeam.hide();
          Fluttertoast.showToast(msg: team.responseArrayAddTeamMsg, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }

    });
  }

  Future<String> getTeamMembersBySprint(context) async {

    String url = globals.urlLogin + "getteamstatus.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID" : home.sprintID,
      "teamID" : team.teamID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      team.responseArrayTeamDetails = jsonDecode(response.body);
      print(team.responseArrayTeamDetails);

      team.responseArrayTeamDetailsMsg = team.responseArrayTeamDetails['message'].toString();
      if(statusCode == 200){
        if(team.responseArrayTeamDetailsMsg == "Profile Found"){
          team.teamMemberNameList = List.generate(team.responseArrayTeamDetails['data'].length, (i) => team.responseArrayTeamDetails['data'][i]['teamMemberName'].toString());
          team.teamMemberEmailList = List.generate(team.responseArrayTeamDetails['data'].length, (i) => team.responseArrayTeamDetails['data'][i]['teamMemberEmail'].toString());
          print(team.teamMemberNameList.toList());
          print(team.teamMemberEmailList.toList());
        }else{
          team.teamMemberNameList = null;
          team.teamMemberEmailList = null;
        }
      }

    });
  }

  Future<String> getTeamNamesBySprint(context) async {

    String url = globals.urlLogin + "getteamname.php";

    http.post(url, body: {

      "userID" : profile.userID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      team.responseArrayTeamNames = jsonDecode(response.body);
      print(team.responseArrayTeamNames);

      team.responseArrayTeamNamesMsg = team.responseArrayTeamNames['message'].toString();
      if(statusCode == 200){
        if(team.responseArrayTeamNamesMsg == "Profile Found"){

          team.teamNamesList = List.generate(team.responseArrayTeamNames['data'].length, (i) => team.responseArrayTeamNames['data'][i]['tnName'].toString());
          team.teamNamesIdsList = List.generate(team.responseArrayTeamNames['data'].length, (i) => team.responseArrayTeamNames['data'][i]['tnID'].toString());

          print(team.teamNamesList.toList());
          print(team.teamNamesIdsList.toList());

        }else{

          team.teamNamesList = null;
          team.teamNamesIdsList = null;

        }
      }

    });
  }

}