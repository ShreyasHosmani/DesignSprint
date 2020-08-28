library main_app.homeglobals;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

String hello = "Hello, ";
String home = "Home";
String designSprint = "Design Sprint";
String designSprintHint = "Start your first design sprint now";
String manageTeam = "Manage Team";
String manageTeamHint = "Manage your team work process";

String sideBarHeadingHome = "Home";
String sideBarHeadingDesignSprint = "Design Sprint";
String sideBarHeadingTips = "Tips";
String sideBarHeadingManageTeam = "Manage Team";
String sideBarHeadingFAQs = "FaQ's";
String sideBarHeadingLegalPolicy = "Legal Policy";

String title2 = "Looks like you have'nt started any sprint.";
String startNew = "Start new";

String continueOrView = "Continue/View";
String designSprints = "Design Sprints";

String popUp1 = "What would you like to name";
String popUp2 = "your sprint?";
String popUpHintTextField = "Sprint Name";
String popUpButton = "Next";

var sprintNameController = new TextEditingController();
var responseArrayCreateSprint;
var responseArrayCreateSprintMsg;

String sprintNameSaved = "Sprint name saved";
String sprintNameValidation = "Sprint Name is empty!";

final formKey = GlobalKey<FormState>();
ProgressDialog prCreateSprint;

var sprintID;

String timelineSaved = "Timeline saved";

var responseArrayUpdateTimeLine;
var responseArrayTimelineMsg;
