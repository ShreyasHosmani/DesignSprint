import 'dart:convert';
import 'dart:io';
import 'package:design_sprint/Models/MembersListParser.dart';
import 'package:design_sprint/Models/TeamListParser.dart';
import 'package:design_sprint/services/web_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomViewModel extends ChangeNotifier {
  List<TeamListParser> teamsList = [];
  List<MembersListParser> membersList = [];

  Future getTeamList() async {
    this.teamsList.clear();

    final response = await WebService().getTeamList();

    if (response != "error" && response != null) {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));

      var message = responseDecoded['message'];

      if (message == "Profile Found") {
        var data = responseDecoded['data'];
        if (data != null) {
          for (Map i in data) {
            this.teamsList.add(TeamListParser.fromJson(i));
          }
        }

        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      notifyListeners();
      return "error";
    }
  }

  Future getTeamMembersList(teamID) async {
    this.membersList.clear();

    final response = await WebService().getTeamMembersList(teamID);

    if (response != "error" && response != null) {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));

      var message = responseDecoded['message'];

      if (message == "Profile Found") {
        var data = responseDecoded['data'];
        if (data != null) {
          for (Map i in data) {
            this.membersList.add(MembersListParser.fromJson(i));
          }
        }

        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      notifyListeners();
      return "error";
    }
  }


  Future deleteTeam(index, teamID) async {
    final response = await WebService().deleteTeam(teamID);

    if (response != "error" && response != null) {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));

      print(responseDecoded);
      var message = responseDecoded['message'];

      if (message == "Team deleted") {
        this.teamsList.removeAt(index);
        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      notifyListeners();
      return "error";
    }
  }

  Future addTeam(teamname) async {
    final response = await WebService().addTeam(teamname);

    if (response != "error" && response != null) {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));

      var message = responseDecoded['message'];

      if (message == "Team Added Successfully") {
        getTeamList();
        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      notifyListeners();
      return "error";
    }
  }
}
