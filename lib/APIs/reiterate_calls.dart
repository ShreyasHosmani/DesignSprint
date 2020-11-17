import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/reiterate_data.dart' as reiterate;

class ReIterateApiProvider{

  Future<String> getPrototypeImagesPainPointWise(context) async {

    String url = globals.urlSignUp + "getprototypeimagespainpointwise.php";

    http.post(url, body: {

      "sprintID" : home.sprintID.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayGetAllPrototypeImages = jsonDecode(response.body);
      print(reiterate.responseArrayGetAllPrototypeImages);

      reiterate.responseArrayGetAllPrototypeImagesMsg = reiterate.responseArrayGetAllPrototypeImages['message'].toString();
      print(reiterate.responseArrayGetAllPrototypeImagesMsg);

      if(reiterate.responseArrayGetAllPrototypeImagesMsg == "Painpoint Data Found"){

        reiterate.prototypeAllImagesList = List.generate(reiterate.responseArrayGetAllPrototypeImages['data'].length, (i) => reiterate.responseArrayGetAllPrototypeImages['data'][i]['ptiImgpath'].toString());
        reiterate.prototypeAllImagesIdsList = List.generate(reiterate.responseArrayGetAllPrototypeImages['data'].length, (i) => reiterate.responseArrayGetAllPrototypeImages['data'][i]['ptiID'].toString());

        print(reiterate.prototypeAllImagesList.toList());
        print(reiterate.prototypeAllImagesIdsList.toList());

      }else{

        reiterate.prototypeAllImagesList = null;

      }

    });
  }

  Future<String> changePrototypeStatus(context) async {

    String url = globals.urlSignUp + "changeprototypestatus.php";

    http.post(url, body: {

      "prototypeID" : reiterate.selectedPrototypeIdForReiterateModule.toString(),
      "status" : reiterate.selectedPrototypeStatus.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayChangePrototypeStatus = jsonDecode(response.body);
      print(reiterate.responseArrayChangePrototypeStatus);

      reiterate.responseArrayChangePrototypeStatusMsg = reiterate.responseArrayChangePrototypeStatus['message'].toString();
      print(reiterate.responseArrayChangePrototypeStatusMsg);

      if(reiterate.responseArrayChangePrototypeStatusMsg == "Edited Successfully"){


      }else{

        Fluttertoast.showToast(msg: "please check your internet connection", backgroundColor: Colors.black,
          textColor: Colors.white,);

      }

    });
  }

  Future<String> getPrototypeOfStatusTwo(context) async {

    String url = globals.urlSignUp + "getprototypebystatus.php";

    http.post(url, body: {

      "sprintID" : home.sprintID.toString(),
      "status" : "2",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo = jsonDecode(response.body);
      print(reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo);

      reiterate.responseArrayGetAllPrototypeImagesOfStatusTwoMsg = reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo['message'].toString();
      print(reiterate.responseArrayGetAllPrototypeImagesOfStatusTwoMsg);

      if(reiterate.responseArrayGetAllPrototypeImagesOfStatusTwoMsg == "Data Found"){

        reiterate.prototypeAllImagesListOfStatusTwo = List.generate(reiterate.responseArrayGetAllPrototypeImages['data'].length, (i) => reiterate.responseArrayGetAllPrototypeImages['data'][i]['ptiImgpath'].toString());
        reiterate.prototypeAllImagesIdsListOfStatusTwo = List.generate(reiterate.responseArrayGetAllPrototypeImages['data'].length, (i) => reiterate.responseArrayGetAllPrototypeImages['data'][i]['ptiID'].toString());

        print(reiterate.prototypeAllImagesListOfStatusTwo.toList());
        print(reiterate.prototypeAllImagesIdsListOfStatusTwo.toList());

      }else{

        reiterate.prototypeAllImagesListOfStatusTwo = null;

      }

    });
  }

  Future<String> uploadPrototypeNote(context) async {

    String url = globals.urlSignUp + "createprototypenote.php";

    http.post(url, body: {

      "userID" : "null",
      "sprintID" : home.sprintID.toString(),
      "prototypeID" : reiterate.selectedPrototypeIdForUploadingNotesAndTimeLine.toString(),
      "notetext" : reiterate.notesController.text,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayUploadPrototype = jsonDecode(response.body);
      print(reiterate.responseArrayUploadPrototype);

      reiterate.responseArrayUploadPrototypeMsg = reiterate.responseArrayUploadPrototype['message'].toString();
      print(reiterate.responseArrayUploadPrototypeMsg);

      if(reiterate.responseArrayUploadPrototypeMsg == "Prototype Note Added"){

        Fluttertoast.showToast(msg: "notes saved", backgroundColor: Colors.black,
          textColor: Colors.white,);

        reiterate.noteUploaded = true;
        print(reiterate.noteUploaded);

      }else{

        Fluttertoast.showToast(msg: "please check your internet connection", backgroundColor: Colors.black,
          textColor: Colors.white,);

      }

    });
  }

  insertTaskAndTimeLine(){
      if(reiterate.pageIndexNotesAndTimeLine == 0){
        reiterate.roadMapTaskList.add(reiterate.taskLineController.text);
        print(reiterate.roadMapTaskList.toList());
      }else if(reiterate.pageIndexNotesAndTimeLine == 1){
        reiterate.roadMapTaskList1.add(reiterate.taskLineController.text);
        print(reiterate.roadMapTaskList1.toList());
      }else if(reiterate.pageIndexNotesAndTimeLine == 2){
        reiterate.roadMapTaskList2.add(reiterate.taskLineController.text);
        print(reiterate.roadMapTaskList2.toList());
      }else if(reiterate.pageIndexNotesAndTimeLine == 3){
        reiterate.roadMapTaskList3.add(reiterate.taskLineController.text);
        print(reiterate.roadMapTaskList3.toList());
      }else if(reiterate.pageIndexNotesAndTimeLine == 4){
        reiterate.roadMapTaskList4.add(reiterate.taskLineController.text);
        print(reiterate.roadMapTaskList4.toList());
      }else if(reiterate.pageIndexNotesAndTimeLine == 5){
        reiterate.roadMapTaskList5.add(reiterate.taskLineController.text);
        print(reiterate.roadMapTaskList5.toList());
      }else if(reiterate.pageIndexNotesAndTimeLine == 6){
        reiterate.roadMapTaskList6.add(reiterate.taskLineController.text);
        print(reiterate.roadMapTaskList6.toList());
      }else if(reiterate.pageIndexNotesAndTimeLine == 7){
        reiterate.roadMapTaskList7.add(reiterate.taskLineController.text);
        print(reiterate.roadMapTaskList7.toList());
      }else if(reiterate.pageIndexNotesAndTimeLine == 8){
        reiterate.roadMapTaskList8.add(reiterate.taskLineController.text);
        print(reiterate.roadMapTaskList8.toList());
      }else if(reiterate.pageIndexNotesAndTimeLine == 9){
        reiterate.roadMapTaskList9.add(reiterate.taskLineController.text);
        print(reiterate.roadMapTaskList9.toList());
      }else if(reiterate.pageIndexNotesAndTimeLine == 10){
        reiterate.roadMapTaskList10.add(reiterate.taskLineController.text);
        print(reiterate.roadMapTaskList10.toList());
      }
  }

  Future<String> uploadPrototypeTaksAndTimeLine(context) async {

    String url = globals.urlSignUp + "prototypetask.php";

    http.post(url, body: {

      "sprintID" : home.sprintID.toString(),
      "prototypeID" : reiterate.selectedPrototypeIdForUploadingNotesAndTimeLine.toString(),
      "tasktext" : reiterate.taskLineController.text,
      "userID" : reiterate.teamMemberController.text,
      "duedate" : reiterate.dueDateController.text,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayUploadTimeline = jsonDecode(response.body);
      print(reiterate.responseArrayUploadTimeline);

      reiterate.responseArrayUploadTimelineMsg = reiterate.responseArrayUploadTimeline['message'].toString();
      print(reiterate.responseArrayUploadTimelineMsg);

      if(reiterate.responseArrayUploadTimelineMsg == "Prototype Task Added"){

        Fluttertoast.showToast(msg: "task and timeline saved", backgroundColor: Colors.black,
          textColor: Colors.white,);

        reiterate.uploadedTaskList.add(reiterate.taskLineController.text);
        print(reiterate.uploadedTaskList.toList());

        reiterate.uploadedTeamMemberList.add(reiterate.teamMemberController.text);
        print(reiterate.uploadedTeamMemberList.toList());

        reiterate.uploadedDueDateList.add(reiterate.dueDateController.text);
        print(reiterate.uploadedDueDateList.toList());

        insertTaskAndTimeLine();

        reiterate.taskLineController.clear();
        reiterate.teamMemberController.clear();
        reiterate.dueDateController.clear();

      }else{

        Fluttertoast.showToast(msg: "please check your internet connection", backgroundColor: Colors.black,
          textColor: Colors.white,);

      }

    });
  }

  Future<String> getRoadMapData(context) async {

    String url = "https://jawaby.tk/api/users/" + "getroadmap.php";

    http.post(url, body: {

      "sprintID" : home.sprintID.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayGetRoadMap = jsonDecode(response.body);
      print(reiterate.responseArrayGetRoadMap.toString());

//      reiterate.responseArrayGetRoadMapMsg = reiterate.responseArrayGetRoadMap['message'].toString();
//      if(reiterate.responseArrayGetRoadMapMsg == "Data Found"){
//
//        reiterate.roadMapNotesList1 = List.generate(1, (i) => reiterate.responseArrayGetRoadMap['images'][i]['notes'][i]['ptnNotetext']);
//        reiterate.roadMapTaskList1 = List.generate(reiterate.responseArrayGetRoadMap['images'].length, (i) => reiterate.responseArrayGetRoadMap['images'][i]['tasks'][i]['pptTasktext']);
//
//        print(reiterate.roadMapNotesList1.toList());
//        print(reiterate.roadMapTaskList1.toList());
//
//      }else{
//
//
//
//      }


    });
  }

}