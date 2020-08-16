import 'package:design_sprint/Screens/Inside%20Screens/LoginSignUp%20Screens/reset_password_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
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
                    child: Text("Forgot Password",
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
                  child: Text("Please enter your email to get your",
                    style: TextStyle(color: Color(0xff302b6f), fontSize: 16,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("One Time Verification Password.",
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

  Widget buildGetLinkButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(_formKey.currentState.validate()){
          showAlertDialog(context);
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
            child: Text("Get OTP",
              style: TextStyle(
                  color: Colors.white, letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget otpField = Container(
      height: 50,
      width: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff302b6f)),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );

    Widget otpRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        otpField,
        SizedBox(width: 3,),
        otpField,
        SizedBox(width: 3,),
        otpField,
        SizedBox(width: 3,),
        otpField,
        SizedBox(width: 3,),
        otpField,
        SizedBox(width: 3,),
        otpField,
      ],
    );

    GestureDetector buildSaveButton = GestureDetector(
      onTap: (){
        Navigator.of(context).pop();
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => ResetPassword(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
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
              .width / 1.5,
          decoration: BoxDecoration(
              color: Color(0xff7579cb),
              borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          child: Center(
            child: Text("Submit",
              style: TextStyle(
                  color: Colors.white, letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
      title: Column(
        children: [
          SizedBox(height: 20,),
          Text("Please enter one time", style: TextStyle(fontSize: 16, letterSpacing: 1),),
          Text("password",style: TextStyle(fontSize: 16, letterSpacing: 1),),
          SizedBox(height: 10,)
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Container(
          height: MediaQuery.of(context).size.height/3,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              otpRow,
              Text("Resent OTP", style: TextStyle(fontSize: 16, letterSpacing: 1,color: Color(0xff7579cb)),),
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

final _formKey = GlobalKey<FormState>();
