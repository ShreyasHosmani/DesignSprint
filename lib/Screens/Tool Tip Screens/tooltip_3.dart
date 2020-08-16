
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/home_screen.dart';
import 'package:design_sprint/Screens/Tool%20Tip%20Screens/home_tool_tip2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToolTip3 extends StatefulWidget {
  @override
  _ToolTip3State createState() => _ToolTip3State();
}

class _ToolTip3State extends State<ToolTip3> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jumpScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HomeTip2(),
        buildTip1Container(context),
        buildManageTeamCard(context),
        buildToolTip1(context),
      ],
    );
  }

  Widget buildTip1Container(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black.withOpacity(0.80),
    );
  }

  Widget buildToolTip1(BuildContext context){

    TextStyle tipStyle = GoogleFonts.nunitoSans(
        textStyle: TextStyle(
            color: Colors.white,
            letterSpacing: 0.5,
            fontSize: 16
        )
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 280, right: 80),
            child: Align(
                alignment: Alignment.topRight,
                child: Stack(
                  children: [
                    Image.asset("assets/images/chat2.png", scale: 2,),
                    Padding(
                      padding: const EdgeInsets.only(top: 60, left: 25),
                      child: Column(
                        children: [
                          Text("It navigates to the team",style: tipStyle,),
                          Text("management section where you",style: tipStyle),
                          Text("can create team, add/delete",style: tipStyle),
                          Text("members.",style: tipStyle),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget buildManageTeamCard(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 470),
        child: Center(
          child: Container(
            width: 312,
            height: 296.22,
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
          ),
        ),
      ),
    );
  }

  void jumpScreen(BuildContext context){
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => Home(),
          transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 300),
        ),
      );
    });
  }

}
