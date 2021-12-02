import 'package:design_sprint/Screens/Inside%20Screens/LoginSignUp%20Screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:design_sprint/utils/forgot_password_data.dart'
    as forgotPassword;
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordApiProvider {
  Future<String> ForgotPassword(context) async {
    String url = globals.urlLogin + "forgotpassword.php";

    http.post(url, body: {
      "email": forgotPassword.emailController.text,
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      forgotPassword.forgotPasswordResponseArray = jsonDecode(response.body);
      print(forgotPassword.forgotPasswordResponseArray);

      forgotPassword.responseArrayMessage =
          forgotPassword.forgotPasswordResponseArray['message'].toString();
      if (statusCode == 200) {
        if (forgotPassword.responseArrayMessage == "OTP sent to email") {
          forgotPassword.prForgotPassword.hide();
          Fluttertoast.showToast(msg: forgotPassword.responseArrayMessage)
              .whenComplete(() {
            showAlertDialog(context);
          });
        } else {
          Fluttertoast.showToast(msg: forgotPassword.responseArrayMessage);
        }
      }
    });
  }

  Future<String> verifyOTP(context) async {
    print(forgotPassword.emailController.text);
    print(forgotPassword.optController1.text +
        forgotPassword.optController2.text +
        forgotPassword.optController3.text +
        forgotPassword.optController4.text);

    String url = globals.urlLogin + "verifyotp.php";

    http.post(url, body: {
      "email": forgotPassword.emailController.text,
      "otp": forgotPassword.optController1.text +
          forgotPassword.optController2.text +
          forgotPassword.optController3.text +
          forgotPassword.optController4.text,
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode != 200 || json == null) {
        throw new Exception("Error fetching data");
      }

      forgotPassword.verifyOTPResponseArray = jsonDecode(response.body);
      print(forgotPassword.verifyOTPResponseArray);

      forgotPassword.verifyOTPMessage =
          forgotPassword.verifyOTPResponseArray['message'].toString();

      if (statusCode == 200) {
        if (forgotPassword.verifyOTPMessage == "OTP Verify") {
          forgotPassword.prForgotPassword.hide();
          Fluttertoast.showToast(msg: forgotPassword.otpMatchMessage)
              .whenComplete(() {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => ResetPassword(),
                transitionsBuilder: (c, anim, a2, child) =>
                    FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 300),
              ),
            );
          });
        } else {
          forgotPassword.prForgotPassword.hide();
          Fluttertoast.showToast(msg: forgotPassword.otpIncorrectMessage);
        }
      }
    });
  }

  showAlertDialog(BuildContext context) {
    forgotPassword.optController1.clear();
    forgotPassword.optController2.clear();
    forgotPassword.optController3.clear();
    forgotPassword.optController4.clear();
    FocusNode f1 = FocusNode();
    FocusNode f2 = FocusNode();
    FocusNode f3 = FocusNode();
    FocusNode f4 = FocusNode();
    Widget otpField1 = Container(
      height: 50,
      width: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff302b6f)),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
        focusNode: f1,
        textAlign: TextAlign.center,
        controller: forgotPassword.optController1,
        autofocus: true,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        onChanged: (text) {
          if (forgotPassword.optController1.text.length == 1) {
            f1.unfocus();
            f2.requestFocus();
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
      ),
    );
    Widget otpField2 = Container(
      height: 50,
      width: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff302b6f)),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
        focusNode: f2,
        textAlign: TextAlign.center,
        controller: forgotPassword.optController2,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        onChanged: (text) {
          if (forgotPassword.optController2.text.length == 1) {
            // FocusScope.of(context).requestFocus(forgotPassword.focus3);
            f2.unfocus();
            f3.requestFocus();
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
      ),
    );
    Widget otpField3 = Container(
      height: 50,
      width: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff302b6f)),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
        focusNode: f3,
        textAlign: TextAlign.center,
        controller: forgotPassword.optController3,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.number,
        onChanged: (text) {
          if (forgotPassword.optController3.text.length == 1) {
            // FocusScope.of(context).requestFocus(forgotPassword.focus4);
            f3.unfocus();
            f4.requestFocus();
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
      ),
    );
    Widget otpField4 = Container(
      height: 50,
      width: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff302b6f)),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        focusNode: f4,
        textAlign: TextAlign.center,
        controller: forgotPassword.optController4,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
      ),
    );

    Widget otpRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        otpField1,
        SizedBox(
          width: 3,
        ),
        otpField2,
        SizedBox(
          width: 3,
        ),
        otpField3,
        SizedBox(
          width: 3,
        ),
        otpField4,
      ],
    );

    GestureDetector buildSaveButton = GestureDetector(
      onTap: () {
        if (forgotPassword.optController1 == null ||
            forgotPassword.optController2 == null ||
            forgotPassword.optController3 == null ||
            forgotPassword.optController4 == null) {
          Fluttertoast.showToast(msg: forgotPassword.otpValidation);
        } else {
          forgotPassword.prForgotPassword.show();
          verifyOTP(context);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
              color: Color(0xff7579cb),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Center(
            child: Text(
              forgotPassword.buttonTextSubmit,
              style: TextStyle(
                  color: Colors.white, letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      title: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            forgotPassword.forgotPasswordTip3,
            style: TextStyle(fontSize: 16, letterSpacing: 1),
          ),
          Text(
            forgotPassword.forgotPasswordTip4,
            style: TextStyle(fontSize: 16, letterSpacing: 1),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              otpRow,
              Text(
                forgotPassword.forgotPasswordTip5,
                style: TextStyle(
                    fontSize: 16, letterSpacing: 1, color: Color(0xff7579cb)),
              ),
              buildSaveButton,
            ],
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
