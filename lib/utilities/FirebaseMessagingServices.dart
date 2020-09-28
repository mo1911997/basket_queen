import 'dart:convert';

import 'package:aaishani_store_user_app/bloc/LoginBloc.dart';
import 'package:aaishani_store_user_app/models/ModelCommonResponse.dart';
import 'package:aaishani_store_user_app/views/Login.dart';
import 'package:aaishani_store_user_app/views/landingScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class FirebaseMessagingService extends StatefulWidget {

  @override
  _FirebaseMessagingServiceState createState() =>
      _FirebaseMessagingServiceState();
}

class _FirebaseMessagingServiceState extends State<FirebaseMessagingService> {
  String textValue = 'Hello World !', fcmToken;
  String url;
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    url = "https://limitless-oasis-41478.herokuapp.com/api/users/update_fcm_token";
    var android =
        new AndroidInitializationSettings('drawable/launch_background');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    print('inhere firebase init()');
    firebaseMessaging.configure(
      // ignore: missing_return
      onLaunch: (Map<String, dynamic> msg) {
        print(" onLaunch called ${(msg)}");
      },
      // ignore: missing_return
      onResume: (Map<String, dynamic> msg) {
        print(" onResume called ${(msg)}");
      },
      // ignore: missing_return
      onMessage: (Map<String, dynamic> msg) {
        showNotification(msg);
        print(" onMessage called ${(msg)}");
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('IOS Setting Registed');
    });
    firebaseMessaging.getToken().then((token) {
      fcmToken = token;
      getToken();
    });
  }

  showNotification(Map<String, dynamic> msg) async {
    var android = new AndroidNotificationDetails(
      'sdffds dsffds',
      "CHANNEL NAME",
      "channelDescription",
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, "This is title", "this is demo", platform);
  }

  getToken() async {
    loginBloc.token.value=fcmToken;
    ModelCommonResponse commonResponse=await loginBloc.updateFCM();

    if (commonResponse.state == 'success') {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => landingScreen(),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 800),
        ),
      );
    }

    // prefs=await SharedPreferences.getInstance();
    // prefs.setString("FCMToken", fcmToken);
  }

  // openDialog() {
  //   Dialog dialog = Dialog(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  //     child: Container(
  //       height: 100.0,
  //       width: 100.0,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           CircularProgressIndicator(
  //             backgroundColor: Colors.blue,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  //   showDialog(context: context, barrierDismissible: false, child: dialog);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
