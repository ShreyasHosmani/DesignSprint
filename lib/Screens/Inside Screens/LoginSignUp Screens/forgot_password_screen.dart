import 'package:design_sprint/APIs/forgot_password.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:design_sprint/utils/forgot_password_data.dart' as forgotPassword;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:design_sprint/utils/hint_texts.dart' as hint;

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  ForgotPasswordApiProvider forgotPasswordApiProvider = ForgotPasswordApiProvider();

  @override
  Widget build(BuildContext context) {
    forgotPassword.prForgotPassword = ProgressDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildBackButton(context),
              SizedBox(height: MediaQuery.of(context).size.height/15,),
              buildUpperImage(context),
              SizedBox(height: MediaQuery.of(context).size.height/15,),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(forgotPassword.forgotPasswordHeading,
                      style: TextStyle(
                          fontSize: 32,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500
                      ),
                    )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/25,),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(forgotPassword.forgotPasswordTip1,
                    style: TextStyle(color: Color(0xff302b6f), fontSize: 16,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(forgotPassword.forgotPasswordTip2,
                    style: TextStyle(color: Color(0xff302b6f), fontSize: 16,),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/25,),
              buildEmailField(context),
              SizedBox(height: MediaQuery.of(context).size.height/15,),
              buildGetLinkButton(context),
              SizedBox(height: MediaQuery.of(context).size.height/15,),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBackButton(BuildContext context){
    return GestureDetector(
      onTap: (){Navigator.of(context).pop();},
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.arrow_back_ios, size: 13, color: Color(0xff302b6f),),
                SizedBox(width: 2,),
                Text("Back",
                  style: TextStyle(color: Color(0xff302b6f), fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUpperImage(BuildContext context){
    return Container(
      height: 200,
      width: 300,
      child: Image.asset("assets/images/forgotpassowrd.png",
        //fit: BoxFit.cover,
      ),
    );
  }

  Widget buildEmailField(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Theme(
        data: ThemeData(primaryColor: Color(0xff302b6f)),
        child: TextFormField(
          controller: forgotPassword.emailController,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(Icons.email, color: Colors.grey.shade300,),
            ),
            hintText: hint.hintEmail,
          ),
          validator: (val) => !EmailValidator.validate(val, true)
              ? forgotPassword.validation
              : null,
        ),
      ),
    );
  }

  Widget buildGetLinkButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(_formKey.currentState.validate()){
          forgotPassword.prForgotPassword.show();
          forgotPasswordApiProvider.ForgotPassword(context);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10,
        child: Container(
          height: 50,
          width: MediaQuery
              .of(context)
              .size
              .width / 1.4,
          decoration: BoxDecoration(
              color: Color(0xff7579cb),
              borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          child: Center(
            child: Text(forgotPassword.buttonText,
              style: TextStyle(
                  color: Colors.white, letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

}

final _formKey = GlobalKey<FormState>();
