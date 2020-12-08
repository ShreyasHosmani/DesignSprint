import 'dart:io';
import 'package:design_sprint/APIs/edit_profile.dart';
import 'package:design_sprint/APIs/logout.dart';
import 'package:design_sprint/Screens/Initial%20Screen/initial_screen.dart';
import 'package:design_sprint/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/globals.dart' as globals;

bool imagePicked = false;
var focusName = FocusNode();
var focusEmail = FocusNode();
var focusMobileNo = FocusNode();

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  EditProfileApiProvider editProfileApiProvider = EditProfileApiProvider();
  LogoutApiProvider logoutApiProvider = LogoutApiProvider();
  final picker = ImagePicker();
  Future getImageOne() async {
    Navigator.of(context).pop();
    var pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 25,);
    setState(() {
      home.profileImage = File(pickedFile.path);
      imagePicked = true;
    });
    print(imagePicked);
  }
  Future getImageOneGallery() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 25,);
    setState(() {
      home.profileImage = File(pickedFile.path);
      imagePicked = true;
    });
    print(imagePicked);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicked = false;
    print(profile.profilePicImage.toString().substring(0,2));
    home.profileImage = null;
    home.profileNameController.clear();
    home.profileEmailController.clear();
    home.profilePasswordController.clear();
    home.profileMobileNumberController.clear();

    home.profileNameController = TextEditingController(text: profile.name);
    home.profileEmailController = TextEditingController(text: profile.email);
    home.profileMobileNumberController = TextEditingController(text: profile.mobileNo);
  }
  @override
  Widget build(BuildContext context) {
    home.prEditProfile = ProgressDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildProfilePictureStack(context),
            buildForm(context),
            SizedBox(height: 20,),
            buildNextButton(context),
            SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context){

    Container line = Container(height:1,color: Colors.black,child: Divider());

    return AppBar(
      backgroundColor: Color(0xff787cd1),
      elevation: 0,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text("Profile",
          style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 35, top: 17),
        child: IconButton(
          onPressed: (){Navigator.of(context).pop();},
          icon: Icon(Icons.arrow_back_ios,size: 15, color: Colors.white,),
        ),
      ),
    );
  }

  Widget buildProfilePictureStack(BuildContext context){
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 130,
          color: Color(0xff787cd1),
          //child: Image.asset("assets/images/profilebg.png", fit: BoxFit.fitWidth,),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: Stack(
              children: [
                profile.profilePicImage.toString().substring(0,2) == ".." && imagePicked == false ? Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Color(0xff787cd1),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      image: DecorationImage(
                        image: NetworkImage(globals.urlSignUp+profile.profilePicImage),
                        fit: BoxFit.cover,
                      )
                  ),
                ) : home.profileImage == null ? Container(
                  width: 155,
                  height: 155,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color(0xff787cd1),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                 ) : imagePicked == true ? Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Color(0xff787cd1),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      image: DecorationImage(
                        image: FileImage(home.profileImage),
                        fit: BoxFit.cover,
                      )
                  ),
                ) : Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Color(0xff787cd1),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      image: DecorationImage(
                        image: FileImage(home.profileImage),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
//                    : Container(
//                  width: 150,
//                  height: 150,
//                  decoration: BoxDecoration(
//                    color: Color(0xff787cd1),
//                    borderRadius: BorderRadius.all(Radius.circular(100)),
//                    image: DecorationImage(
//                      image: NetworkImage(globals.urlSignUp+profile.profilePicImage),
//                      fit: BoxFit.cover,
//                    )
//                  ),
//                ),
                GestureDetector(
                  onTap: (){
                    print(profile.profilePicImage);
                    print(home.profileImage);
                    showGeneralDialog(
                      barrierLabel: "Label",
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionDuration: Duration(milliseconds: 400),
                      context: context,
                      pageBuilder: (context, anim1, anim2) {
                        return Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 195,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      //Navigator.of(context).pop();
//                          setState(() {
//                            showImages = true;
//                          });
                                      getImageOneGallery().then((value){

                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: 44,
                                            height: 44,
                                            child: Image.asset("assets/images/photo.png")),
                                        SizedBox(height: 8.97,),
                                        Text("Gallery",
                                          style: GoogleFonts.nunitoSans(
                                            textStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 44,
                                          height: 44,
                                          child: Image.asset("assets/images/folder.png")),
                                      SizedBox(height: 8.97,),
                                      Text("File Manager",
                                        style: GoogleFonts.nunitoSans(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xff707070),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      transitionBuilder: (context, anim1, anim2, child) {
                        return SlideTransition(
                          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
                          child: child,
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 100, top: 112),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        border: Border.all(color: Color(0xff707070))
                      ),
                      child: Icon(Icons.edit, color: Color(0xff707070),),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildForm(BuildContext context){
    return Form(
      key: home.formKeyProfile,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80,),
            Theme(
              data: ThemeData(primaryColor: Color(0xff302b6f)),
              child: Stack(
                children: [
                  TextFormField(
                    focusNode: focusName,
                    controller: home.profileNameController,
                    validator: (val){
                      if(val.isEmpty){
                        return 'Name cannot be empty';
                      }
                      return null;
                    },
                    onEditingComplete: (){
                      focusName.unfocus();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 17.0, right: 5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (){
                          focusName.requestFocus();
                        },
                        child: Icon(Icons.edit,
                          color: Colors.grey.shade400,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35,),
            Theme(
              data: ThemeData(primaryColor: Color(0xff302b6f)),
              child: Stack(
                children: [
                  TextFormField(
                    focusNode: focusEmail,
                    controller: home.profileEmailController,
                    validator: (val) => !EmailValidator.validate(val, true)
                        ? 'Not a valid email'
                        : null,
                    onEditingComplete: (){
                      focusEmail.unfocus();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 17.0, right: 5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (){
                          focusEmail.requestFocus();
                        },
                        child: Icon(Icons.edit,
                          color: Colors.grey.shade400,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35,),
            /*
            Theme(
              data: ThemeData(primaryColor: Color(0xff302b6f)),
              child: Stack(
                children: [
                  TextFormField(
                    controller: home.profilePasswordController,
                    decoration: InputDecoration(
                      hintText: "Change  Password",
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
                  Padding(
                    padding: const EdgeInsets.only(top: 17.0, right: 5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (){},
                        child: Icon(Icons.edit,
                          color: Colors.grey.shade400,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35,),

             */
            Theme(
              data: ThemeData(primaryColor: Color(0xff302b6f)),
              child: Stack(
                children: [
                  TextFormField(
                    focusNode: focusMobileNo,
                    controller: home.profileMobileNumberController,
                    validator: (val){
                      if(val.isEmpty){
                        return 'Contact cannot be empty';
                      }
                      return null;
                    },
                    onEditingComplete: (){
                      focusMobileNo.unfocus();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 17.0, right: 5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (){
                          focusMobileNo.requestFocus();
                        },
                        child: Icon(Icons.edit,
                          color: Colors.grey.shade400,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40,),
            InkWell(
              onTap: (){
                showAlertDialogLogout(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(home.logout,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 17,
                        )
                    ),
                  ),
                  Divider(thickness: 0.7,color: Colors.grey.shade600,),
                ],
              ),
            ),
            SizedBox(height: 35,),
          ],
        ),
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //if(home.formKeyProfile.currentState.validate()){
          home.prEditProfile.show();
          editProfileApiProvider.editProfile(context);
        //}
      },
      child: Center(
        child: Container(
          height: 50,
          width: MediaQuery
              .of(context)
              .size
              .width / 2.0,
          decoration: BoxDecoration(
              color: Color(0xff7579cb),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          child: Center(
            child: Text("Save",
              style: TextStyle(
                  color: Colors.white, letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialogLogout(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        Navigator.of(context).pop();
        Future.delayed(const Duration(seconds: 1), () {
          main();
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => InitialScreen(),
              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 300),
            ),
          );
        });
        Fluttertoast.showToast(msg: "Logged out", backgroundColor: Colors.black,
          textColor: Colors.white,);
        Future.delayed(const Duration(seconds: 3), () {
          logoutApiProvider.Logout(context);
        });
      },

    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure you want to logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
