library main_app.prototypingglobals;
import 'dart:io';

String title = "Prototyping";
String uploadPrototypeHint1 = "Prototype all of your ideas one by one and\nupload images of your prototype below.";

var pageIndex;

var painPointsForPrototypingList;
var painPointIdsForPrototypingList;

var responseArrayGetPainPointsForPrototyping;
var responseArrayGetPainPointsForPrototypingMsg;

var responseArrayUploadPrototypeImage;
var responseArrayUploadPrototypeImageMsg;

var selectedPainPointIdForUploadingPrototypeImage;

var base64PrototypeImage;
var fileNamePrototypeImage;

File imageOne;

var responseArrayGetPrototypeImagesPainPointWise;
var responseArrayGetPrototypeImagesPainPointWiseMsg;
var prototypeImagesPPWiseList;

var responseArrayGetWareHousePrototypes;
var responseArrayGetWareHousePrototypesMsg;
