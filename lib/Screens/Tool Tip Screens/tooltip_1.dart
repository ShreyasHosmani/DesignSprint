import 'package:design_sprint/Screens/Tool%20Tip%20Screens/home_tool_tip.dart';
import 'package:design_sprint/Screens/Tool%20Tip%20Screens/tooltip_2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToolTip1 extends StatefulWidget {
  @override
  _ToolTip1State createState() => _ToolTip1State();
}

class _ToolTip1State extends State<ToolTip1> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //jumpScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HomeTip(),
        buildTip1Container(context),
        buildToolTip1(context),
        buildHighlightIcon(context),
      ],
    );
  }

  Widget buildHighlightIcon(BuildContext context){

    Container line = Container(height:1,color: Colors.white,child: Divider());

    return Padding(
      padding: const EdgeInsets.only(right: 40, top: 50),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
            height: 50,
            width: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                line,
                SizedBox(height: 6,),
                line,
                SizedBox(height: 6,),
                Container(height:1,width:20, color: Colors.white,child: Divider()),
              ],
            ),
          ),
      ),
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
            padding: const EdgeInsets.only(top: 60, right: 40),
            child: Align(
                alignment: Alignment.topRight,
                child: Stack(
                  children: [
                    Image.asset("assets/images/chat.png", scale: 2,),
                    Padding(
                      padding: const EdgeInsets.only(top: 110, left: 45),
                      child: Column(
                        children: [
                          Text("Menu Bar - It helps in",style: tipStyle,),
                          Text("quick navigation to profile,",style: tipStyle),
                          Text("design sprint, tips, team",style: tipStyle),
                          Text("management.",style: tipStyle),
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

  void jumpScreen(BuildContext context){
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => ToolTip2(),
          transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 300),
        ),
      );
    });
  }

}
