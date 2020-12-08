import 'dart:io';
import 'package:design_sprint/APIs/create_persona.dart';
import 'package:design_sprint/ReusableWidgets/profile_drawer_common.dart';
import 'package:design_sprint/ReusableWidgets/status_drawer_team.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Emphatize/EmpathizeScreens/emphatize_inside_sections_scree2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/hint_texts.dart' as hint;
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CreateDigitalPersona extends StatefulWidget {
  @override
  _CreateDigitalPersonaState createState() => _CreateDigitalPersonaState();
}

class _CreateDigitalPersonaState extends State<CreateDigitalPersona> {
  CreatePersonaApiProvider createPersonaApiProvider = CreatePersonaApiProvider();
  final picker = ImagePicker();
  Future getImageOne() async {
    Navigator.of(context).pop();
    var pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 25,);
    setState(() {
      empathize.imageOne = File(pickedFile.path);
    });
  }
  Future getImageOneGallery() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 25,);
    setState(() {
      empathize.imageOne = File(pickedFile.path);
    });
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
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              //width: 100,
                                child: Icon(Icons.camera_alt, color: Color(0xff7579cb),)),
                          ),
                          Container(
                              width: 150,
                              child: Text("Open using camera"))
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
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              //width: 100,
                                child: Icon(Icons.image, color: Color(0xff7579cb),)),
                          ),
                          Container(
                              width: 150,
                              child: Text("Open using gallery"))
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
  Widget build(BuildContext context) {
    empathize.prDigitalPersona = ProgressDialog(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: empathize.scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: empathize.statusDrawer == true ? StatusDrawerTeam() : ProfileDrawerCommon(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Form(
              key: empathize.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  buildName2Widget(context),
                  SizedBox(height: 43,),
                  buildEditDpWidget(context),
                  SizedBox(height: 40,),
                  buildNameField(context),
                  SizedBox(height: 20,),
                  buildAgeField(context),
                  SizedBox(height: 20,),
                  buildLocationField(context),
                  SizedBox(height: 20,),
                  buildEducationField(context),
                  SizedBox(height: 20,),
                  buildJobField(context),
                  SizedBox(height: 20,),
                  buildBioField(context),
                  SizedBox(height: 20,),
                  buildGoalsAndMotivationField(context),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      saveButton(context),
                      newPersonaButton(context),
                    ],
                  ),
                  SizedBox(height: 40,),
                  buildNextButton(context),
                  SizedBox(height: 40,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: statusBarDrawer(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context){

    Container line = Container(height:1,color: Colors.black,child: Divider());
    void _openEndDrawer() {
      setState(() {
        empathize.statusDrawer = false;
      });
      empathize.scaffoldKey.currentState.openEndDrawer();
    }

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(empathize.empathize,
          style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 35, top: 17),
        child: IconButton(
          onPressed: (){Navigator.of(context).pop();},
          icon: Icon(Icons.arrow_back_ios,size: 20, color: Colors.grey.shade700,),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 35, top: 20),
          child: IconButton(
            onPressed: _openEndDrawer,
            icon: Container(
              height: 50,
              width: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  line,
                  SizedBox(height: 6,),
                  line,
                  SizedBox(height: 6,),
                  Container(height:1,width:20, color: Colors.black,child: Divider()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProfileDrawer(BuildContext context){
    return Drawer(
      elevation: 20.0,
      child: Container(
        child: Drawer(
          elevation: 10,
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff302B70),
                        Color(0xff787CD1),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Icon(Icons.person, color: Colors.grey, size: 40,),
                      ),
                      SizedBox(width: 15,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hi, " + profile.name + "!",
                            style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                )
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(profile.email,
                            style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                )
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Icon(Icons.image, color: Colors.grey.shade500,),
                    SizedBox(width: 10,),
                    Text(home.sideBarHeadingHome,
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Icon(Icons.image, color: Colors.grey.shade500,),
                    SizedBox(width: 10,),
                    Text(home.sideBarHeadingDesignSprint,
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Icon(Icons.image, color: Colors.grey.shade500,),
                    SizedBox(width: 10,),
                    Text(home.sideBarHeadingTips,
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Icon(Icons.image, color: Colors.grey.shade500,),
                    SizedBox(width: 10,),
                    Text(home.sideBarHeadingManageTeam,
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Icon(Icons.image, color: Colors.grey.shade500,),
                    SizedBox(width: 10,),
                    Text(home.sideBarHeadingFAQs,
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Icon(Icons.image, color: Colors.grey.shade500,),
                    SizedBox(width: 10,),
                    Text(home.sideBarHeadingLegalPolicy,
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 42,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget statusBarDrawer(BuildContext context){
    void _openEndDrawer() {
      setState(() {
        empathize.statusDrawer = true;
      });
      empathize.scaffoldKey.currentState.openEndDrawer();
    }
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: _openEndDrawer,
        child: Container(
          height: 37,
          width: 37,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xffd4d4d4)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )
          ),
          child: Center(child: Text("<<",style: GoogleFonts.nunitoSans(textStyle: TextStyle(color: Color(0xff787CD1), fontSize: 18)),)),
        ),
      ),
    );
  }

  Widget buildStatusDrawer(BuildContext context){
    return Drawer(
      elevation: 20.0,
      child: Container(
        child: Drawer(
          elevation: 10,
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  color: Color(0xff787CD1),
                  child: Center(
                    child: Text("Sprint Name",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(color: Color(0xffd4d4d4),),
                    ),
                    SizedBox(width: 10,),
                    Text("Sprint Goal",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Color(0xffd4d4d4))
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(color: Color(0xffd4d4d4),),
                    ),
                    SizedBox(width: 10,),
                    Text("Empathize",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Color(0xffd4d4d4))
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(color: Color(0xffd4d4d4),),
                    ),
                    SizedBox(width: 10,),
                    Text("Ideation",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Color(0xffd4d4d4))
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(color: Color(0xffd4d4d4),),
                    ),
                    SizedBox(width: 10,),
                    Text("Prototype",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Color(0xffd4d4d4))
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(color: Color(0xffd4d4d4),),
                    ),
                    SizedBox(width: 10,),
                    Text("User Testing",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Color(0xffd4d4d4))
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(color: Color(0xffd4d4d4),),
                    ),
                    SizedBox(width: 10,),
                    Text("Re - Iterate",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 42,),
                Row(
                  children: [
                    SizedBox(width: 62,),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: Color(0xffd4d4d4))
                      ),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      height: 8,
                      width: 8,
                      child: Divider(color: Color(0xffd4d4d4),),
                    ),
                    SizedBox(width: 10,),
                    Text("Team",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          )
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildName2Widget(BuildContext context){

    return Center(
      child: Text(empathize.digitalPersona,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                color: Color(0xff707070),
                fontSize: 20,
                fontWeight: FontWeight.w200
            )
        ),
      ),
    );
  }

  Widget buildAddPhotoWidget(BuildContext context){
    return GestureDetector(
      onTap: (){
        _settingModalBottomSheetOne(context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.white,
              border: Border.all(color: Colors.grey)
            ),
            child: Icon(Icons.add, color: Colors.grey,),
          ),
          SizedBox(height: 10,),
          Text(empathize.addPhoto,
            style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                )
            ),
          )
        ],
      ),
    );
  }

  Widget buildEditDpWidget(BuildContext context){
    return empathize.imageOne == null ? InkWell(
      onTap: () => _settingModalBottomSheetOne(context),
      child: Container(
        height: 192,
        width: 192,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffd4d4d4)),
          borderRadius: BorderRadius.all(Radius.circular(7))
        ),
        child: Center(
          child: buildAddPhotoWidget(context),
        ),
      ),
    ) : Container(
      height: 192,
      width: 192,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffd4d4d4)),
          borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      child: Center(
        child: Image.file(empathize.imageOne, fit: BoxFit.cover,),
      ),
    );
  }

  Widget buildNameField(BuildContext context){
    return Container(
      width: 302,
        height: 47,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffd4d4d4)),
        borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35),
        child: TextFormField(
          controller: empathize.nameController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint.hintName
          ),
          validator: (val){
            if(val.isEmpty){
              return hint.validationName;
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildAgeField(BuildContext context){
    return Container(
      width: 302,
      height: 47,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffd4d4d4)),
          borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35),
        child: TextFormField(
          controller: empathize.ageController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint.hintAge
          ),
          validator: (val){
            if(val.isEmpty){
              return hint.ageValidation;
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildLocationField(BuildContext context){
    return Container(
      width: 302,
      height: 47,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffd4d4d4)),
          borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35),
        child: TextFormField(
          controller: empathize.locationController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint.hintLocation
          ),
          validator: (val){
            if(val.isEmpty){
              return hint.locationValidation;
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildEducationField(BuildContext context){
    return Container(
      width: 302,
      height: 47,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffd4d4d4)),
          borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35),
        child: TextFormField(
          controller: empathize.educationController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint.hintEducation
          ),
          validator: (val){
            if(val.isEmpty){
              return hint.educationValidation;
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildJobField(BuildContext context){
    return Container(
      width: 302,
      height: 47,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffd4d4d4)),
          borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35),
        child: TextFormField(
          controller: empathize.jobController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint.hintJob
          ),
          validator: (val){
            if(val.isEmpty){
              return hint.jobValidation;
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildBioField(BuildContext context){
    return Container(
      height: 148,
      width: 302,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffd4d4d4)),
          borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35),
        child: TextFormField(
          autofocus:false ,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          maxLines: 4,
          controller: empathize.bioController,
          decoration: InputDecoration(
            hintText: hint.hintBio,
            border: InputBorder.none,
          ),
          validator: (val){
            if(val.isEmpty){
              return hint.bioValidation;
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildGoalsAndMotivationField(BuildContext context){
    return Container(
      height: 148,
      width: 302,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffd4d4d4)),
          borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35),
        child: TextFormField(
          controller: empathize.goalsAndMotivationController,
          autofocus:false ,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: hint.hintGoalsAndMotivation,
            border: InputBorder.none,
          ),
          validator: (val){
            if(val.isEmpty){
              return hint.goalsAndMotivationValidation;
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget saveButton(BuildContext context){
    return InkWell(
      onTap: (){
        if(empathize.formKey.currentState.validate()){
          empathize.prDigitalPersona.show();
          createPersonaApiProvider.createDigitalPersona(context);
        }
      },
      child: Container(
        height: 35,
        width: 114,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffd4d4d4),
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Center(
          child: Text(empathize.saveButton,
            style: GoogleFonts.nunitoSans(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget newPersonaButton(BuildContext context){
    return Container(
      height: 35,
      width: 114,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffd4d4d4),
        ),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Center(
        child: Text(empathize.newPersonaButton,
          style: GoogleFonts.nunitoSans(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => EmphatizeInsideSections2(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
      child: Center(
        child: Container(
          height: 45,
          width: 146,
          decoration: BoxDecoration(
              color: Color(0xff7579cb),
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          child: Center(
            child: Text("Next",
              style: TextStyle(
                  color: Colors.white, letterSpacing: 1, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

}
