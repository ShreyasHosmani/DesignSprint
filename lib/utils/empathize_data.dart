library main_app.empathizeglobals;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
ProgressDialog prDigitalPersona;

String empathize = "Empathize";
String createPersonas = "Create Personas";
String journeyMapping = "Journey Mapping";
String identifyPainPoints = "Identify Painpoints";
String timeline = "Timeline";

String digitally = "Digitally";
String createPersonasOnPaper = "on paper";

String digitalPersona = "Digital persona";

String personaSaved = "Persona saved";

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
