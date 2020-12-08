library main_app.reiterateglobals;

import 'package:flutter/material.dart';

String title = "Re - Iterate";
String form = "Form";
String selectPrototypeHint1 = "1. Select prototypes you want to take forward.";

String notesAndTimeLine = "Notes & Timeline";
String addNotes = "1. Add Notes.";
String addTimeLine = "2. Add Timeline";
String addNewTask = "Add New Task";

String roadMap = "Roadmap";

var responseArrayGetAllPrototypeImages;
var responseArrayGetAllPrototypeImagesMsg;
var prototypeAllImagesList;
var prototypeAllImagesIdsList;

var selectedPrototypeIdForReiterateModule;
var selectedPrototypeStatus;

var responseArrayChangePrototypeStatus;
var responseArrayChangePrototypeStatusMsg;

var responseArrayGetAllPrototypeImagesOfStatusTwo;
var responseArrayGetAllPrototypeImagesOfStatusTwoMsg;
var responseArrayGetAllPrototypeImagesOfStatusTwo2;
var responseArrayGetAllPrototypeImagesOfStatusTwoMsg2;

var prototypeAllImagesListOfStatusTwo;
var prototypeAllImagesIdsListOfStatusTwo;
var prototypeAllImagesListOfStatusTwo2;
var prototypeAllImagesIdsListOfStatusTwo2;

var pageIndexNotesAndTimeLine;

var selectedPrototypeIdForUploadingNotesAndImages;

var notesController = new TextEditingController();
FocusNode notesFocus = FocusNode();
var teamMemberController = new TextEditingController();
var taskLineController = new TextEditingController();
var dueDateController = new TextEditingController();

var selectedPrototypeIdForUploadingNotesAndTimeLine;

var responseArrayUploadPrototype;
var responseArrayUploadPrototypeMsg;

bool noteUploaded;

var responseArrayUploadTimeline;
var responseArrayUploadTimelineMsg;

List<String> uploadedTaskList;
List<String> uploadedTeamMemberList;
List<String> uploadedDueDateList;

var responseArrayGetRoadNotesMap;
var responseArrayGetRoadMapNotesMsg;

var responseArrayGetRoadTasksMap;
var responseArrayGetRoadTasksMsg;

var roadMapImagesList;
var roadMapNotesList;
var roadMapTaskList;
var roadMapMembersList;
var roadMapDueDateList;

var roadMapNotesList1;
var roadMapTaskList1;
var roadMapNotesList2;
var roadMapTaskList2;
var roadMapNotesList3;
var roadMapTaskList3;
var roadMapNotesList4;
var roadMapTaskList4;
var roadMapNotesList5;
var roadMapTaskList5;
var roadMapNotesList6;
var roadMapTaskList6;
var roadMapNotesList7;
var roadMapTaskList7;
var roadMapNotesList8;
var roadMapTaskList8;
var roadMapNotesList9;
var roadMapTaskList9;
var roadMapNotesList10;
var roadMapTaskList10;

var allPrototypeNotes;
var allPrototypeTasks;
var allPrototypeDueDates;
var allPrototypeNames;
