import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeTip extends StatefulWidget {
  @override
  _HomeTipState createState() => _HomeTipState();
}

class _HomeTipState extends State<HomeTip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40,),
          buildNameWidget(context),
          SizedBox(height: 25,),
          buildDesignSprintCard(context),
          SizedBox(height: 25,),
          buildManageTeamCard(context),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context){

    Container line = Container(height:1,color: Colors.black,child: Divider());

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text("Home",
          style: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNameWidget(BuildContext context){

    Text hello = Text("Hello,",
      style: GoogleFonts.nunitoSans(
        textStyle: TextStyle(
          color: Color(0xff707070),
          fontSize: 40,
          fontWeight: FontWeight.w200
        )
      ),
    );
    Text name = Text(" Pratheek!",
      style: GoogleFonts.nunitoSans(
          textStyle: TextStyle(
            color: Color(0xff707070),
            fontSize: 40,
              fontWeight: FontWeight.w500
          )
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 35),
      child: Row(
        children: [
          hello,
          name,
        ],
      ),
    );
  }

  Widget buildDesignSprintCard(BuildContext context){
    return Container(
      width: 302,
      height: 286.22,
      decoration: BoxDecoration(
          color: Color(0xffF1A042),
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Stack(
        children: [
          Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 29, left: 35),
                child: Text("Design Sprint",
                  style: GoogleFonts.nunitoSans(
                    textStyle: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 35),
                child: Text("Start your first design sprint now",
                  style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      )
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.arrow_forward, color: Colors.white,size: 25,),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildManageTeamCard(BuildContext context){
    return Container(
      width: 302,
      height: 286.22,
      decoration: BoxDecoration(
          color: Color(0xff787CD1),
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Stack(
        children: [
          Image.asset("assets/images/circleDots.png",fit: BoxFit.cover,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 29, left: 35),
                child: Text("Manage Team",
                  style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 35),
                child: Text("Manage your team work process",
                  style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      )
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.arrow_forward, color: Colors.white,size: 25,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
