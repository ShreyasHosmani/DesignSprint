library main_app.teamglobals;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

String appBarTitle = "Manage Team";
String subTitle = "Create a new Team";

String buttonText =  "Create Team";
String teamEmpty = "Team name is empty!";
String teamMemberNameEmpty = "Name is empty!";
String teamMemberEmailEmpty = "Email is empty!";

var teamID;

var teamNameController = new TextEditingController();
var teamMemberNameController = new TextEditingController();
final formKey = GlobalKey<FormState>();
final formKey2 = GlobalKey<FormState>();

ProgressDialog prTeam;
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();

var responseArrayTeamName;
var responseArrayTeamNameMsg;

String teamSaved = "Team saved";
String subtitleManageTeam = "Dezy It - UI/UX";
String subTitleManageTeam2 = "Add or remove team members";

var memberNameController = new TextEditingController();
var memberEmailController = new TextEditingController();

var responseArrayAddTeam;
var responseArrayAddTeamMsg;

String memberAdded = "Member added!";

var responseArrayTeamDetails;
var responseArrayTeamDetailsMsg;

var teamMemberNameList;
var teamMemberEmailList;

String addMember = "Add member";
String nextButtonText = "Next";