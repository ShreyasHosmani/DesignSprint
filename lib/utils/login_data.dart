library main_app.loginglobals;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

var emailController = new TextEditingController();
var passwordController = new TextEditingController();

var responseArrayLogin;
var loginResponse;
var loginMessage;

String loginHeading = "Login";
String dontHaveAnAccount = "Don't have an Account?";
String signUp = " Sign Up";
String signInWith = "Sign In with";
String google = "Google";
String facebook = "Facebook";
String forgotPassword= "Forgot Password?";

ProgressDialog prLogin;

bool obscureText = true;
final formKey = GlobalKey<FormState>();