import 'dart:convert';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/signup_data.dart' as signup;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/login_data.dart' as login;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpApiProvider {

  Future<String> signUp(context) async {

    String url = globals.urlSignUp + "register.php";

    http.post(url, body: {

      "fullname" : signup.nameController.text,
      "email": signup.emailController.text,
      "password" : signup.passwordController.text,
      "fcmtoken" : "123456"


    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      signup.responseArraySignUp = jsonDecode(response.body);
      print(signup.responseArraySignUp);
      
      signup.signUpResponse = signup.responseArraySignUp['status'].toString();
      signup.signUpMessge = signup.responseArraySignUp['message'].toString();
      if(statusCode == 200){
        if(signup.signUpMessge == "Customer Added Successfully"){
          signup.prSignUp.hide().whenComplete(() async {
            Fluttertoast.showToast(msg: signup.signUpSuccessful, backgroundColor: Colors.black,
              textColor: Colors.white,);
            clearFields(context);

            profile.userID = signup.responseArraySignUp['data'].toString();

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
          signup.prSignUp.hide().whenComplete((){
            Fluttertoast.showToast(msg: signup.signUpEmailAlreadyExits, backgroundColor: Colors.black,
              textColor: Colors.white,);
          });
        }
      }
    });
  }

  void clearFields(BuildContext context){
    signup.emailController.clear();
    signup.nameController.clear();
    signup.passwordController.clear();
  }

}