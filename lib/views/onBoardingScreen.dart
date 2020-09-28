
import 'package:aaishani_store_user_app/animations/FadeRoute.dart';
import 'package:aaishani_store_user_app/utilities/ShadowText.dart';
import 'package:aaishani_store_user_app/utilities/utils.dart';
import 'package:aaishani_store_user_app/views/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'NavHome.dart';
import 'landingScreen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _storage = FlutterSecureStorage();
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndecator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(microseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFFffbd5c) : Color(0xFF85ce16),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  void updateOnBoarding() async
  {
   //await _storage.write(key: "verified_user",value:"verified");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateOnBoarding();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bgonegreen.png"),
                  //image: AssetImage("assets/images/bgone.png"),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      //Navigator.push(context, FadeRoute(page: NavHome()));
                      Navigator.pushAndRemoveUntil(
                          context, FadeRoute(page: landingScreen()), ModalRoute.withName("/landingScreen"));
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.70,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[                            
                          Center(
                            child: Image(
                              image:
                                  AssetImage('assets/images/walktrough1green.png'),
                              height: 160.0,
                              width: 160.0,
                            ),
                          ),                            
                          Center(
                            child: Text(
                              'ORDER',
                              style: kTitleStyle,
                            ),
                          ),                            
                          Center(
                            child: Text(
                                'Order your daily needs,\nWe have everything you want...',
                                style: kSubtitleStyle,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[                          
                          Center(
                            child: Image(
                              image:
                                  AssetImage('assets/images/walktrough2green.png'),
                              height: 160.0,
                              width: 160.0,
                            ),
                          ),
                          
                          Center(
                            child: Text(
                              'PAY',
                              style: kTitleStyle,
                            ),
                          ),
                          
                          Center(
                            child: Text("Pay online\nWe promote digital India",
                                style: kSubtitleStyle),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[                          
                          Center(
                            child: Image(
                              image:
                                  AssetImage('assets/images/walktrough3green.png'),
                              height: 160.0,
                              width: 160.0,
                            ),
                          ),
                          
                          Center(
                            child: Text(
                              'Delivery',
                              style: kTitleStyle,
                            ),
                          ),
                          
                          Center(
                            child: Text(
                                "Just sit back and relax,\nWe are here to deliver at your door step",
                                style: kSubtitleStyle),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndecator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Color(0xFF85ce16), fontSize: 16.0),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFF85ce16),
                                  size: 26.0,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text('')
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? InkWell(
              onTap: () {
                print("onTaped");
                //Navigator.push(context, FadeRoute(page: NavHome()));
                Navigator.pushAndRemoveUntil(
                    context, FadeRoute(page: landingScreen()), ModalRoute.withName("/landingScreen"));
              },
              child: Container(
                height: 70.0,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Get started',
                    style: TextStyle(
                        color: Color(0xFFffbd5c),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
