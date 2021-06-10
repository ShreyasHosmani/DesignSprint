import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/manage_team_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/view_sprints_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/LoginSignUp%20Screens/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Initial Screen/initial_screen.dart';
import 'utils/main_data.dart' as mainData;

var tempID;

final FirebaseMessaging messaging = FirebaseMessaging();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
final FirebaseMessaging fcm = FirebaseMessaging();
var userToken;

getStrings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  tempID = prefs.getString("userID"); //setString("userID", profile.userID);
  print(tempID);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //getStrings();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff302b70)
  ));
  runApp(MyApp());
  //initFCM();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFCM();
    //this.initDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/initial': (context) => InitialScreen(),
        '/trial': (context) => ManageTeam(),
        '/Login': (context) => Login(),
      },
      home: InitialScreen(),
    );
  }

  initFCM() async {

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    var android = new AndroidInitializationSettings('ic_stat_ic_launcher');
    var iOS = new IOSInitializationSettings();

    var initSettings = new InitializationSettings(android, iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);

    userToken = await messaging.getToken();
    print(userToken.toString());

    //sendToken(context);

    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        //showOnMessageNotification(message);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        print("onMessage.....: $message");

      },
      onLaunch: (Map<String, dynamic> message) async {
        showOnMessageNotification(message);
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        showOnMessageNotification(message);
        print("onResume: $message");
      },
    );
    fcm.requestNotificationPermissions(
        const IosNotificationSettings(
          sound: true,
          alert: true,
          badge: true,
        )
    );

    fcm.onIosSettingsRegistered.listen((IosNotificationSettings setting){
      print("ios settings registered");

    });
  }

  showOnMessageNotification(var message) async {

    //message = message['notification']['title'].toString() + "\n" + message['notification']['body'].toString();
    //title = message['notification']['title'].toString();

    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High,importance: Importance.Max
    );

    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        1, message['notification']['title'].toString(), message['notification']['body'].toString(), platform,
        payload: '');

//    showDialog<bool>(
//      context: context,
//      builder: (_) => AlertDialog(
//        content: Text(message['notification']['title'].toString()+"\n"+message['notification']['body'].toString()),
//        actions: <Widget>[
//          FlatButton(
//            child: const Text('CLOSE'),
//            onPressed: () {
//              Navigator.pop(context, false);
//            },
//          ),
//          FlatButton(
//            child: const Text('SHOW'),
//            onPressed: () {
//              Navigator.pop(context, true);
//            },
//          ),
//        ],
//      ),
//    );

  }

  Future onSelectNotification(String payload) {

    print("***** On select notification called *****");

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => ViewSprints(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }

}

// https://dezy.page.link/toViewSprints