import 'package:design_sprint/APIs/signup.dart';
import 'package:design_sprint/ReusableWidgets/upper_curve_clipper.dart';
import 'package:design_sprint/Screens/Inside%20Screens/LoginSignUp%20Screens/login_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/signup_data.dart' as signup;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:design_sprint/utils/hint_texts.dart' as hint;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  SignUpApiProvider apiProvider = SignUpApiProvider();

  @override
  Widget build(BuildContext context) {
    signup.prSignUp = ProgressDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => Login(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                    top: -MediaQuery.of(context).size.height/3.6,right: -MediaQuery.of(context).size.width/6,
                    child: buildUpperImage(context)),
                Positioned(
                  top: -MediaQuery.of(context).size.height/5.6,left: -MediaQuery.of(context).size.width/10,
                  child: Container(
                    height: 280,
                    width: 280,
                    decoration: BoxDecoration(
                        color: Color(0xff302B70),
                        borderRadius: BorderRadius.all(Radius.circular(150))
                    ),
                  ),
                ),
                Positioned(
                  top: -30,left: 0, right: -MediaQuery.of(context).size.width/3,
                  child: Image.asset("assets/images/signup.png"),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height/3.5,left: 0,right: 0,
                  child: SingleChildScrollView(
                    child: Form(
                      key: signup.formKey,
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height/45,),
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(signup.signUpHeading,
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: TextStyle(
                                        fontSize: 32,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                )),
                          ),
                          buildNameField(context),
                          buildEmailField(context),
                          buildPasswordField(context),
                          SizedBox(height: MediaQuery.of(context).size.height/17,),
                          buildSignUpButton(context),
                          SizedBox(height: 20,),
                          alreadyAUserLogin(context),
                          SizedBox(height: 30,),
                        ],
                      ),
                    ),
                  ),
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
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff787cd1),
        borderRadius: BorderRadius.all(Radius.circular(500))
      ),
    );
//    return Container(
//      width: MediaQuery.of(context).size.width,
//      child: Image.asset("assets/images/signupill.png", fit: BoxFit.fitWidth,),
//    );
    /*
      ClipPath(
        clipper: UpperClipper(),
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(0)),
                color: Color(0xff7579cb),
              ),
              width: double.infinity,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: MediaQuery.of(context).size.height / 5.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(1000),
                      bottomRight: Radius.circular(1000)),
                  color: Color(0xff302b6f),
                ),
                width: MediaQuery.of(context).size.width / 1.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/40, right: 30),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset("assets/images/signup.png")),
            )
          ],
        ));

     */
  }

  Widget buildNameField(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Theme(
        data: ThemeData(primaryColor: Color(0xff302b6f)),
        child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          controller: signup.nameController,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(Icons.person, color: Colors.grey.shade300,),
            ),
            hintText: hint.hintName,
          ),
          validator: (value) {
            if (value.length == 0) {
              return hint.validationName;
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildEmailField(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Theme(
        data: ThemeData(primaryColor: Color(0xff302b6f)),
        child: TextFormField(
          controller: signup.emailController,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(Icons.email, color: Colors.grey.shade300,),
            ),
            hintText: hint.hintEmail,
          ),
          validator: (val) => !EmailValidator.validate(val, true)
              ? hint.validationEmail
              : null,
        ),
      ),
    );
  }

  Widget buildPasswordField(BuildContext context){

    void toggle() {
      setState(() {
        signup.obscureText = !signup.obscureText;
      });
    }

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Stack(
        children: [
          Theme(
            data: ThemeData(primaryColor: Color(0xff302b6f)),
            child: TextFormField(
              controller: signup.passwordController,
              obscureText: signup.obscureText,
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
                child: signup.obscureText == true ? Container(
                    height: 25,
                    child: Image.asset("assets/images/visibility.png",fit: BoxFit.cover,)) :Icon(Icons.remove_red_eye,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignUpButton(BuildContext context){
    return GestureDetector(
      onTap: (){
        if(signup.formKey.currentState.validate()){
          signup.prSignUp.show();
          apiProvider.signUp(context);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width/1.4,
          decoration: BoxDecoration(
              color: Color(0xff7579cb),
              borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          child: Center(
            child: Text(signup.signUpHeading,
              style: TextStyle(color: Colors.white, letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget alreadyAUserLogin(BuildContext context){
    return GestureDetector(
      onTap: (){
        //Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => Login(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
        },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(signup.alreadyUser,
            style: TextStyle(
                fontSize: 14,
                letterSpacing: 0.4
            ),
          ),
          Text(signup.login,
            style: TextStyle(
                color: Color(0xff302b6f),
                fontSize: 14,
                letterSpacing: 0.4,
                fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }

}
