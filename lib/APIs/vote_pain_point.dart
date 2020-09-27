import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/signup_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/ideation_data.dart' as ideation;

class VotePainPointsApiProvider {

  Future<String> votePainPoints(context) async {

    print((empathize.pageIndex+1).toString());
    print(profile.userID.toString());
    print(empathize.voteRange.toString());

    String url = globals.urlSignUp + "votepainpoint.php";

    http.post(url, body: {

      "painpointID": empathize.selectedPainPointId.toString(),
      "userID" : profile.userID.toString(),
      "voteRange": empathize.voteRange.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayVitePainPoints = jsonDecode(response.body);
      print(empathize.responseArrayVitePainPoints);

      empathize.responseArrayVitePainPointsMsg = empathize.responseArrayVitePainPoints['message'].toString();
      print(empathize.responseArrayVitePainPointsMsg);
      if(statusCode == 200){
        if(empathize.responseArrayVitePainPointsMsg == "Vote Saved Successfully"){
          Fluttertoast.showToast(msg: empathize.voteSaved, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }else{
          Fluttertoast.showToast(msg: empathize.responseArrayVitePainPointsMsg, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

  Future<String> selectFinalPainPoints(context) async {

    print(empathize.selectedFinalPainPointId);
    print(empathize.painPointStatus);

    String url = globals.urlSignUp + "updatepainpointpriority.php";

    http.post(url, body: {

      "painpointID": empathize.selectedFinalPainPointId,
      "status" : empathize.painPointStatus,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      empathize.responseArrayVitePainPoints = jsonDecode(response.body);
      print(empathize.responseArrayVitePainPoints);

      empathize.responseArrayVitePainPointsMsg = empathize.responseArrayVitePainPoints['message'].toString();
      print(empathize.responseArrayVitePainPointsMsg);
      if(statusCode == 200){
        if(empathize.responseArrayVitePainPointsMsg == "priority updated Successfully"){
          Fluttertoast.showToast(msg: empathize.painPointSelected, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }else{
          Fluttertoast.showToast(msg: empathize.responseArrayVitePainPointsMsg, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

  Future<String> votePainPointsAccToIvsF(context) async {

    print(ideation.selectedPainPointIdForVoteOfIvsF.toString());
    print(ideation.impactRange.toString());
    print(ideation.feasibilityRange.toString());
    print(profile.userID.toString());

    String url = globals.urlSignUp + "saveimpactfeasibility.php";

    http.post(url, body: {

      "painpointID": ideation.selectedPainPointIdForVoteOfIvsF.toString(),
      "userID" : profile.userID.toString(),
      "impact": ideation.impactRange.toString(),
      "feasibility" : ideation.feasibilityRange.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ideation.responseArrayVoteImpactFeasibility = jsonDecode(response.body);
      print(ideation.responseArrayVoteImpactFeasibility);

      ideation.responseArrayVoteImpactFeasibilityMsg = ideation.responseArrayVoteImpactFeasibility['message'].toString();
      print(ideation.responseArrayVoteImpactFeasibilityMsg);
      if(statusCode == 200){
        if(ideation.responseArrayVoteImpactFeasibilityMsg == "Vote Saved Successfully"){
          Fluttertoast.showToast(msg: empathize.voteSaved, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }else{
          Fluttertoast.showToast(msg: ideation.responseArrayVoteImpactFeasibilityMsg, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

  Future<String> selectFinalPainPointsForPrototyping(context) async {

    print(empathize.selectedFinalPainPointId);
    print(empathize.painPointStatus);

    String url = globals.urlSignUp + "updateimpactpriority.php";

    http.post(url, body: {

      "painpointID": ideation.selectedPainPointIdForPrototyping.toString(),
      "status" : ideation.selectedPainPointForPrototypingStatus,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      ideation.responseArrayUpdateImpactPriority = jsonDecode(response.body);
      print(ideation.responseArrayUpdateImpactPriority);

      ideation.responseArrayUpdateImpactPriorityMsg = ideation.responseArrayUpdateImpactPriority['message'].toString();
      print(ideation.responseArrayUpdateImpactPriorityMsg);
      if(statusCode == 200){
        if(ideation.responseArrayUpdateImpactPriorityMsg == "priority updated Successfully"){
          if(ideation.selectedPainPointForPrototypingStatus == "2"){
            Fluttertoast.showToast(msg: empathize.painPointSelected, backgroundColor: Colors.black,
              textColor: Colors.white,);
          }else{

          }
        }else{
          Fluttertoast.showToast(msg: ideation.responseArrayUpdateImpactPriorityMsg, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }
    });
  }

}