import 'package:flutter/material.dart';

String title = "User Testing";
String subTitle = "Agenda";

String sectionsScreenCard1 = "User Interview";
String sectionsScreenCard2 = "Shadowing";
String sectionsScreenCard3 = "Mapping Insights";

String insightsForm = "Insights Form";
String insightFormHint = "Type your insight here";
String cancel = "Cancel";
String done = "Done";
String addInsight = "Add Insight";

var painPointController = new TextEditingController();
final formKey = GlobalKey<FormState>();

var responseArrayAddInsights;
var responseArrayAddInsightsMsg;

var responseArrayGetInsights;
var responseArrayGetInsightsMsg;

List<String> uploadedInsightsList;

var responseArrayGetWareHouseInsights;
var responseArrayGetWareHouseInsightsMsg;

var wareHouseInsightsList;
