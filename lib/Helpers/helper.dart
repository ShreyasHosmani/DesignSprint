import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';


String userid = "";
var fcmtoken = "fcm";
String currentVerion = "";
var support_website = "";
var support_email = "";
var support_phone = "";
var support_about_us = "";
int unread_count = 0;

Email getEmalSender(emailtemp, subject) {
  return Email(
    body: '',
    subject: subject,
    recipients: [emailtemp],
    cc: [''],
    //bcc: ['bcc@example.com'],
    //attachmentPaths: ['/path/to/attachment.zip'],
    isHTML: false,
  );
}

  void commonLaunchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

int getColorCode(String color) {
  return int.parse(color.replaceAll("#", "0xff"));
}

bool isEmailValid(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return regex.hasMatch(email);
}

pushReplacement(BuildContext context, Widget destination) {
  Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => destination,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 300),
      ));
}

push(BuildContext context, Widget destination) {
  Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => destination,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 300),
      ));
}

pop(BuildContext context) {
  Navigator.pop(context);
}

void commonToast(BuildContext context, String msg) {
  Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      msg: msg,
      backgroundColor: Colors.black,
      textColor: Colors.white);
}

void logLongString(String s) {
  if (s == null || s.length <= 0) return;
  const int n = 1000;
  int startIndex = 0;
  int endIndex = n;
  while (startIndex < s.length) {
    if (endIndex > s.length) endIndex = s.length;
    print(s.substring(startIndex, endIndex));
    startIndex += n;
    endIndex = startIndex + n;
  }
}
