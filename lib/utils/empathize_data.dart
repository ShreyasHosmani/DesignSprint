library main_app.empathizeglobals;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

String gallery = "Gallery";
String fileManager = "File Manager";

//Create Persona Data
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
ProgressDialog prDigitalPersona;

String empathize = "Empathize";
String personas = "Personas";
String createPersonas = "Create Personas";
String journeyMapping = "Journey Mapping";
String identifyPainPoints = "Identify Painpoints";
String timeline = "Timeline";
String paperPersona = "Paper Persona";
String paperPersonaHint1 = "1. Upload the paper personas";
String paperPersonaHint2 = "2. Mention the identified painpoints";

String digitally = "Digitally";
String createPersonasOnPaper = "on paper";
String digitalPersona = "Digital persona";
String personaSaved = "Persona saved";
String addPhoto = "Add Photo";

File imageOne;
File imagePaperPersona;
var baseImage;
var fileName;
var baseImagePaperPersona;
var fileNamePaperPersona;
var responseArrayUploadPaperPersona;
var responseArrayUploadPaperPersonaMsg;
String personaUploaded = "Image uploaded";
String upload = "Upload";

bool statusDrawer = false;

var nameController = new TextEditingController();
var ageController = new TextEditingController();
var locationController = new TextEditingController();
var educationController = new TextEditingController();
var jobController = new TextEditingController();
var bioController = new TextEditingController();
var goalsAndMotivationController = new TextEditingController();
var fearsAndFrustrationController = new TextEditingController();

String saveButton = "Save";
String newPersonaButton = "New Persona";

final formKey = GlobalKey<FormState>();
final formKey2 = GlobalKey<FormState>();
final formKey3 = GlobalKey<FormState>();

var responseArrayCreatePersonaDigitally;
var responseArrayCreatePersonaDigitallyMsg;

String downloadTemplate1 = "Download";
String downloadTemplate2 = "Template";
String uploadPersonas1 = "Upload";
String uploadPersonas2 = "Personas";
String saveAsPdf = "Save as PDF";
String sendEmail = "Send Email";

var paperPersonaImageNamesList;
var responseArrayGetPersona;
var responseArrayGetPersonaMsg;

var responseArrayGetPersonaPast;
var responseArrayGetPersonaPastMsg;
var personaNameList;
var personaAgeList;
var personaLocationList;
var personaEducationList;
var personaJobList;
var personaBioList;
var personaGoalsList;
var personaImagesList;







//Journey Mapping Sections Data
String journeyMapHint1 = "Create Journey";
String journeyMapHint2 = "Map Digitally";

String journeyMapPaperHint ="Map on paper";
String paperJourneyMapHint1 = "1. Upload the paper journey maps";

var responseArrayJourneyMapName;
var responseArrayJourneyMapNameMsg;

var journeyNameController = new TextEditingController();

String journeyMapFieldHint = "Journey map name";
String journeyMapFieldValidation = "Journey map is compulsary!";

String popUpHint = "Name the journey Map.";
String paperJourneyMap = "Paper Journey Map";
String journeyMaps = "Journey Maps";

ProgressDialog prJourneyMapName;

String journeyMapSaved = "Journey map saved";

var journeyMapId;

var responseArrayInputPainPoints;
var responseArrayInputPainPointsMsg;

String touchPoints = "Touch Points";
String customerThoughts = "Customer Thoughts";
String customerExperience = "Customer Experience";
String painPoints = "Pain Points";

var touchPointController = new TextEditingController();

File imagePaperJourneyMap;
var baseImagePaperJourneyMap;
var fileNamePaperJourneyMap;
var responseArrayUploadPaperJourneyMap;
var responseArrayUploadPaperJourneyMapMsg;

var responseArrayGetJourneyMap;
var responseArrayGetJourneyMapMsg;
var journeyMapImageNamesList;






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


var tempPainPointsList;
var tempPainPointIdsList;
TextEditingController painPointController = new TextEditingController();
ProgressDialog prInputPainPoint;


//Journey Map Horizontal List Data
var responseArrayUploadTouchPoints;
var responseArrayUploadTouchPointsMsg;

var responseArrayUploadCustomerThoughts;
var responseArrayUploadCustomerThoughtsMsg;

var responseArrayUploadCustomerExperiences;
var responseArrayUploadCustomerExperiencesMsg;

var responseArrayUploadPainPointFromDigitLJourneyMap;
var responseArrayUploadPainPointFromDigitLJourneyMapMsg;

var selectedTouchPointController;
var selectedCustomerThoughtController;
var selectedCustomerExperienceController;
var selectedPainPointController;

var responseArrayDeleteJourneyMap;
var responseArrayDeleteJourneyMapMsg;

var receivedTouchPointIdSingle;
var receivedCustomerThoughtIdSingle;
var receivedCustomerExperienceIdSingle;
var receivedPainPointIdSingle;

var selectedTouchPointId;


