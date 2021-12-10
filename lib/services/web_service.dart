import 'dart:convert';
import 'dart:io';
import 'package:design_sprint/utils/globals.dart';
import 'package:design_sprint/utils/profile_data.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebService {
  Future getTeamList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userID = prefs.getString("userID") ?? "";

      Map body = {"userID": userID};

      final response =
          await http.post(Uri.parse(urlLogin + "getteamname.php"), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future deleteTeam(teamID) async {
    try {
      Map body = {"teamID": teamID};

      final response =
          await http.post(Uri.parse(urlLogin + "deleteteam.php"), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future addTeam(teamname) async {
    try {
      Map body = {"userID": userID, "teamname": teamname, "useremail": email};

      final response = await http
          .post(Uri.parse(urlLogin + "createteambyuserid.php"), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getTeamMembersList(teamID) async {
    try {
      Map body = {"teamID": teamID};

      print(body);
      final response = await http
          .post(Uri.parse(urlLogin + "getteamstatusbyid.php"), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future addTeamMember(userID, teamid, membername, memberemail) async {
    try {
      Map body = {
        "userID": userID,
        "teamid": teamid,
        "membername": membername,
        "memberemail": memberemail
      };
      print(body);

      final response = await http
          .post(Uri.parse(urlLogin + "addteammemberbyid.php"), body: body);
      print(response.body);
      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future deleteTeamMember(teamID) async {
    try {
      Map body = {"teamID": teamID};

      final response = await http
          .post(Uri.parse(urlLogin + "removeteammember.php"), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future editTeamMember(teamID, email, name, fcmtoken) async {
    try {
      Map body = {
        "teamID": teamID,
        "email": email,
        "name": name,
        "fcmtoken": fcmtoken
      };

      final response = await http
          .post(Uri.parse(urlLogin + "manageteammember.php"), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future changeDecisionMaker(teamname, useremail) async {
    try {
      Map body = {"teamname": teamname, "useremail": useremail};

      print(body);
      final response = await http
          .post(Uri.parse(urlLogin + "updateteamstatus.php"), body: body);
      print(response.body);
      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }
}
