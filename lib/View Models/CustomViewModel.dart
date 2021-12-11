import 'dart:convert';
import 'dart:io';
import 'package:design_sprint/Models/DecisionMakerParser.dart';
import 'package:design_sprint/Models/MembersListParser.dart';
import 'package:design_sprint/Models/TeamListParser.dart';
import 'package:design_sprint/services/web_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomViewModel extends ChangeNotifier {
  List<TeamListParser> teamsList = [];
  List<MembersListParser> membersList = [];
  DecisionMakerParser decisionMakerParser;
  var adminEmail;

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

  Future addTeam(teamname, fullname) async {
    final response = await WebService().addTeam(teamname, fullname);

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

        adminEmail = responseDecoded['adminEmail'];

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

  Future addTeamMember(userID, teamid, membername, memberemail) async {
    final response = await WebService()
        .addTeamMember(userID, teamid, membername, memberemail);

    if (response != "error" && response != null) {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));

      var message = responseDecoded['message'];

      if (message == "Team Added Successfully") {
        getTeamMembersList(teamid);
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

  Future deleteTeamMember(index, teamID) async {
    final response = await WebService().deleteTeamMember(teamID);

    if (response != "error" && response != null) {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));

      print(responseDecoded);
      var message = responseDecoded['message'];

      if (message == "Member Removed Successfully") {
        this.membersList.removeAt(index);
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

  Future editTeamMember(
      index, teamID, teamMemberId, email, name, fcmtoken) async {
    final response =
        await WebService().editTeamMember(teamMemberId, email, name, fcmtoken);

    if (response != "error" && response != null) {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));

      print(responseDecoded);
      var message = responseDecoded['message'];

      if (message == "Member Updated Successfully") {
        this.membersList[index].teamMemberName = name;
        this.membersList[index].teamMemberEmail = email;
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

  Future changeDecisionMaker(teamID, teamname, useremail) async {
    final response =
        await WebService().changeDecisionMaker(teamname, useremail);

    if (response != "error" && response != null) {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));

      print(responseDecoded);
      var message = responseDecoded['message'];

      if (message == "Team Right Updated Successfully") {
        getTeamMembersList(teamID);
        getTeamList();
        notifyListeners();
      } else if (message == "This user has not created account yet") {
        notifyListeners();
        return message;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      notifyListeners();
      return "error";
    }
  }

  // Future getDecisionMaker(teamName) async {
  //   this.decisionMakerParser = null;
  //   final response = await WebService().getDecisionMaker(teamName);
  //
  //   if (response != "error" && response != null) {
  //     var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
  //
  //     print(responseDecoded);
  //     var message = responseDecoded['message'];
  //
  //     if (message == "Data Found") {
  //       this.decisionMakerParser = DecisionMakerParser.fromJson(i);
  //       notifyListeners();
  //       return "success";
  //     } else {
  //       notifyListeners();
  //       return "error";
  //     }
  //   } else {
  //     notifyListeners();
  //     return "error";
  //   }
  // }
}
