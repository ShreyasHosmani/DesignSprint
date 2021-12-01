import 'dart:convert';
import 'dart:io';
//import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:design_sprint/APIs/login.dart';
import 'package:design_sprint/ReusableWidgets/upper_curve_clipper.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/home_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/LoginSignUp%20Screens/forgot_password_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/LoginSignUp%20Screens/signup_screen.dart';
import 'package:design_sprint/main.dart';
import 'package:email_validator/email_validator.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/login_data.dart' as login;
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:design_sprint/utils/hint_texts.dart' as hint;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:design_sprint/utils/globals.dart' as globals;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

var appleEmailStudent;
var appleFullNameStudent;
var appleAuthId;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  LoginApiProvider apiProviderLogin = LoginApiProvider();
  String your_client_id = "963311327761537";
  String your_redirect_url = "https://www.facebook.com/connect/login_success.html";

  loginWithFacebook() async{
    final result = await login.facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          login.userProfile = profile;
          login.isLoggedIn = true;
          login.facebookName = profile['name'];
          login.facebookEmail = profile['email'];
          login.facebookAuthId = profile['id'];
        });
        print(login.facebookName);
        print(login.facebookEmail);
        print(login.facebookAuthId);
        apiProviderLogin.LoginUsingFacebook(context);
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => login.isLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => login.isLoggedIn = false );
        break;
    }

  }

  Future<void> _handleSignIn() async {
    try {
      await login.googleSignIn.signIn().then((value) {
        login.prLogin.hide();
        setState(() {
          login.googleEmail = login.googleSignIn.currentUser.email;
          login.googleName = login.googleSignIn.currentUser.displayName;
          login.googleAuthId = login.googleSignIn.currentUser.id;
        });
        login.prLogin.show();
        apiProviderLogin.LoginUsingGoogle(context);
      });
    } catch (error) {
      print(error);
      _handleSignOut();
    }
  }

  Future<void> _handleSignOut() => login.googleSignIn.disconnect();

  Future<String> LoginUsingApple(context) async {

    String url = globals.urlSignUp + "socialregister.php";

    http.post(url, body: {

      "fullname" : appleFullNameStudent.toString(),
      "email" : appleEmailStudent.toString(),
      "password" : "",
      "fcmtoken" : userToken.toString(),
      "authtype" : "Apple",
      "authid" : "$appleAuthId",

    }).then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error fetching data");
      }

      login.responseArrayLogin = jsonDecode(response.body);
      print(login.responseArrayLogin);
      var msg = login.responseArrayLogin['message'];
      if(msg == "Register Successfull" || msg == "Login Successfull"){
        login.prLogin.hide().whenComplete(() async {
          Fluttertoast.showToast(msg: "Logged in successfully", backgroundColor: Colors.black,
            textColor: Colors.white,);

          profile.userID = login.responseArrayLogin['data']['userID'].toString();

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("userID", profile.userID);

          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => Load(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        });
      }else{
        login.googleSignIn.disconnect();
        Fluttertoast.showToast(msg: 'You have already used this email for sign up!', backgroundColor: Colors.black,
          textColor: Colors.white,);
        login.prLogin.hide();
      }

    });
  }

  /*
  Future<FirebaseUser> signInWithApple({List<Scope> scopes = const [Scope.email, Scope.fullName]}) async {
    final _firebaseAuth = FirebaseAuth.instance;
    // 1. perform the sign-in request
    final result = await AppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider(providerId: 'apple.com');
        final credential = oAuthProvider.getCredential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken),
          accessToken:
          String.fromCharCodes(appleIdCredential.authorizationCode),
        );
        final authResult = await _firebaseAuth.signInWithCredential(credential);
        final firebaseUser = authResult.user;
        if (scopes.contains(Scope.fullName)) {
          final updateUser = UserUpdateInfo();
          updateUser.displayName =
          '${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}';
          await firebaseUser.updateProfile(updateUser);

          setState(() {
            appleEmailStudent = firebaseUser.email;
            appleFullNameStudent = firebaseUser.displayName;
          });

          print(firebaseUser.email);
          print(firebaseUser.displayName);

          String url = globals.urlSignUp + "socialregister.php";

          http.post(url, body: {

            "fullname" : firebaseUser.displayName.toString(),
            "email" : firebaseUser.email.toString(),
            "password" : "",
            "fcmtoken" : userToken.toString(),
            "authtype" : "Apple",

          }).then((http.Response response) async {
            final int statusCode = response.statusCode;

            if (statusCode < 200 || statusCode > 400 || json == null) {
              throw new Exception("Error fetching data");
            }

            login.responseArrayLogin = jsonDecode(response.body);
            print(login.responseArrayLogin);
            var msg = login.responseArrayLogin['message'];
            if(msg == "Register Successfull" || msg == "Login Successfull"){
              login.prLogin.hide().whenComplete(() async {
                Fluttertoast.showToast(msg: "Logged in successfully", backgroundColor: Colors.black,
                  textColor: Colors.white,);

                profile.userID = login.responseArrayLogin['data']['userID'].toString();

                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString("userID", profile.userID);

                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => Load(),
                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                    transitionDuration: Duration(milliseconds: 300),
                  ),
                );
              });
            }else{
              login.googleSignIn.disconnect();
              Fluttertoast.showToast(msg: 'You have already used this email for sign up!', backgroundColor: Colors.black,
                textColor: Colors.white,);
              login.prLogin.hide();
            }

          });

        }
        return firebaseUser;
      case AuthorizationStatus.error:
        print(result.error.toString());
        login.prLogin.hide();
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        login.prLogin.hide();
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
    }
    return null;
  }

   */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // AppleSignIn.onCredentialRevoked.listen((_) {
    //   print("Credentials revoked");
    // });
    //FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    login.prLogin = ProgressDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                  top: -MediaQuery.of(context).size.height/10,left: 0,right: 0,
                  child: buildUpperImage(context)),
              Positioned(
                top: MediaQuery.of(context).size.height/3.5,left: 0,right: 0,
                child: WillPopScope(
                  onWillPop: () => showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                      title: new Text('Are you sure?'),
                      content: new Text('Do you want to exit the App'),
                      actions: <Widget>[
                        new GestureDetector(
                          onTap: () => Navigator.of(context).pop(false),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("No"),
                          ),
                        ),
                        SizedBox(height: 16),
                        new GestureDetector(
                          onTap: () => exit(0),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("Yes"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: login.formKey,
                      child: Column(
                        children: [
                          //buildUpperImage(context),
                          SizedBox(height: 50),
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(login.loginHeading,
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
                          buildPasswordField(context),
                          forgotPassword(context),
                          SizedBox(height: MediaQuery.of(context).size.height/30,),
                          buildLoginButton(context),
                          SizedBox(height: MediaQuery.of(context).size.height/20,),
                          newUserSignUp(context),
                          SizedBox(height: MediaQuery.of(context).size.height/20,),
                          signInWith(context),
                          SizedBox(height: MediaQuery.of(context).size.height/40,),
                          Platform.isAndroid ? buildSocialLogins(context) :
                          buildSocialLoginsRow(context),
                          SizedBox(height: 40,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUpperImage(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Image.asset("assets/images/loginill.png", fit: BoxFit.cover,),
    );
    /*
      ClipPath(
        clipper: UpperClipper(),
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3.4,
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
                height: MediaQuery.of(context).size.height / 3.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(140)),
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
                  height: MediaQuery.of(context).size.height / 4.4,
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

     */
  }

  Widget buildEmailField(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Theme(
        data: ThemeData(primaryColor: Color(0xff302b6f)),
        child: TextFormField(
          controller: login.emailController,
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
        login.obscureText = !login.obscureText;
      });
    }

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Stack(
        children: [
          Theme(
            data: ThemeData(primaryColor: Color(0xff302b6f)),
            child: TextFormField(
              controller: login.passwordController,
              obscureText: login.obscureText,
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
                child: login.obscureText == true ? Container(
                    height: 25,
                    child: Image.asset("assets/images/visibility.png",fit: BoxFit.cover,)) : Icon(Icons.remove_red_eye,
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
            child: Text(login.forgotPassword,
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
        if(login.formKey.currentState.validate()){
          login.prLogin.show();
          apiProviderLogin.Login(context);
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
            child: Text(login.loginHeading,
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
        Navigator.pushReplacement(
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
          Text(login.dontHaveAnAccount,
            style: TextStyle(
                fontSize: 14,
                letterSpacing: 0.4
            ),
          ),
          Text(login.signUp,
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
      child: Text(login.signInWith,
        style: TextStyle(
            fontSize: 16,
            letterSpacing: 0.2,
            color: Colors.grey.shade600,
        ),
      ),
    );
  }

  buildSocialLoginsRow(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {

            final credential = await SignInWithApple.getAppleIDCredential(
              scopes: [
                AppleIDAuthorizationScopes.email,
                AppleIDAuthorizationScopes.fullName,
              ],
            );

            print(credential);

            setState(() {
              appleAuthId = credential.userIdentifier.toString();
              appleFullNameStudent = credential.givenName.toString()+" "+credential.familyName.toString();
              appleEmailStudent = credential.email.toString();
            });

            print("apple userIdentifier : "+appleAuthId);
            print("appleFullNameStudent : "+appleFullNameStudent);
            print("appleEmailStudent : "+appleEmailStudent);

            if(appleFullNameStudent.toString() == "null" || credential.email.toString() == "null" || credential.email.isEmpty || credential.email == null){
              print("**********");
              Fluttertoast.showToast(msg: "Account already exists! Please login.", textColor: Colors.white, backgroundColor: Colors.black);
            }else{
              print("/////////");
              LoginUsingApple(context);
            }

          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(
                image: AssetImage("assets/images/apple.png"),
              ),
            ),
          ),
        ),
        SizedBox(width: 25,),
        InkWell(
          onTap: (){
            login.prLogin.show();
            _handleSignIn();
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.blue),
            ),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/search.png"),
                  ),
                ),
              ),
            ),
          ),
        ),
        /*
        SizedBox(width: 25,),
        InkWell(
          onTap: (){
            login.prLogin.show();
            loginWithFacebook();
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(
                image: AssetImage("assets/images/faceb.png"),
              ),
            ),
          ),
        ),

         */
      ],
    );
  }

  Widget buildSocialLogins(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildGoogleLogin(context),
      ],
    );
  }

  Widget buildGoogleLogin(BuildContext context){
    return InkWell(
      onTap: (){
        login.prLogin.show();
        _handleSignIn();
      },
      child: Card(
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
                Text(login.google,
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFacebookLogin(BuildContext context){
    return InkWell(
      onTap: (){
        login.prLogin.show();
        loginWithFacebook();
      },
      child: Card(
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
                Text(login.facebook,
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

