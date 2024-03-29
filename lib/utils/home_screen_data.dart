library main_app.homeglobals;
import 'dart:io';

import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_sprint_goal.dart';
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
String logout = "Logout";

final formKey = GlobalKey<FormState>();
ProgressDialog prCreateSprint;

var sprintID;
var savedSprintName;

String timelineSaved = "Timeline saved";

var responseArrayUpdateTimeLine;
var responseArrayTimelineMsg;

//Sprints Warehouse Data
var responseArrayGetSprints;
var responseArrayGetSprintsMsg;

var sprintTitlesList;
var sprintIdsList;
var sprintStatusList;

var sprintTitlesList2;
var sprintIdsList2;
var sprintStatusList2;

//Sprints : Goal
var selectedSprintId;
String defineGoal = "Define your goal";
String sprintGoal = "Sprint Goal";
var responseArrayGetGoal;
var responseArrayGetGoalMsg;
var sprintGoalList;

//Profile Screen Data
final formKeyProfile = GlobalKey<FormState>();
TextEditingController profileNameController = TextEditingController();
TextEditingController profileEmailController = TextEditingController();
TextEditingController profilePasswordController = TextEditingController();
TextEditingController profileMobileNumberController = TextEditingController();
var responseArrayEditProfile;
var responseArrayEditProfileMsg;
var profileBaseImage;
var profileFileName;
File profileImage;

ProgressDialog prEditProfile;

var selectedSprintIdForDeleting;


