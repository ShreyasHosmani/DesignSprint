import 'package:flutter/material.dart';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/forgot_password_data.dart' as forgotPassword;
import 'package:fluttertoast/fluttertoast.dart';

class ResetPasswordApiProvider {

  Future<String> ResettPassword(context) async {

    String url = globals.urlLogin + "resetpassword.php";

    http.post(url, body: {

      "email" : forgotPassword.emailController.text,
      "password" : forgotPassword.passwordController.text,
      "confirmpassword" : forgotPassword.confirmPasswordController.text,

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      forgotPassword.resetPasswordResponseArray = jsonDecode(response.body);
      print(forgotPassword.resetPasswordResponseArray);

      forgotPassword.resetPasswordResponseMsg = forgotPassword.resetPasswordResponseArray['message'].toString();

      if(statusCode == 200){
        if(forgotPassword.resetPasswordResponseMsg == "Password change successfully"){
          forgotPassword.prResetPassword.hide();
          Fluttertoast.showToast(msg: forgotPassword.passwordChanged, backgroundColor: Colors.black,
            textColor: Colors.white,).whenComplete((){
              Navigator.of(context).popUntil((route) => route.isFirst);
          });
        }else{
          forgotPassword.prResetPassword.hide();
          Fluttertoast.showToast(msg: forgotPassword.resetPasswordResponseMsg, backgroundColor: Colors.black,
            textColor: Colors.white,);
        }
      }

    });
  }

}