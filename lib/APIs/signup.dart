import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/signup_data.dart' as signup;

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
          signup.prSignUp.hide().whenComplete((){
            Fluttertoast.showToast(msg: signup.signUpSuccessful, backgroundColor: Colors.black,
              textColor: Colors.white,);
            clearFields(context);
            Navigator.of(context).pop();
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