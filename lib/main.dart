import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/home_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/Function%20Screens/Main%20Functions/manage_team_screen.dart';
import 'package:design_sprint/Screens/Inside%20Screens/LoginSignUp%20Screens/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Screens/Initial Screen/initial_screen.dart';
import 'utils/main_data.dart' as mainData;

void main() {
  //SharedPreferences.setMockInitialValues({});
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
  initFCM();
}

class MyApp extends StatelessWidget {
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
}


initFCM() async {

  mainData.flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  var android = new AndroidInitializationSettings('app_icon');
  var iOS = new IOSInitializationSettings();

  var initSettings = new InitializationSettings(android, iOS);

  mainData.flutterLocalNotificationsPlugin.initialize(initSettings,
      onSelectNotification: onSelectNotification);

  mainData.userToken = await mainData.messaging.getToken();
  print(mainData.userToken.toString());

  //sendToken(context);

  mainData.fcm.configure(
    onMessage: (Map<String, dynamic> message) async {
      showOnMessageNotification(message);
      print("onMessage.....: $message");

    },
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    },
  );
  mainData.fcm.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        alert: true,
        badge: true,
      )
  );
  mainData.fcm.onIosSettingsRegistered.listen((IosNotificationSettings setting){
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
  await mainData.flutterLocalNotificationsPlugin.show(
      1, message['notification']['title'].toString(), message['notification']['body'].toString(), platform,
      payload: '');

}

Future onSelectNotification(String payload) {}