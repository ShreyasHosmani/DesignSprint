import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/home_screen.dart';
import 'package:design_sprint/Screens/Tool%20Tip%20Screens/home_tool_tip2.dart';
import 'package:design_sprint/Screens/Tool%20Tip%20Screens/tooltip_3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToolTip2 extends StatefulWidget {
  @override
  _ToolTip2State createState() => _ToolTip2State();
}

class _ToolTip2State extends State<ToolTip2> {

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
        buildDesignSprintCard(context),
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
            padding: const EdgeInsets.only(top: 460, right: 80),
            child: Align(
                alignment: Alignment.topRight,
                child: Stack(
                  children: [
                    Image.asset("assets/images/chat.png", scale: 2,),
                    Padding(
                      padding: const EdgeInsets.only(top: 110, left: 25),
                      child: Column(
                        children: [
                          Text("It navigates you to start new",style: tipStyle,),
                          Text("design sprint, to continue the",style: tipStyle),
                          Text("present sprint and to access old",style: tipStyle),
                          Text("sprints.",style: tipStyle),
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

  Widget buildDesignSprintCard(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 155),
        child: Center(
          child: Container(
            width: 312,
            height: 296.22,
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
          pageBuilder: (c, a1, a2) => ToolTip3(),
          transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 300),
        ),
      );
    });
  }

}
