import 'package:flutter/material.dart';
import 'package:design_sprint/utils/home_screen_data.dart' as home;
import 'package:design_sprint/utils/empathize_data.dart' as empathize;
import 'package:design_sprint/utils/profile_data.dart' as profile;
import 'package:google_fonts/google_fonts.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ViewSinglePersonaDetails extends StatefulWidget {
  final name;
  final image;
  final age;
  final location;
  final education;
  final job;
  final bio;
  final goals;
  ViewSinglePersonaDetails(this.name, this.image, this.age, this.location, this.education, this.job, this.bio, this.goals) : super();
  @override
  _ViewSinglePersonaDetailsState createState() => _ViewSinglePersonaDetailsState();
}

class _ViewSinglePersonaDetailsState extends State<ViewSinglePersonaDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.name);
    print(widget.image);
    print(widget.age);
    print(widget.location);
    print(widget.education);
    print(widget.job);
    print(widget.bio);
    print(widget.goals);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      endDrawerEnableOpenDragGesture: true,
      endDrawer: buildProfileDrawer(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25,),
            buildName2Widget(context),
            SizedBox(height: 43,),
            buildProfileImageCard(context),
            SizedBox(height: 50,),
            buildDetailsColumn(context),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context){

    Container line = Container(height:1,color: Colors.black,child: Divider());
    void _openEndDrawer() {
      _scaffoldKey.currentState.openEndDrawer();
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

  Widget buildBottomNavigationBar(BuildContext context){
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 2,
        color: Color(0xffE5E5E5),
        child: Center(
          child: Text("Comments",
            style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )
            ),
          ),
        ),
      ),
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

  Widget buildName2Widget(BuildContext context){

    return Center(
      child: Text(empathize.digitalPersona,
        style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w200
            )
        ),
      ),
    );
  }

  Widget buildProfileImageCard(BuildContext context){
    return Center(child: Container(
      width: 192,
      height: 192,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        image: DecorationImage(
          image: NetworkImage(widget.image),
        ),
      ),
    ));
  }

  Widget buildDetailsColumn(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildNameField(context),
          SizedBox(height: 25,),
          buildAgeField(context),
          SizedBox(height: 25,),
          buildLocationField(context),
          SizedBox(height: 25,),
          buildEducationField(context),
          SizedBox(height: 25,),
          buildJobField(context),
          SizedBox(height: 25,),
          buildBioField(context),
          SizedBox(height: 25,),
          buildGoalsField(context),
          SizedBox(height: 25,),
        ],
      ),
    );
  }

  Widget buildNameField(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name  :  ",
          style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )
          ),
        ),
        Text(widget.name,
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w200,
                color: Colors.black,
              )
          ),
        ),
      ],
    );
  }

  Widget buildAgeField(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Age  :  ",
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
          ),
        ),
        Text(widget.age,
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w200,
                color: Colors.black,
              )
          ),
        ),
      ],
    );
  }

  Widget buildLocationField(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Location  :  ",
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
          ),
        ),
        Text(widget.location,
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w200,
                color: Colors.black,
              )
          ),
        ),
      ],
    );
  }

  Widget buildEducationField(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Education  :  ",
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
          ),
        ),
        Text(widget.education,
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w200,
                color: Colors.black,
              )
          ),
        ),
      ],
    );
  }

  Widget buildJobField(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Job  :  ",
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
          ),
        ),
        Text(widget.job,
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w200,
                color: Colors.black,
              )
          ),
        ),
      ],
    );
  }

  Widget buildBioField(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Bio  :  \n",
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
          ),
        ),
        Text(widget.bio,
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w200,
                color: Colors.black,
              )
          ),
        ),
      ],
    );
  }

  Widget buildGoalsField(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Goals and Motivation  :  \n",
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
          ),
        ),
        Text(widget.goals,
          style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w200,
                color: Colors.black,
              )
          ),
        ),
      ],
    );
  }

}
