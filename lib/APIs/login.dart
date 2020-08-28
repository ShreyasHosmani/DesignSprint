import 'dart:convert';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/home_screen.dart';
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
      "fcmtoken" : "123456",

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
            Fluttertoast.showToast(msg: login.loginMessage, backgroundColor: Colors.black,
              textColor: Colors.white,);
            clearFields(context);

            profile.userID = login.responseArrayLogin['data']['userID'].toString();

            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString("userID", profile.userID);

            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => Load(),
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

  void clearFields(BuildContext context){
    login.passwordController.clear();
  }

}