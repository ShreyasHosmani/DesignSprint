import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_sprint/utils/hint_texts.dart' as hint;
import 'package:design_sprint/utils/home_screen_data.dart' as home;

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
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
                Container(
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
                ),
                Padding(
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
                    controller: home.profileNameController,
                    decoration: InputDecoration(
                      hintText: "Shreyas  Hosmani",
                    ),
                    validator: (val){
                      if(val.isEmpty){
                        return 'Name cannot be empty';
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
            Theme(
              data: ThemeData(primaryColor: Color(0xff302b6f)),
              child: Stack(
                children: [
                  TextFormField(
                    controller: home.profileNameController,
                    decoration: InputDecoration(
                      hintText: "coolshreyas1996123@gmail.com",
                    ),
                    validator: (val) => !EmailValidator.validate(val, true)
                        ? 'Not a valid email'
                        : null,
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
            Theme(
              data: ThemeData(primaryColor: Color(0xff302b6f)),
              child: Stack(
                children: [
                  TextFormField(
                    controller: home.profileNameController,
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
            Theme(
              data: ThemeData(primaryColor: Color(0xff302b6f)),
              child: Stack(
                children: [
                  TextFormField(
                    controller: home.profileNameController,
                    decoration: InputDecoration(
                      hintText: "Mobile  Number",
                    ),
                    validator: (val){
                      if(val.isEmpty){
                        return 'Contact cannot be empty';
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
            TextFormField(
              decoration: InputDecoration(
                hintText: "Log  out",
              ),
            ),
            SizedBox(height: 35,),
          ],
        ),
      ),
    );
  }

}
