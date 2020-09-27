library main_app.empathizeglobals;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';


//Create Persona Data
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
ProgressDialog prDigitalPersona;

String empathize = "Empathize";
String createPersonas = "Create Personas";
String journeyMapping = "Journey Mapping";
String identifyPainPoints = "Identify Painpoints";
String timeline = "Timeline";
String paperPersona = "Paper Persona";
String paperPersonaHint1 = "1. Upload the paper journey maps";
String paperPersonaHint2 = "2. Mention the identified painpoints";

String digitally = "Digitally";
String createPersonasOnPaper = "on paper";
String digitalPersona = "Digital persona";
String personaSaved = "Persona saved";
String addPhoto = "Add Photo";

File imageOne;
var baseImage;
var fileName;

bool statusDrawer = false;

var nameController = new TextEditingController();
var ageController = new TextEditingController();
var locationController = new TextEditingController();
var educationController = new TextEditingController();
var jobController = new TextEditingController();
var bioController = new TextEditingController();
var goalsAndMotivationController = new TextEditingController();

String saveButton = "Save";
String newPersonaButton = "New Persona";

final formKey = GlobalKey<FormState>();
final formKey2 = GlobalKey<FormState>();

var responseArrayCreatePersonaDigitally;
var responseArrayCreatePersonaDigitallyMsg;








//Journey Mapping Sections Data
String journeyMapHint1 = "Create Journey";
String journeyMapHint2 = "Map Digitally";

String journeyMapPaperHint ="Map on paper";

var responseArrayJourneyMapName;
var responseArrayJourneyMapNameMsg;

var journeyNameController = new TextEditingController();

String journeyMapFieldHint = "Journey map name";
String journeyMapFieldValidation = "Journey map is compulsary!";

String popUpHint = "Name the journey Map.";

ProgressDialog prJourneyMapName;

String journeyMapSaved = "Journey map saved";

var journeyMapId;

var responseArrayInputPainPoints;
var responseArrayInputPainPointsMsg;








//Identify Pain Points Sections Data
String voteHint1 = "Vote of each idea based on its";
String voteHint2 = "Importance";
String finalPainPointHint1 = "Select the Final Pain points which need to be resolved.";

var responseArrayGetPainPoints;
var responseArrayGetPainPointsMsg;
var responseArrayGetPainPointsAccToVotes;
var responseArrayGetPainPointsAccToVotesMsg;


var painPointsList;
var painPointIdsList;
var painPointsListAccToVotes;
var painPointIdsListAccToVotes;

var pageIndex;
var selectedIndex;
var voteRange;
int vote;
var selectedPainPointId;
var selectedFinalPainPointId;
var painPointStatus;

var responseArrayVitePainPoints;
var responseArrayVitePainPointsMsg;

String voteSaved = "Vote saved";
String painPointSelected = "selected";


