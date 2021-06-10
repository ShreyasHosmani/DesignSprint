import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'dart:convert';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/team_by_sprints_data.dart' as teamBySprints;

class GetTeamBySprintApiProvider{

  Future<String> getTeamdata(context) async {

    String url = globals.urlSignUp + "getteammemberbysprint.php";

    http.post(url, body: {

      "sprintID" : home.selectedSprintId,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      teamBySprints.responseArrayGetTeamBySprints = jsonDecode(response.body);
      print(teamBySprints.responseArrayGetTeamBySprints);

      teamBySprints.responseArrayGetTeamBySprintsMsg = teamBySprints.responseArrayGetTeamBySprints['message'].toString();
      if(statusCode == 200){
        if(teamBySprints.responseArrayGetTeamBySprintsMsg == "Profile Found"){

          teamBySprints.teamMemberIdsBySprintsList = List.generate(teamBySprints.responseArrayGetTeamBySprints['data'].length, (i) => teamBySprints.responseArrayGetTeamBySprints['data'][i]['teamID'].toString());
          teamBySprints.teamMemberNamesBySprintsList = List.generate(teamBySprints.responseArrayGetTeamBySprints['data'].length, (i) => teamBySprints.responseArrayGetTeamBySprints['data'][i]['teamMemberName'].toString());
          teamBySprints.teamMemberEmailsBySprintsList = List.generate(teamBySprints.responseArrayGetTeamBySprints['data'].length, (i) => teamBySprints.responseArrayGetTeamBySprints['data'][i]['teamMemberEmail'].toString());

          print(teamBySprints.teamMemberIdsBySprintsList.toList());
          print(teamBySprints.teamMemberNamesBySprintsList.toList());
          print(teamBySprints.teamMemberEmailsBySprintsList.toList());

        }else{

          teamBySprints.teamMemberIdsBySprintsList = null;

        }
      }

    });
  }

  Future<String> getTeamdata2(context) async {

    String url = globals.urlSignUp + "getteammemberbysprint.php";

    http.post(url, body: {

      "sprintID" : home.sprintID.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      teamBySprints.responseArrayGetTeamBySprints2 = jsonDecode(response.body);
      print(teamBySprints.responseArrayGetTeamBySprints2);

      teamBySprints.responseArrayGetTeamBySprintsMsg2 = teamBySprints.responseArrayGetTeamBySprints2['message'].toString();
      if(statusCode == 200){
        if(teamBySprints.responseArrayGetTeamBySprintsMsg2 == "Profile Found"){

          teamBySprints.teamMemberIdsBySprintsList2 = List.generate(teamBySprints.responseArrayGetTeamBySprints2['data'].length, (i) => teamBySprints.responseArrayGetTeamBySprints2['data'][i]['teamID'].toString());
          teamBySprints.teamMemberNamesBySprintsList2 = List.generate(teamBySprints.responseArrayGetTeamBySprints2['data'].length, (i) => teamBySprints.responseArrayGetTeamBySprints2['data'][i]['teamID'].toString()+teamBySprints.responseArrayGetTeamBySprints2['data'][i]['teamMemberName'].toString());

          print(teamBySprints.teamMemberIdsBySprintsList2.toList());
          print(teamBySprints.teamMemberNamesBySprintsList2.toList());

        }else{

          teamBySprints.teamMemberIdsBySprintsList = null;

        }
      }

    });
  }

}