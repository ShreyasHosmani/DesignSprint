import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/signup_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/ideation_data.dart' as ideation;
import 'package:design_sprint/utils/home_screen_data.dart' as home;

class VotePainPointsApiProvider {

  Future<String> updateStep5(context) async {

    String url = globals.urlSignUp + "updatesprintstatus.php";

    http.post(url, body: {

      "userID" : profile.email,
      "sprintID" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
      "stepID" : "5",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayUpdateStatus = jsonDecode(response.body);
      print(responseArrayUpdateStatus);

      var responseArrayUpdateStatusMsg = responseArrayUpdateStatus['message'].toString();
      print(responseArrayUpdateStatusMsg);
      if(statusCode == 200){
        if(responseArrayUpdateStatusMsg == "Timeline updated Successfully"){
          print("Status updated!!");
        }else{

        }
      }
    });
  }

  Future<String> updateStep8(context) async {

    String url = globals.urlSignUp + "updatesprintstatus.php";

    http.post(url, body: {

      "userID" : profile.email,
      "sprintID" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
      "stepID" : "8",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayUpdateStatus = jsonDecode(response.body);
      print(responseArrayUpdateStatus);

      var responseArrayUpdateStatusMsg = responseArrayUpdateStatus['message'].toString();
      print(responseArrayUpdateStatusMsg);
      if(statusCode == 200){
        if(responseArrayUpdateStatusMsg == "Timeline updated Successfully"){
          print("Status updated!!");
        }else{

        }
      }
    });
  }

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
        /*if(empathize.responseArrayVitePainPointsMsg == "Vote Saved Successfully"){
          Fluttertoast.showToast(msg: empathize.voteSaved, backgroundColor: Colors.black,
            textColor: Colors.white,gravity: ToastGravity.CENTER);
        }else{
          Fluttertoast.showToast(msg: empathize.responseArrayVitePainPointsMsg, backgroundColor: Colors.black,
            textColor: Colors.white,gravity: ToastGravity.CENTER);
        }*/
        return "success";
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
        /*if(empathize.responseArrayVitePainPointsMsg == "priority updated Successfully"){
          Fluttertoast.showToast(msg: empathize.painPointSelected, backgroundColor: Colors.black,
            textColor: Colors.white,gravity: ToastGravity.CENTER);
          updateStep5(context);
        }else{
          Fluttertoast.showToast(msg: empathize.responseArrayVitePainPointsMsg, backgroundColor: Colors.black,
            textColor: Colors.white,gravity: ToastGravity.CENTER);
        }*/
      }
    });
  }

  Future<String> voteIdeas(context) async {

    print(ideation.selectedPainPointIdForVoteOfIvsF.toString());
    print(ideation.impactRange.toString());
    print(ideation.feasibilityRange.toString());
    print(profile.userID.toString());

    String url = globals.urlSignUp + "addideavotes.php";

    http.post(url, body: {

      "imageId": ideation.selectedPainPointIdForVoteOfIvsF.toString(),
      "userID" : profile.userID.toString(),
      "imapctVote": ideation.impactRange.toString(),
      "feasibilityVote" : ideation.feasibilityRange.toString(),

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
        /* if(ideation.responseArrayVoteImpactFeasibilityMsg == "Vote Saved Successfully"){
          Fluttertoast.showToast(msg: empathize.voteSaved, backgroundColor: Colors.black,
            textColor: Colors.white,gravity: ToastGravity.CENTER).then((value){
          });
        }else{
          Fluttertoast.showToast(msg: ideation.responseArrayVoteImpactFeasibilityMsg, backgroundColor: Colors.black,
            textColor: Colors.white,gravity: ToastGravity.CENTER);
        }*/
      }
    });
  }

  Future<String> voteIdeasForStore(context) async {

    print("++++++++");
    print(ideation.selectedPainPointIdForVoteOfIvsF.toString());
    print(ideation.impactRange.toString());
    print(ideation.feasibilityRange.toString());
    print(profile.userID.toString());
    print("++++++++");

    String url = globals.urlSignUp + "storeIvsFIdeaVotes.php";

    http.post(url, body: {

      "ivSprintId" : home.sprintID == null || home.sprintID == "null" ? home.selectedSprintId : home.sprintID,
      "ivImageID": ideation.selectedPainPointIdForVoteOfIvsF.toString(),
      "ivUserId" : profile.userID.toString(),
      "ivImpactVote": ideation.impactRange.toString(),
      "ivFeasibilityVote" : ideation.feasibilityRange.toString(),

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
        /* if(ideation.responseArrayVoteImpactFeasibilityMsg == "Vote Saved Successfully"){
          Fluttertoast.showToast(msg: empathize.voteSaved, backgroundColor: Colors.black,
            textColor: Colors.white,gravity: ToastGravity.CENTER).then((value){
          });
        }else{
          Fluttertoast.showToast(msg: ideation.responseArrayVoteImpactFeasibilityMsg, backgroundColor: Colors.black,
            textColor: Colors.white,gravity: ToastGravity.CENTER);
        }*/
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
       /* if(ideation.responseArrayVoteImpactFeasibilityMsg == "Vote Saved Successfully"){
          Fluttertoast.showToast(msg: empathize.voteSaved, backgroundColor: Colors.black,
            textColor: Colors.white,gravity: ToastGravity.CENTER).then((value){
          });
        }else{
          Fluttertoast.showToast(msg: ideation.responseArrayVoteImpactFeasibilityMsg, backgroundColor: Colors.black,
            textColor: Colors.white,gravity: ToastGravity.CENTER);
        }*/
      }
    });
  }

  Future<String> selectIdeaImagesForPrototyping(context) async {

    print(empathize.selectedFinalPainPointId);
    print(empathize.painPointStatus);

    String url = globals.urlSignUp + "updateIdeaImageStatus.php";

    http.post(url, body: {

      "imageID": ideation.selectedPainPointIdForPrototyping.toString(),
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
            /*  Fluttertoast.showToast(msg: empathize.painPointSelected, backgroundColor: Colors.black,
              textColor: Colors.white,gravity: ToastGravity.CENTER);*/
            updateStep8(context);
          }else{

          }
        }else{
          Fluttertoast.showToast(msg: ideation.responseArrayUpdateImpactPriorityMsg, backgroundColor: Colors.black,
              textColor: Colors.white,gravity: ToastGravity.CENTER);
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
          /*  Fluttertoast.showToast(msg: empathize.painPointSelected, backgroundColor: Colors.black,
              textColor: Colors.white,gravity: ToastGravity.CENTER);*/
            updateStep8(context);
          }else{

          }
        }else{
          Fluttertoast.showToast(msg: ideation.responseArrayUpdateImpactPriorityMsg, backgroundColor: Colors.black,
            textColor: Colors.white,gravity: ToastGravity.CENTER);
        }
      }
    });
  }

}