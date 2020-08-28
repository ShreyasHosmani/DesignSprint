import 'package:design_sprint/APIs/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:design_sprint/utils/forgot_password_data.dart' as forgotPassword;
import 'package:design_sprint/utils/hint_texts.dart' as hint;
import 'package:progress_dialog/progress_dialog.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  ResetPasswordApiProvider resetPasswordApiProvider = ResetPasswordApiProvider();

  @override
  Widget build(BuildContext context) {
    forgotPassword.prResetPassword = ProgressDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/5,),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(forgotPassword.resetPassword,
                      style: TextStyle(
                          fontSize: 32,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500
                      ),
                    )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/10,),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(forgotPassword.resetPassword,
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    )),
              ),
              buildNewPasswordField(context),
              SizedBox(height: MediaQuery.of(context).size.height/20,),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(forgotPassword.confirmPassword,
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    )),
              ),
              buildConfirmPasswordField(context),
              SizedBox(height: MediaQuery.of(context).size.height/10,),
              buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNewPasswordField(BuildContext context){

    void toggle() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Stack(
        children: [
          Theme(
            data: ThemeData(primaryColor: Color(0xff302b6f)),
            child: TextFormField(
              controller: forgotPassword.passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(Icons.lock, color: Colors.grey.shade300,),
                ),
                hintText: hint.hintPassword,
              ),
              validator: (value) {
                if (value.length == 0) {
                  return hint.validationPasswordCompulsary;
                } else if (value.length < 6) {
                  return hint.validationPasswordLength;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: toggle,
                child: Icon(Icons.remove_red_eye,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildConfirmPasswordField(BuildContext context){

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Theme(
        data: ThemeData(primaryColor: Color(0xff302b6f)),
        child: TextFormField(
          controller: forgotPassword.confirmPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(Icons.lock, color: Colors.grey.shade300,),
            ),
            hintText: hint.hintPassword,
          ),
          validator: (value) {
            if (value.length == 0) {
              return hint.validationPasswordCompulsary;
            } else if (value.length < 6) {
              return hint.validationPasswordLength;
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildSaveButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(_formKey.currentState.validate()){
          forgotPassword.prResetPassword.show();
          resetPasswordApiProvider.ResettPassword(context);
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
            child: Text(forgotPassword.buttonTextResetPassword,
              style: TextStyle(
                  color: Colors.white, letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
//variables
bool _obscureText = true;
final _formKey = GlobalKey<FormState>();
