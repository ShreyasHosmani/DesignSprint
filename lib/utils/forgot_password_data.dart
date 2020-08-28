library main_app.forgotpasswordglobals;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog prForgotPassword;
ProgressDialog prResetPassword;

final focus1 = FocusNode();
final focus2 = FocusNode();
final focus3 = FocusNode();
final focus4 = FocusNode();

var emailController = new TextEditingController();
var optController1 = new TextEditingController();
var optController2 = new TextEditingController();
var optController3 = new TextEditingController();
var optController4 = new TextEditingController();

var passwordController = new TextEditingController();
var confirmPasswordController = new TextEditingController();

var forgotPasswordResponseArray;
var responseArrayMessage;
var verifyOTPResponseArray;
var verifyOTPMessage;

String otpMatchMessage = "OTP Verified";
String otpIncorrectMessage = "OTP Incorrect";

String forgotPasswordHeading = "Forgot Password";
String forgotPasswordTip1 = "Please enter your email to get your";
String forgotPasswordTip2 = "One Time verification Password";

String validation = "Not a valid Email.";
String buttonText = "Get OTP";
String buttonTextSubmit = "Submit";
String forgotPasswordTip3 = "Please enter one time";
String forgotPasswordTip4 = "password";
String forgotPasswordTip5 = "Resend OTP";

String otpValidation = "OTP fields cannot be empty!";

String resetPassword = "Reset Password";
String newPassword = "New Password";
String confirmPassword = "Confirm Password";
String buttonTextResetPassword = "Save";

var resetPasswordResponseArray;
var resetPasswordResponseMsg;

String passwordChanged = "Password changed Successfully";
