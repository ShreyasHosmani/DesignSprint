import 'dart:convert';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/home_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/LoginSignUp%20Screens/login_screen.dart';
import 'package:design_sprint/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/login_data.dart' as login;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:design_sprint/utils/profile_data.dart' as profile;

class LoginApiProvider {

  Future<String> Login(context) async {

    String url = globals.urlLogin + "login.php";

    http.post(url, body: {

      "email" : login.emailController.text,
      "password" : login.passwordController.text,
      "fcmtoken" : userToken.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      login.responseArrayLogin = jsonDecode(response.body);
      print(login.responseArrayLogin);

      login.loginResponse = login.responseArrayLogin['status'].toString();
      login.loginMessage = login.responseArrayLogin['message'].toString();

      if(statusCode == 200){
        if(login.loginMessage == "Login Successfull"){
          login.prLogin.hide().whenComplete(() async {
            Fluttertoast.showToast(msg: "Login Successful", backgroundColor: Colors.black,
              textColor: Colors.white,);
            clearFields(context);

            profile.userID = login.responseArrayLogin['data']['userID'].toString();

            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString("userID", profile.userID);

            print(profile.userID);

            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => Home(),
                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          });
        }else{
          login.prLogin.hide();
          Fluttertoast.showToast(msg: login.loginMessage, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }

    });
  }

  Future<String> LoginUsingGoogle(context) async {

    String url = globals.urlSignUp + "socialregister.php";

    http.post(url, body: {

      "fullname" : login.googleName.toString(),
      "email" : login.googleEmail.toString(),
      "password" : "",
      "fcmtoken" : userToken.toString(),
      "authtype" : "Google",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      login.responseArrayLogin = jsonDecode(response.body);
      print(login.responseArrayLogin);
      var msg = login.responseArrayLogin['message'];
      if(msg == "Register Successfull" || msg == "Login Successfull"){
        login.prLogin.hide().whenComplete(() async {
          Fluttertoast.showToast(msg: "Logged in successfully", backgroundColor: Colors.black,
            textColor: Colors.white,);
          clearFields(context);

          profile.userID = login.responseArrayLogin['data']['userID'].toString();

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("userID", profile.userID);

          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => Load(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        });
      }else{
        login.googleSignIn.disconnect();
        Fluttertoast.showToast(msg: 'You have already used this email for sign up!', backgroundColor: Colors.black,
          textColor: Colors.white,);
        login.prLogin.hide();
      }

    });
  }

  Future<String> LoginUsingFacebook(context) async {

    String url = globals.urlSignUp + "socialregister.php";

    http.post(url, body: {

      "fullname" : login.facebookName.toString(),
      "email" : login.facebookEmail.toString(),
      "password" : "",
      "fcmtoken" : userToken.toString(),
      "authtype" : "Facebook",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      login.responseArrayLogin = jsonDecode(response.body);
      print(login.responseArrayLogin);
      var msg = login.responseArrayLogin['message'];
      if(msg == "Register Successfull" || msg == "Login Successfull"){
        login.prLogin.hide().whenComplete(() async {
          Fluttertoast.showToast(msg: "Logged in successfully", backgroundColor: Colors.black,
            textColor: Colors.white,);
          clearFields(context);

          profile.userID = login.responseArrayLogin['data']['userID'].toString();

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("userID", profile.userID);

          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => Load(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        });
      }else{
        login.facebookLogin.logOut();
        Fluttertoast.showToast(msg: 'You have already used this email for sign up!', backgroundColor: Colors.black,
          textColor: Colors.white,);
        login.prLogin.hide();
      }

    });
  }

  Future<String> LoginUsingApple(context,appleEmailStudent,appleFullNameStudent ) async {

    print("NameeeeeeApppllleeee:"+appleFullNameStudent);
    print("EmailllApppllleeee"+appleEmailStudent);

    String url = globals.urlSignUp + "socialregister.php";

    http.post(url, body: {

      "fullname" : appleFullNameStudent.toString(),
      "email" : appleEmailStudent.toString(),
      "password" : "",
      "fcmtoken" : userToken.toString(),
      "authtype" : "Apple",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      login.responseArrayLogin = jsonDecode(response.body);
      print(login.responseArrayLogin);
      var msg = login.responseArrayLogin['message'];
      if(msg == "Register Successfull" || msg == "Login Successfull"){
        login.prLogin.hide().whenComplete(() async {
          Fluttertoast.showToast(msg: "Logged in successfully", backgroundColor: Colors.black,
            textColor: Colors.white,);
          clearFields(context);

          profile.userID = login.responseArrayLogin['data']['userID'].toString();

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("userID", profile.userID);

          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => Load(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        });
      }else{
        login.googleSignIn.disconnect();
        Fluttertoast.showToast(msg: 'You have already used this email for sign up!', backgroundColor: Colors.black,
          textColor: Colors.white,);
        login.prLogin.hide();
      }

    });
  }

  /*
  Future<String> LoginUsingApple(context, appleEmail, appleFullName) async {

    String url = globals.url + "socialregister";

    http.post(url, body: {

      "email": appleEmail.toString(),
      "fullname": appleFullName.toString(),
      "profilepic" : '',
      "authid" : '',
      "authfacebook" : '',
      "authgoogle" : '',
      "authapple" : appleAuthId.toString(),
      "fcmtoken" : userToken.toString(),

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      var responseArrayGoogle = jsonDecode(response.body);
      print(responseArrayGoogle);


      var status = responseArrayGoogle['status'];
      var msg = responseArrayGoogle['message'];
      if(status == "200" || status == 200){
        pr.hide();

        Fluttertoast.showToast(msg: "Logged in successfully!", backgroundColor: Colors.black,
          textColor: Colors.white,);
        setState(() {
          showLoading = false;
        });

        setState(() {
          userID = List.generate(
              responseArrayGoogle.length, (i) => responseArrayGoogle['data']['userID']);
          var userNameList = List.generate(
              responseArrayGoogle.length, (i) => responseArrayGoogle['data']['userFullname']);
          var userEmailList = List.generate(
              responseArrayGoogle.length, (i) => responseArrayGoogle['data']['userEmail']);
          var expertAuthProvider = List.generate(
              responseArrayGoogle.length, (i) => responseArrayGoogle['data']['userAuthProvider']);


          userIDOne = userID[0];
          //userName = userNameList[0];
          //       userEmail = userEmailList[0];
          authProvider = expertAuthProvider[0];
          userSavedAuth = authProvider;

          print(userIDOne);
          //print(userName);
          //print(userEmail);
          print(authProvider);

        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen()),
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("lastLoggedInStudent", true);
        prefs.setString("userId", userIDOne);
        prefs.setString("userSavedAuth", userSavedAuth);

        //pr.hide();
        _passwordController.clear();

      }
      else if(status == "401" || status == 401 || status == "402" || status == 402){
        //await pr.hide();

        Fluttertoast.showToast(msg: msg, backgroundColor: Colors.black,
          textColor: Colors.white,);

        pr.hide();
      }else{
        //await pr.hide();

        Fluttertoast.showToast(msg: msg, backgroundColor: Colors.black,
          textColor: Colors.white,);

        pr.hide();
      }

    });
  }

   */

  void clearFields(BuildContext){

  }
}