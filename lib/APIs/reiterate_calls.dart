import 'dart:convert';
import 'package:design_sprint/Models/TaskListParser.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Re%20Iterate/add_notes_and_timeline.dart';
import 'package:design_sprint/utils/reiterate_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/reiterate_data.dart' as reiterate;
import 'package:design_sprint/utils/team_by_sprints_data.dart' as teamBySprints;
import 'package:shared_preferences/shared_preferences.dart';

class ReIterateApiProvider {

  Future<String> getPrototypeImagesPainPointWise(context) async {

    print((home.sprintID == null || home.sprintID == "null"
        ? home.selectedSprintId
        : home.sprintID));

    String url = globals.urlSignUp + "getprototypeimagespainpointwise.php";

    http.post(url, body: {
      "sprintID": (home.sprintID == null || home.sprintID == "null"
              ? home.selectedSprintId
              : home.sprintID)
          .toString(),
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayGetAllPrototypeImages = jsonDecode(response.body);
      print(reiterate.responseArrayGetAllPrototypeImages);

      reiterate.responseArrayGetAllPrototypeImagesMsg =
          reiterate.responseArrayGetAllPrototypeImages['message'].toString();
      print(reiterate.responseArrayGetAllPrototypeImagesMsg);

      if (reiterate.responseArrayGetAllPrototypeImagesMsg ==
          "Painpoint Data Found") {
        reiterate.prototypeAllImagesList = List.generate(
            reiterate.responseArrayGetAllPrototypeImages['data'].length,
            (i) => reiterate.responseArrayGetAllPrototypeImages['data'][i]
                    ['ptiImgpath']
                .toString());
        reiterate.prototypeAllImagesIdsList = List.generate(
            reiterate.responseArrayGetAllPrototypeImages['data'].length,
            (i) => reiterate.responseArrayGetAllPrototypeImages['data'][i]
                    ['ptiID']
                .toString());

        print(reiterate.prototypeAllImagesList.toList());
        print(reiterate.prototypeAllImagesIdsList.toList());
      } else {
        reiterate.prototypeAllImagesList = null;
      }
    });
  }

  Future<String> changePrototypeStatus(context) async {
    String url = globals.urlSignUp + "changeprototypestatus.php";

    http.post(url, body: {
      "prototypeID": reiterate.selectedPrototypeIdForReiterateModule.toString(),
      "status": reiterate.selectedPrototypeStatus.toString(),
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayChangePrototypeStatus = jsonDecode(response.body);
      print(reiterate.responseArrayChangePrototypeStatus);

      reiterate.responseArrayChangePrototypeStatusMsg =
          reiterate.responseArrayChangePrototypeStatus['message'].toString();
      print(reiterate.responseArrayChangePrototypeStatusMsg);

      if (reiterate.responseArrayChangePrototypeStatusMsg ==
          "Edited Successfully") {
      } else {
        Fluttertoast.showToast(
          msg: "please check your internet connection",
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    });
  }

  Future<String> getPrototypeOfStatusTwo(context) async {
    String url = globals.urlSignUp + "getprototypebystatus.php";

    http.post(url, body: {
      "sprintID": "1123",
      // (home.sprintID == null || home.sprintID == "null"
      //         ? home.selectedSprintId
      //         : home.sprintID)
      //     .toString(),
      "status": "2",
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo =
          jsonDecode(response.body);
      print(reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo);

      reiterate.responseArrayGetAllPrototypeImagesOfStatusTwoMsg = reiterate
          .responseArrayGetAllPrototypeImagesOfStatusTwo['message']
          .toString();
      print(reiterate.responseArrayGetAllPrototypeImagesOfStatusTwoMsg);

      if (reiterate.responseArrayGetAllPrototypeImagesOfStatusTwoMsg ==
          "Data Found") {
        reiterate.prototypeAllImagesListOfStatusTwo = List.generate(
            reiterate.responseArrayGetAllPrototypeImages['data'].length,
            (i) => reiterate.responseArrayGetAllPrototypeImages['data'][i]
                    ['ptiImgpath']
                .toString());
        reiterate.prototypeAllImagesIdsListOfStatusTwo = List.generate(
            reiterate.responseArrayGetAllPrototypeImages['data'].length,
            (i) => reiterate.responseArrayGetAllPrototypeImages['data'][i]
                    ['ptiID']
                .toString());

        print(reiterate.prototypeAllImagesListOfStatusTwo.toList());
        print(reiterate.prototypeAllImagesIdsListOfStatusTwo.toList());
      } else {
        reiterate.prototypeAllImagesListOfStatusTwo = null;
      }
    });
  }

  Future<String> uploadPrototypeNote(context) async {
    String url = globals.urlSignUp + "createprototypenote.php";

    print({
      "userID": "null",
      "sprintID": (home.sprintID == null || home.sprintID == "null"
              ? home.selectedSprintId
              : home.sprintID)
          .toString(),
      "prototypeID":
          reiterate.selectedPrototypeIdForUploadingNotesAndTimeLine.toString(),
      "notetext": reiterate.notesController.text,
    });

    http.post(url, body: {
      "userID": "null",
      "sprintID": (home.sprintID == null || home.sprintID == "null"
              ? home.selectedSprintId
              : home.sprintID)
          .toString(),
      "prototypeID":
          reiterate.selectedPrototypeIdForUploadingNotesAndTimeLine.toString(),
      "notetext": reiterate.notesController.text,
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayUploadPrototype = jsonDecode(response.body);
      print(reiterate.responseArrayUploadPrototype);

      reiterate.responseArrayUploadPrototypeMsg =
          reiterate.responseArrayUploadPrototype['message'].toString();
      print(reiterate.responseArrayUploadPrototypeMsg);

      if (reiterate.responseArrayUploadPrototypeMsg == "Prototype Note Added") {
        Fluttertoast.showToast(
          msg: "notes saved",
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

        reiterate.noteUploaded = true;
        print(reiterate.noteUploaded);
      } else {
        Fluttertoast.showToast(
          msg: "please check your internet connection",
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    });
  }

  insertTaskAndTimeLine() {
    if (reiterate.pageIndexNotesAndTimeLine == 0) {
      reiterate.roadMapTaskList.add(reiterate.taskLineController.text);
      print(reiterate.roadMapTaskList.toList());
    } else if (reiterate.pageIndexNotesAndTimeLine == 1) {
      reiterate.roadMapTaskList1.add(reiterate.taskLineController.text);
      print(reiterate.roadMapTaskList1.toList());
    } else if (reiterate.pageIndexNotesAndTimeLine == 2) {
      reiterate.roadMapTaskList2.add(reiterate.taskLineController.text);
      print(reiterate.roadMapTaskList2.toList());
    } else if (reiterate.pageIndexNotesAndTimeLine == 3) {
      reiterate.roadMapTaskList3.add(reiterate.taskLineController.text);
      print(reiterate.roadMapTaskList3.toList());
    } else if (reiterate.pageIndexNotesAndTimeLine == 4) {
      reiterate.roadMapTaskList4.add(reiterate.taskLineController.text);
      print(reiterate.roadMapTaskList4.toList());
    } else if (reiterate.pageIndexNotesAndTimeLine == 5) {
      reiterate.roadMapTaskList5.add(reiterate.taskLineController.text);
      print(reiterate.roadMapTaskList5.toList());
    } else if (reiterate.pageIndexNotesAndTimeLine == 6) {
      reiterate.roadMapTaskList6.add(reiterate.taskLineController.text);
      print(reiterate.roadMapTaskList6.toList());
    } else if (reiterate.pageIndexNotesAndTimeLine == 7) {
      reiterate.roadMapTaskList7.add(reiterate.taskLineController.text);
      print(reiterate.roadMapTaskList7.toList());
    } else if (reiterate.pageIndexNotesAndTimeLine == 8) {
      reiterate.roadMapTaskList8.add(reiterate.taskLineController.text);
      print(reiterate.roadMapTaskList8.toList());
    } else if (reiterate.pageIndexNotesAndTimeLine == 9) {
      reiterate.roadMapTaskList9.add(reiterate.taskLineController.text);
      print(reiterate.roadMapTaskList9.toList());
    } else if (reiterate.pageIndexNotesAndTimeLine == 10) {
      reiterate.roadMapTaskList10.add(reiterate.taskLineController.text);
      print(reiterate.roadMapTaskList10.toList());
    }
  }

  Future<String> uploadPrototypeTaksAndTimeLine(context) async {
    String url = globals.urlSignUp + "prototypetask.php";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print({
      "sprintID": (home.sprintID == null || home.sprintID == "null"
          ? home.selectedSprintId
          : home.sprintID)
          .toString(),
      "prototypeID":
      reiterate.selectedPrototypeIdForUploadingNotesAndTimeLine.toString(),
      "tasktext": reiterate.taskLineController.text,
      "userID": ( prefs.getString("userID")??"").toString(),
      "duedate": teamBySprints.dateForSending,
      "pptTeamName" : sprintType.toString() == "Solo" ? "null" : reiterate.teamMemberController.text.toString(),
    });

    http.post(url, body: {
      "sprintID": (home.sprintID == null || home.sprintID == "null"
              ? home.selectedSprintId
              : home.sprintID)
          .toString(),
      "prototypeID":
          reiterate.selectedPrototypeIdForUploadingNotesAndTimeLine.toString(),
      "tasktext": reiterate.taskLineController.text,
      "userID": ( prefs.getString("userID")??"").toString(),
      "duedate": teamBySprints.dateForSending,
      "pptTeamName" : sprintType.toString() == "Solo" ? "null" : reiterate.teamMemberController.text.toString(),
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayUploadTimeline = jsonDecode(response.body);
      print(reiterate.responseArrayUploadTimeline);

      reiterate.responseArrayUploadTimelineMsg =
          reiterate.responseArrayUploadTimeline['message'].toString();
      print(reiterate.responseArrayUploadTimelineMsg);

      if (reiterate.responseArrayUploadTimelineMsg == "Prototype Task Added") {
        Fluttertoast.showToast(
          msg: "task and timeline saved",
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );

        //insertTaskAndTimeLine();

        reiterate.taskLineController.clear();
        //reiterate.teamMemberController.clear();
        reiterate.dueDateController.clear();
      } else {
        Fluttertoast.showToast(
          msg: "please check your internet connection",
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    });
  }

  Future<String> getRoadMapDataNotes(context) async {
    String url = globals.urlSignUp + "getprototypenotebysprint.php";

    http.post(url, body: {
      "sprintID": (home.sprintID == null || home.sprintID == "null"
              ? home.selectedSprintId
              : home.sprintID)
          .toString(),
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayGetRoadNotesMap = jsonDecode(response.body);
      print(reiterate.responseArrayGetRoadNotesMap.toString());

      reiterate.responseArrayGetRoadMapNotesMsg =
          reiterate.responseArrayGetRoadNotesMap['message'].toString();
      if (reiterate.responseArrayGetRoadMapNotesMsg == "Data Found") {
        reiterate.allPrototypeNotes = List.generate(
            reiterate.responseArrayGetRoadNotesMap['images'].length,
            (i) => reiterate.responseArrayGetRoadNotesMap['images'][i]
                ['ptnNotetext']);
        reiterate.allPrototypeId = List.generate(
            reiterate.responseArrayGetRoadNotesMap['images'].length,
                (i) => reiterate.responseArrayGetRoadNotesMap['images'][i]
            ['ptnPrototypeid']);
        print(reiterate.allPrototypeNotes.toList());
      } else {
        reiterate.allPrototypeNotes = null;
        reiterate.allPrototypeId = null;

      }
    });
  }

  Future<String> getRoadMapDataTasksAndTimeLines(context) async {
    String url = globals.urlSignUp + "getprototypetaskbysprint.php";

    http.post(url, body: {
      "sprintID": (home.sprintID == null || home.sprintID == "null"
              ? home.selectedSprintId
              : home.sprintID)
          .toString(),
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayGetRoadTasksMap = jsonDecode(response.body);
      print(reiterate.responseArrayGetRoadTasksMap.toString());

      reiterate.responseArrayGetRoadTasksMsg =
          reiterate.responseArrayGetRoadTasksMap['message'].toString();
      if (reiterate.responseArrayGetRoadTasksMsg == "Data Found") {
        reiterate.allPrototypeTasks = List.generate(
            reiterate.responseArrayGetRoadTasksMap['images'].length,
            (i) => reiterate.responseArrayGetRoadTasksMap['images'][i]
                ['pptTasktext']);
        reiterate.allPrototypeDueDates = List.generate(
            reiterate.responseArrayGetRoadTasksMap['images'].length,
            (i) => reiterate.responseArrayGetRoadTasksMap['images'][i]
                ['pptDuedate']);

        print(reiterate.allPrototypeTasks.toList());
        print(reiterate.allPrototypeDueDates.toList());
      } else {
        reiterate.allPrototypeTasks = null;
      }
    });
  }

  Future<String> getRoadMapDataNotes2(context) async {
    print(home.selectedSprintId);
    String url = globals.urlSignUp + "getprototypenotebysprint.php";

    http.post(url, body: {
      "sprintID": (home.sprintID == null || home.sprintID == "null"
              ? home.selectedSprintId
              : home.sprintID)
          .toString(),
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayGetRoadNotesMap = jsonDecode(response.body);
      print(reiterate.responseArrayGetRoadNotesMap.toString());

      reiterate.responseArrayGetRoadMapNotesMsg =
          reiterate.responseArrayGetRoadNotesMap['message'].toString();
      if (reiterate.responseArrayGetRoadMapNotesMsg == "Data Found") {
        reiterate.allPrototypeNotes = List.generate(
            reiterate.responseArrayGetRoadNotesMap['images'].length,
            (i) => reiterate.responseArrayGetRoadNotesMap['images'][i]
                ['ptnNotetext']);


        reiterate.allPrototypeId = List.generate(
            reiterate.responseArrayGetRoadNotesMap['images'].length,
                (i) => reiterate.responseArrayGetRoadNotesMap['images'][i]
            ['ptnPrototypeid']);

        print(reiterate.allPrototypeNotes.toList());
      } else {
        reiterate.allPrototypeNotes = null;
        reiterate.allPrototypeId = null;
      }
    });
  }

  Future<String> getRoadMapDataTasksAndTimeLines2(context) async {
    taskList.clear();

    print(home.selectedSprintId);
    String url = globals.urlSignUp + "getprototypetaskbysprint.php";

    http.post(url, body: {
      "sprintID": (home.sprintID == null || home.sprintID == "null"
              ? home.selectedSprintId
              : home.sprintID)
          .toString(),
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayGetRoadTasksMap = jsonDecode(response.body);
      print(reiterate.responseArrayGetRoadTasksMap.toString());

      reiterate.responseArrayGetRoadTasksMsg =
          reiterate.responseArrayGetRoadTasksMap['message'].toString();

      if (reiterate.responseArrayGetRoadTasksMsg == "Data Found") {
        var data = reiterate.responseArrayGetRoadTasksMap['images'];
        if (data != null) {
          for (Map i in data) {
            taskList.add(TaskListParser.fromJson(i));
          }
        }

        reiterate.allPrototypeTasks = List.generate(
            reiterate.responseArrayGetRoadTasksMap['images'].length,
            (i) => reiterate.responseArrayGetRoadTasksMap['images'][i]
                ['pptTasktext']);
        reiterate.allPrototypeDueDates = List.generate(
            reiterate.responseArrayGetRoadTasksMap['images'].length,
            (i) => reiterate.responseArrayGetRoadTasksMap['images'][i]
                ['pptDuedate']);

        print(reiterate.allPrototypeTasks.toList());
        print(reiterate.allPrototypeDueDates.toList());
      } else {
        reiterate.allPrototypeTasks = null;
      }
    });
  }

  Future<String> getRoadMapPrototypeOfStatusTwo(context) async {
    String url = globals.urlSignUp + "getprototypebystatus.php";

    http.post(url, body: {
      "sprintID": (home.sprintID == null || home.sprintID == "null"
              ? home.selectedSprintId
              : home.sprintID)
          .toString(),
      "status": "2",
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo2 =
          jsonDecode(response.body);
      print(reiterate.responseArrayGetAllPrototypeImagesOfStatusTwo2);

      reiterate.responseArrayGetAllPrototypeImagesOfStatusTwoMsg2 = reiterate
          .responseArrayGetAllPrototypeImagesOfStatusTwo2['message']
          .toString();
      print(reiterate.responseArrayGetAllPrototypeImagesOfStatusTwoMsg2);

      if (reiterate.responseArrayGetAllPrototypeImagesOfStatusTwoMsg2 ==
          "Data Found") {
        reiterate.prototypeAllImagesListOfStatusTwo2 = List.generate(
            reiterate
                .responseArrayGetAllPrototypeImagesOfStatusTwo2['data'].length,
            (i) => reiterate
                .responseArrayGetAllPrototypeImagesOfStatusTwo2['data'][i]
                    ['ptiImgpath']
                .toString());
        reiterate.prototypeAllImagesIdsListOfStatusTwo2 = List.generate(
            reiterate
                .responseArrayGetAllPrototypeImagesOfStatusTwo2['data'].length,
            (i) => reiterate
                .responseArrayGetAllPrototypeImagesOfStatusTwo2['data'][i]
                    ['ptiID']
                .toString());

        print(reiterate.prototypeAllImagesListOfStatusTwo2.toList());
        print(reiterate.prototypeAllImagesIdsListOfStatusTwo2.toList());
      } else {
        reiterate.prototypeAllImagesListOfStatusTwo2 = null;
      }
    });
  }
}
