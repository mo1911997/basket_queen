import 'dart:convert';

import 'package:aaishani_store_user_app/NetworkProvider/ApiProvider.dart';
import 'package:aaishani_store_user_app/dbClient/OperationsUserAndStoreData.dart';
import 'package:aaishani_store_user_app/models/Model_UserData.dart';
import 'package:aaishani_store_user_app/views/NavHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';

import 'Cart.dart';
import 'MyProfile.dart';
import 'Services.dart';
import 'Stores.dart';

class landingScreen extends StatefulWidget {
  @override
  _landingScreenState createState() => _landingScreenState();
}

class _landingScreenState extends State<landingScreen> {

  ModelUserData modelUserData;


  List aaishaniStores;

  OperationsUserAndStoreData operationsUserAndStoreData =OperationsUserAndStoreData();
  ApiProvider apiProvider =ApiProvider();

  int _currentIndex = 0;
  PageController _myPage = PageController(initialPage: 0);
  bool connected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aaishaniStores = []; // this was the issue
    getAaishaniStore();
  }
  void getAaishaniStore() async {

    int count = await operationsUserAndStoreData.getUserData();
    if(count ==0)
    {

      modelUserData= await apiProvider.getUserData();
      print("LandingScreen Model User Data: "+ modelUserData.aaishaniStores.toString());
      operationsUserAndStoreData.insertUserData(modelUserData);
      String as;
      as = await operationsUserAndStoreData.getAaishaniStoreData();
      setState(() {
        aaishaniStores = jsonDecode(as);
      });
    }
    else
    {
      String as;
      as = await operationsUserAndStoreData.getAaishaniStoreData();
      setState(() {
        aaishaniStores = jsonDecode(as);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return aaishaniStores.length==0? Scaffold(body: Center(child: CircularProgressIndicator(backgroundColor: Colors.blue,),)) :WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        bottomNavigationBar:  BottomNavigationBar(
          currentIndex: _currentIndex ,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF85CE16),
          //iconSize: 30.0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home',style: TextStyle(fontFamily: "Gothicb")),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store,color: Colors.grey[500],),
              title: Text('Stores',style: TextStyle(fontFamily: "Gothicb"),),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              title: Text('Services',style: TextStyle(fontFamily: "Gothicb")),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile',style: TextStyle(fontFamily: "Gothicb")),
            ),
          ],
          onTap: (index){
            setState(() {
              _currentIndex=index;
              _myPage.jumpToPage(index);
            });
          },
        ),
        body: Builder(
          builder: (BuildContext context){
            return OfflineBuilder(
              connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child){
                connected = connectivity != ConnectivityResult.none;
                return Stack(
                  children: [
                    child,
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      bottom: 0.0,
                      height: 32.0,
                      child: connected?Container():AnimatedContainer(
                        duration: const Duration(seconds: 3),
                        color: Color(0xFF5db3c1),//0xFFffbd5c
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "No internet connection.",
                              style: TextStyle(color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            SizedBox(
                              width: 12.0,
                              height: 12.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor:
                                AlwaysStoppedAnimation<Color>(
                                  Color(0xFFffbd5c),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              child: PageView(
                controller: _myPage,
                onPageChanged: (int) {
                  print('Page Changes to index $int');
                },
                children: <Widget>[
                  //LandingScreen(),
                  Container(
                    child: NavHome(aaishaniStores),
                  ),
                  Container(
                    child: Stores(),
                  ),
                  Container(
                      child: Services()
                  ),
                  Container(
                    child: MyProfile(),
                  )
                ],
                physics: NeverScrollableScrollPhysics(),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text("Do you really want to exit the app?"),
          actions: <Widget>[
            FlatButton(
              child: Text("No"),
              onPressed: ()=>Navigator.pop(context,false),
            ),
            FlatButton(
              child: Text("Yes"),
              onPressed: ()=>Navigator.pop(context,true),
            )
          ],
        )
    );
  }



}
