import 'package:carousel_slider/carousel_slider.dart';
import 'package:design_sprint/Screens/Initial%20Screen/splash_one.dart';
import 'package:design_sprint/Screens/Initial%20Screen/splash_three.dart';
import 'package:design_sprint/Screens/Initial%20Screen/splash_two.dart';
import 'package:design_sprint/Screens/Inside%20Screens/LoginSignUp%20Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

bool showSkip = true;
int current = 0;
List<Widget> list = [
  SplashOne(),
  SplashTwo(),
  SplashThree(),
];

class SplashPageViewBuilder extends StatefulWidget {
  @override
  _SplashPageViewBuilderState createState() => _SplashPageViewBuilderState();
}

class _SplashPageViewBuilderState extends State<SplashPageViewBuilder> {

  List<Slide> slides = new List();
  void onDonePress() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showSkip = true;
    slides.add(
      new Slide(
        centerWidget: SplashOne(),
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      new Slide(
        centerWidget: SplashTwo(),
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      new Slide(
        centerWidget: SplashThree(),
        backgroundColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: CarouselSlider.builder(
                itemCount: 3,
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: MediaQuery.of(context).size.height,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
//                    autoPlay: false,
//                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 100),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          current = index;
                        });
                        if(index == 2){
                          setState(() {
                            showSkip = false;
                          });
                        }else if(index == 0 || index == 1){
                          setState(() {
                            showSkip = true;
                          });
                        }
                      }
                  ),
                itemBuilder: (BuildContext context, int itemIndex) =>
                    itemIndex == 0 ? SplashOne() : itemIndex == 1 ? SplashTwo() : SplashThree(),
              ),
//              IntroSlider(
//                isShowDoneBtn: false,
//                isShowSkipBtn: false,
//                slides: this.slides,
//                onDonePress: this.onDonePress,
//              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: list.map((url) {
                    int index = list.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: current == index
                            ? Color.fromRGBO(0, 0, 0, 0.9)
                            : Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            showSkip == false ? Container() : GestureDetector(
              onTap: (){
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => Login(),
                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                    transitionDuration: Duration(milliseconds: 300),
                  ),
                );
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, right: 36),
                  child: Text("SKIP",
                    style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                          color: Color(0xff302b6f),
                          fontSize: 17,
                          letterSpacing: 0
                      ),
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

}
