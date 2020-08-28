library main_app.signupglobals;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

var nameController = new TextEditingController();
var emailController = new TextEditingController();
var passwordController = new TextEditingController();

var responseArraySignUp;
var signUpResponse;
var signUpMessge;

String signUpSuccessful = "Registered successfully, please Login!";
String signUpEmailAlreadyExits = "This email already exists";
String signUpError = "Error";
String signUpHeading = "Sign Up";
String alreadyUser = "Already a user?";
String login = " Login";

bool obscureText = true;
final formKey = GlobalKey<FormState>();

ProgressDialog prSignUp;