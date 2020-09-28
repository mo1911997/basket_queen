import 'dart:async';

import 'package:aaishani_store_user_app/NetworkProvider/ApiProvider.dart';
import 'package:aaishani_store_user_app/animations/FadeRoute.dart';
import 'package:aaishani_store_user_app/dbClient/OperationsUserAndStoreData.dart';
import 'package:aaishani_store_user_app/models/Model_UserData.dart';
import 'package:aaishani_store_user_app/views/landingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'NavHome.dart';
import 'onBoardingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _storage = FlutterSecureStorage();
  ApiProvider apiProvider =ApiProvider();
  OperationsUserAndStoreData operationsUserAndStoreData = OperationsUserAndStoreData();

  void navigationPage() async {

    String token = await _storage.read(key: "token");
    if (token == null) {
      print(_storage.read(key:'first_time'));
      if(await _storage.read(key:'first_time') != null)
        {
          ModelUserData modelUserData = await apiProvider.getUserData();
          print("ModelUserData Store: "+ modelUserData.storesWithCategoriesAndProducts.toString());
          operationsUserAndStoreData.updateUserData(modelUserData);
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
      else
        {
          await _storage.write(key: "first_time", value: "1");
          Navigator.pushAndRemoveUntil(context, FadeRoute(page: OnBoardingScreen()),
              ModalRoute.withName('/onBoardingScreen'));
        }

    } else {
      ModelUserData modelUserData = await apiProvider.getUserData();
      print("ModelUserData Store: "+ modelUserData.storesWithCategoriesAndProducts.toString());
      operationsUserAndStoreData.updateUserData(modelUserData);
      Navigator.pushAndRemoveUntil(
          context, FadeRoute(page: landingScreen()), ModalRoute.withName("/landingScreen"));
    }
  }

  startTimer() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bgsplashgreen.png"),
                //image: AssetImage("assets/images/bgsplash.png"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 50),
                    SizedBox(height: 50),
                    Image(
                      image: AssetImage("assets/images/logo.png"),
                      height: 200.0,
                      width: 200.0,
                    ),
                    Text('AlaCart',
                        style:
                        TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 38.0,
                            color: Colors.white
                        ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(),
                  child: SpinKitThreeBounce(
                    size: 20.0,
                    color: Color(0xFFffbd5c),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child:Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Developed by: ", style: TextStyle(color: Colors.blueGrey,)),
                        TextSpan(
                            text: "ArkinIndia",
                            style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,fontSize: 18.0)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
