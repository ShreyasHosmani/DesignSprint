import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/manage_team_screen.dart';
import 'package:flutter/material.dart';
import 'Screens/Initial Screen/initial_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/initial': (context) => InitialScreen(),
        '/trial': (context) => ManageTeam(),
      },
      home: InitialScreen(),
    );
  }
}


