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

  Future getDecisionMakerEmail(teamName) async {
    try {
      Map body = {"teamName": teamName};

      final response = await http
          .post(Uri.parse(urlLogin + "getsprintbyrights.php"), body: body);

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
