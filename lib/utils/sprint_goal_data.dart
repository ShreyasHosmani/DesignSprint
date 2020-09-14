library main_app.goalglobals;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

String title = "Define your Goal";
String title2 = "Type in your sprint goal in the";
String title3 = "placeholder below";
String hintText = "This title will also be used as the name of your sprint";
String buttonText = "Next";

var goalController = new TextEditingController();

var responseArrayCreateGoal;
var responseArrayCreateGoalMsg;

String goalSaved = "Goal saved";

bool statusDrawer = false;

final formKey = GlobalKey<FormState>();

ProgressDialog prInputGoal;