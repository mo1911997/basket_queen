
import 'package:aaishani_store_user_app/views/Login.dart';
import 'package:aaishani_store_user_app/views/MyProfile.dart';
import 'package:aaishani_store_user_app/views/landingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'views/SplashScreen.dart';
import 'utilities/Preferences.dart';



void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider<Preferences>(
      create: (context)=>Preferences(),

      child: MaterialApp(
        theme: ThemeData(
        ),
        title: "AuthMarket",
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );

  }

}

