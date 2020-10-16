import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/ideation_data.dart' as ideation;
import 'package:design_sprint/utils/prototyping_data.dart' as prototyping;
import 'dart:convert';

class GetPainPointsApiProvider {

  Future<String> getPainPoints(context) async {

    String url = globals.urlSignUp + "getpainpoint.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID,
      "mapID" : "null",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayGetPainPoints = jsonDecode(response.body);
      print(empathize.responseArrayGetPainPoints);

      empathize.responseArrayGetPainPointsMsg = empathize.responseArrayGetPainPoints['message'].toString();
      print(empathize.responseArrayGetPainPointsMsg);
      if(statusCode == 200){
        if(empathize.responseArrayGetPainPointsMsg == "Painpoint Data Found"){
          empathize.painPointsList = List.generate(empathize.responseArrayGetPainPoints['data'].length, (index) => empathize.responseArrayGetPainPoints['data'][index]['ppName'].toString());
          empathize.painPointIdsList = List.generate(empathize.responseArrayGetPainPoints['data'].length, (index) => empathize.responseArrayGetPainPoints['data'][index]['ppID'].toString());

          print(empathize.painPointsList.toList());
          print(empathize.painPointIdsList.toList());
        }else{

          empathize.painPointsList = null;

        }
      }
    });
  }

  Future<String> getPainPointsAccordingToVotes(context) async {

    String url = globals.urlSignUp + "getsprintvote.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayGetPainPointsAccToVotes = jsonDecode(response.body);
      print(empathize.responseArrayGetPainPointsAccToVotes);

      empathize.responseArrayGetPainPointsAccToVotesMsg = empathize.responseArrayGetPainPointsAccToVotes['message'].toString();
      print(empathize.responseArrayGetPainPointsAccToVotesMsg);
      if(statusCode == 200){
        if(empathize.responseArrayGetPainPointsAccToVotesMsg == "Data Found"){
          empathize.painPointsListAccToVotes = List.generate(empathize.responseArrayGetPainPointsAccToVotes['data'].length, (index) => empathize.responseArrayGetPainPointsAccToVotes['data'][index]['ppName'].toString());
          empathize.painPointIdsListAccToVotes = List.generate(empathize.responseArrayGetPainPointsAccToVotes['data'].length, (index) => empathize.responseArrayGetPainPointsAccToVotes['data'][index]['ppID'].toString());

          print(empathize.painPointsListAccToVotes.toList());
          print(empathize.painPointIdsListAccToVotes.toList());
        }else{

        }
      }
    });
  }

  Future<String> getPainPointsOfStatusTwo(context) async {

    String url = globals.urlSignUp + "getpainpointpriority.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ideation.responseArrayGetPainPointsOfStatusTwo = jsonDecode(response.body);
      print(ideation.responseArrayGetPainPointsOfStatusTwo);

      ideation.responseArrayGetPainPointsOfStatusTwoMsg = ideation.responseArrayGetPainPointsOfStatusTwo['message'].toString();
      print(ideation.responseArrayGetPainPointsOfStatusTwoMsg);
      if(statusCode == 200){
        if(ideation.responseArrayGetPainPointsOfStatusTwoMsg == "Data Found"){
          ideation.painPointsOfStatus2List = List.generate(ideation.responseArrayGetPainPointsOfStatusTwo['data'].length, (index) => ideation.responseArrayGetPainPointsOfStatusTwo['data'][index]['ppName'].toString());
          ideation.painPointsIdsOfStatus2List = List.generate(ideation.responseArrayGetPainPointsOfStatusTwo['data'].length, (index) => ideation.responseArrayGetPainPointsOfStatusTwo['data'][index]['ppID'].toString());

          print(ideation.painPointsOfStatus2List.toList());
          print(ideation.painPointsIdsOfStatus2List.toList());
        }else{

        }
      }
    });
  }

  Future<String> getPainPointsOfStatusTwo2(context) async {

    String url = globals.urlSignUp + "getpainpointpriority.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ideation.responseArrayGetPainPointsOfStatusTwo2 = jsonDecode(response.body);
      print(ideation.responseArrayGetPainPointsOfStatusTwo2);

      ideation.responseArrayGetPainPointsOfStatusTwoMsg2 = ideation.responseArrayGetPainPointsOfStatusTwo2['message'].toString();
      print(ideation.responseArrayGetPainPointsOfStatusTwoMsg2);
      if(statusCode == 200){
        if(ideation.responseArrayGetPainPointsOfStatusTwoMsg2 == "Data Found"){
          ideation.painPointsOfStatus2List2 = List.generate(ideation.responseArrayGetPainPointsOfStatusTwo2['data'].length, (index) => ideation.responseArrayGetPainPointsOfStatusTwo2['data'][index]['ppName'].toString());
          ideation.painPointsIdsOfStatus2List2 = List.generate(ideation.responseArrayGetPainPointsOfStatusTwo2['data'].length, (index) => ideation.responseArrayGetPainPointsOfStatusTwo2['data'][index]['ppID'].toString());

          print(ideation.painPointsOfStatus2List2.toList());
          print(ideation.painPointsIdsOfStatus2List2.toList());
        }else{

        }
      }
    });
  }

  Future<String> getPainPointsByIvsFPriority(context) async {

    String url = globals.urlSignUp + "getimpactfeasibilityvote.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ideation.responseArrayGetIvsFByPriority = jsonDecode(response.body);
      print(ideation.responseArrayGetIvsFByPriority);

      ideation.responseArrayGetIvsFByPriorityMsg = ideation.responseArrayGetIvsFByPriority['message'].toString();
      print(ideation.responseArrayGetIvsFByPriorityMsg);
      if(statusCode == 200){
        if(ideation.responseArrayGetIvsFByPriorityMsg == "Data Found"){
          ideation.painPointsByIvsFPriorityList = List.generate(ideation.responseArrayGetIvsFByPriority['data'].length, (index) => ideation.responseArrayGetIvsFByPriority['data'][index]['ppName'].toString());
          ideation.painPointIdsByIvsFPriorityList = List.generate(ideation.responseArrayGetIvsFByPriority['data'].length, (index) => ideation.responseArrayGetIvsFByPriority['data'][index]['ppID'].toString());

          print(ideation.painPointsByIvsFPriorityList.toList());
          print(ideation.painPointIdsByIvsFPriorityList.toList());
        }else{

        }
      }
    });
  }

  Future<String> getPainPointsForPrototyping(context) async {

    String url = globals.urlSignUp + "getimpactpriority.php";

    http.post(url, body: {

      "userID" : profile.userID,
      "sprintID": home.sprintID,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      prototyping.responseArrayGetPainPointsForPrototyping = jsonDecode(response.body);
      print(prototyping.responseArrayGetPainPointsForPrototyping);

      prototyping.responseArrayGetPainPointsForPrototypingMsg = prototyping.responseArrayGetPainPointsForPrototyping['message'].toString();
      print(prototyping.responseArrayGetPainPointsForPrototypingMsg);
      if(statusCode == 200){
        if(prototyping.responseArrayGetPainPointsForPrototypingMsg == "Data Found"){
          prototyping.painPointsForPrototypingList = List.generate(prototyping.responseArrayGetPainPointsForPrototyping['data'].length, (index) => prototyping.responseArrayGetPainPointsForPrototyping['data'][index]['ppName'].toString());
          prototyping.painPointIdsForPrototypingList = List.generate(prototyping.responseArrayGetPainPointsForPrototyping['data'].length, (index) => prototyping.responseArrayGetPainPointsForPrototyping['data'][index]['ppID'].toString());

          print(prototyping.painPointsForPrototypingList.toList());
          print(prototyping.painPointIdsForPrototypingList.toList());
        }else{

        }
      }
    });
  }

}