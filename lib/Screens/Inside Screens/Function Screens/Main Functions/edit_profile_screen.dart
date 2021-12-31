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
//import 'package:image_cropper/image_cropper.dart';

bool imagePicked = false;
var focusName = FocusNode();
var focusEmail = FocusNode();
var focusMobileNo = FocusNode();
bool saveButton = false;

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  EditProfileApiProvider editProfileApiProvider = EditProfileApiProvider();
  LogoutApiProvider logoutApiProvider = LogoutApiProvider();
  final picker = ImagePicker();

  /*
  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: home.profileImage.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
        home.profileImage = croppedFile;
      });
    }
  }

   */

  Future getImageOne() async {
    Navigator.of(context).pop();
    var pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 25,);
    setState(() {
      home.profileImage = File(pickedFile.path);
      imagePicked = true;
      saveButton = true;
    });
    //_cropImage();
    print(imagePicked);
  }
  Future getImageOneGallery() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 25,);
    setState(() {
      home.profileImage = File(pickedFile.path);
      imagePicked = true;
      saveButton = true;
    });
    //_cropImage();
    print(imagePicked);
  }

  void _settingModalBottomSheetOne(context){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc){
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: InkWell(
                      onTap: (){
                        getImageOne();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              //width: 100,
                                child: Icon(Icons.camera_alt, color: Color(0xff7579cb),)),
                          ),
                          Container(
                              width: 150,
                              child: Text("Open using camera",
                                style: GoogleFonts.nunitoSans(
                                    letterSpacing: 0.5
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: InkWell(
                      onTap: (){
                        getImageOneGallery();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              //width: 100,
                                child: Icon(Icons.image, color: Color(0xff7579cb),)),
                          ),
                          Container(
                              width: 150,
                              child: Text("Open using gallery",
                                style: GoogleFonts.nunitoSans(
                                    letterSpacing: 0.5
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
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
    saveButton = false;
    home.profileBaseImage = null;
    home.profileFileName = null;
    home.profileNameController = TextEditingController(text: profile.name);
    home.profileEmailController = TextEditingController(text: profile.email);
    if(profile.mobileNo == null || profile.mobileNo == "null"){

    }else{
      home.profileMobileNumberController = TextEditingController(text: profile.mobileNo);
    }
  }
  @override
  Widget build(BuildContext context) {
    home.prEditProfile = ProgressDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: buildAppBar(context),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Container(
            height: 50,
            child: buildNextButton(context)),
      ),
      body: GestureDetector(
        onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildProfilePictureStack(context),
              buildForm(context),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context){

    Container line = Container(height:1,color: Colors.black,child: Divider());

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Text("Profile",
          style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 15, top: 0),
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
        Positioned(
          top: -30,left: 0, right: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            //height: 130,
            child: Image.asset("assets/images/ep_banner.png", fit: BoxFit.fitWidth,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Center(
            child: Stack(
              children: [
                profile.profilePicImage.toString().substring(0,2) == ".." && imagePicked == false ? InkWell(
                  onTap: (){
                    print(profile.profilePicImage);
                    print(home.profileImage);
                    _settingModalBottomSheetOne(context);
                  },
                  child: Container(
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
                  ),
                ) : home.profileImage == null ? InkWell(
                  onTap: (){
                    print(profile.profilePicImage);
                    print(home.profileImage);
                    _settingModalBottomSheetOne(context);
                  },
                  child: Container(
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
                      child: Icon(Icons.person, color: Colors.white, size: 50,),
                    ),
                   ),
                ) : imagePicked == true ? InkWell(
                  onTap: (){
                    print(profile.profilePicImage);
                    print(home.profileImage);
                    _settingModalBottomSheetOne(context);
                  },
                  child: Container(
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
                ) : InkWell(
                  onTap: (){
                    print(profile.profilePicImage);
                    print(home.profileImage);
                    _settingModalBottomSheetOne(context);
                  },
                  child: Container(
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
        buildAppBar(context),
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
            SizedBox(height: 40,),
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
                    onChanged: (val){
                      setState(() {
                        saveButton = true;
                      });
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
                    onChanged: (val){
                      setState(() {
                        saveButton = true;
                      });
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
            Theme(
              data: ThemeData(primaryColor: Color(0xff302b6f)),
              child: Stack(
                children: [
                  TextFormField(
                    focusNode: focusMobileNo,
                    controller: home.profileMobileNumberController,
                    decoration: InputDecoration(
                      hintText: profile.mobileNo == null || profile.mobileNo == "null" ? 'Contact no.' : '',
                    ),
                    validator: (val){
                      if((val.length < 10 || val.length  > 10)&&val.length > 1){
                        return 'Contact no. must be 10 digits';
                      }
                      return null;
                    },
                    onEditingComplete: (){
                      focusMobileNo.unfocus();
                    },
                    onChanged: (val){
                      setState(() {
                        saveButton = true;
                      });
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
            SizedBox(height: 35,),
          ],
        ),
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return saveButton == true ? GestureDetector(
      onTap: (){
        if(home.formKeyProfile.currentState.validate()){
          home.prEditProfile.show();
          editProfileApiProvider.editProfile(context);
        }
      },
      child: Center(
        child: Container(
          height: 50,
          width: MediaQuery
              .of(context)
              .size
              .width / 3.0,
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
    ) : GestureDetector(
      onTap: (){

      },
      child: Center(
        child: Container(
          height: 50,
          width: MediaQuery
              .of(context)
              .size
              .width / 3.0,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          child: Center(
            child: Text("Save",
              style: TextStyle(
                  color: Colors.black, letterSpacing: 1, fontSize: 16),
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
