import 'package:design_sprint/ReusableWidgets/upper_curve_clipper.dart';
import 'package:design_sprint/Screens/Inside%20Screens/LoginSignUp%20Screens/forgot_password_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/home_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/LoginSignUp%20Screens/signup_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildUpperImage(context),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Login",
                      style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                            fontSize: 32,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    )),
              ),
              buildEmailField(context),
              SizedBox(height: 5,),
              buildPasswordField(context),
              forgotPassword(context),
              SizedBox(height: MediaQuery.of(context).size.height/17,),
              buildLoginButton(context),
              SizedBox(height: 15,),
              newUserSignUp(context),
              SizedBox(height: 20,),
              signInWith(context),
              SizedBox(height: 30,),
              buildSocialLogins(context),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUpperImage(BuildContext context){
    return ClipPath(
        clipper: UpperClipper(),
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(50)),
                color: Color(0xff7579cb),
              ),
              width: double.infinity,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(80)),
                  color: Color(0xff302b6f),
                ),
                width: MediaQuery.of(context).size.width / 1.26,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/55, left: 100),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height / 4.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(200)),
                    color: Color(0xff96C3CB),
                  ),
                  width: MediaQuery.of(context).size.width / 1.7,
                  child: Image.asset("assets/images/loginpage.png"),
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildEmailField(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Theme(
        data: ThemeData(primaryColor: Color(0xff302b6f)),
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(Icons.email, color: Colors.grey.shade300,),
            ),
                hintText: 'Email',
          ),
          validator: (val) => !EmailValidator.validate(val, true)
              ? 'Not a valid email.'
              : null,
        ),
      ),
    );
  }

  Widget buildPasswordField(BuildContext context){

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
              obscureText: _obscureText,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(Icons.lock, color: Colors.grey.shade300,),
                ),
                hintText: 'Password',
              ),
              validator: (value) {
                if (value.length == 0) {
                  return 'Password is compulsary!';
                } else if (value.length < 6) {
                  return 'Password must be more than 6 charecters';
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

  Widget forgotPassword(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => ForgotPassword(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 30, top: 10),
            child: Text("Forgot Password?",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                    letterSpacing: 0.4
              ),
            ),
          )),
    );
  }

  Widget buildLoginButton(BuildContext context){
    return GestureDetector(
      onTap: (){
        if(_formKey.currentState.validate()){
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => Home(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
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
            child: Text("Login",
              style: TextStyle(color: Colors.white, letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget newUserSignUp(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => SignUp(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an Account?",
            style: TextStyle(
                fontSize: 14,
                letterSpacing: 0.4
            ),
          ),
          Text(" Sign Up",
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

  Widget signInWith(BuildContext context){
    return Align(
      alignment: Alignment.center,
      child: Text("Sign In with",
        style: TextStyle(
            fontSize: 16,
            letterSpacing: 0.2,
            color: Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget buildSocialLogins(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width: 30,),
        buildGoogleLogin(context),
        buildFacebookLogin(context),
        SizedBox(width: 30,),
      ],
    );
  }

  Widget buildGoogleLogin(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 1,
      shadowColor: Colors.grey.shade500,
      child: Container(
        width: MediaQuery.of(context).size.width/3,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 25, height: 25,
                  child: Image.asset("assets/images/google.jpg")),
              SizedBox(width: 5,),
              Text("Google",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFacebookLogin(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 1,
      shadowColor: Colors.grey.shade500,
      child: Container(
        width: MediaQuery.of(context).size.width/3,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 25, height: 25,
                  child: Image.asset("assets/images/facebook.png")),
              SizedBox(width: 5,),
              Text("Facebook",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}




















// variable declarations
bool _obscureText = true;
final _formKey = GlobalKey<FormState>();
