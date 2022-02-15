library main_app.ideationglobals;
import 'dart:io';
import 'package:flutter/material.dart';

bool showImagesIdea = false;
bool showImagesPrototype = false;

String title = "Ideation";
String agenda = "Agenda";

String card1 = "Crazy 8";
String card2text1 = "I vs F";
String card2text2 = "Analysis";

String startTimerHint = "Press start when you are ready";
String start = "Start";

String ideaHint1 = "8 ideas in 8 mins, your time\nstarts now!";

int timer = 480;

String timeUp = "Time Up";

var responseArrayGetPainPointsOfStatusTwo;
var responseArrayGetPainPointsOfStatusTwoMsg;
var responseArrayGetPainPointsOfStatusTwo2;
var responseArrayGetPainPointsOfStatusTwoMsg2;

var painPointsOfStatus2List;
var painPointsIdsOfStatus2List;
var painPointsOfStatus2List2;
var painPointsIdsOfStatus2List2;
var pageIndex;
var pageIndexIdea;

var selectedPainPointIdForUploadIdeaImage;

String uploadIdeaHint1 = "Upload the picture of all the\nideas you created.";

String gallery = "Gallery";
String fileManager = "File Manager";

String base64ideaImage;
String ideaImageName;

File imageOne;

String ivsfanalysis = "Impact vs Feasibility Analysis";
String ivsfHint1 = "Vote of each idea based on its\nImportance.";
String ivsfHint2 = "Impact";
String ivsfHint3 = "Feasibility";

var selectedImpactCount;
var selectedFeasibilityCount;
var pageIndexImpactAndFeasibility;

var pageIndexIvsF;
var impactRange;
var feasibilityRange;

var selectedPainPointIdForVoteOfIvsF;

var responseArrayVoteImpactFeasibility;
var responseArrayVoteImpactFeasibilityMsg;

String select3to5FinalIdeas = "Select the final 3-5 ideas which are to be\ntaken forward for prototyping.";

var responseArrayGetIvsFByPriority;
var responseArrayGetIvsFByPriorityMsg;

var painPointsByIvsFPriorityList;
var painPointIdsByIvsFPriorityList;

var selectedPainPointIdForPrototyping;
var selectedPainPointForPrototypingStatus;

var responseArrayUpdateImpactPriority;
var responseArrayUpdateImpactPriorityMsg;

var responseArrayUploadIdeaImage;
var responseArrayUploadIdeaImageMsg;
var responseArrayGetIdeaImages;
var responseArrayGetIdeaImagesMsg;
var ideaImagesPainPointWiseList;
var responseArrayGetAllIdeaImages;
var responseArrayGetAllIdeaImagesMsg;
var ideaAllImagesPainPointWiseList;
var ideaAllImagesPainPointWiseListIds;
var responseArrayGetAllIdeaImagesByStatus;
var responseArrayGetAllIdeaImagesByStatusMsg;
var ideaAllImagesOfStatusTwo;

var selectedPainPointIdForGettingIdeaImage;
