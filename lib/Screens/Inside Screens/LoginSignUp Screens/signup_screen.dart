import 'package:design_sprint/ReusableWidgets/upper_curve_clipper.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              SizedBox(height: MediaQuery.of(context).size.height/17,),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Sign Up",
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
              SizedBox(height: 5,),
              buildEmailField(context),
              SizedBox(height: 5,),
              buildPasswordField(context),
              SizedBox(height: MediaQuery.of(context).size.height/17,),
              buildSignUpButton(context),
              SizedBox(height: 15,),
              alreadyAUserLogin(context),
              SizedBox(height: 30,),
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
  }

  Widget buildNameField(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Theme(
        data: ThemeData(primaryColor: Color(0xff302b6f)),
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(Icons.perm_identity, color: Colors.grey.shade300,),
            ),
            hintText: 'Name',
          ),
          validator: (value) {
            if (value.length == 0) {
              return 'Name is compulsary!';
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

  Widget buildSignUpButton(BuildContext context){
    return GestureDetector(
      onTap: (){
        if(_formKey.currentState.validate()){
          print("Logged in successfully");
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
            child: Text("Sign Up",
              style: TextStyle(color: Colors.white, letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget alreadyAUserLogin(BuildContext context){
    return GestureDetector(
      onTap: (){Navigator.of(context).pop();},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already a user?",
            style: TextStyle(
                fontSize: 14,
                letterSpacing: 0.4
            ),
          ),
          Text(" Login",
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




















// variable declarations
bool _obscureText = true;
final _formKey = GlobalKey<FormState>();
