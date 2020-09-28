import 'dart:convert';

import 'package:aaishani_store_user_app/dbClient/operations_profile.dart';
import 'package:aaishani_store_user_app/models/profileDataModel.dart';
import 'package:aaishani_store_user_app/utilities/utils.dart';
import 'package:aaishani_store_user_app/views/OrderHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Login.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final storage = FlutterSecureStorage();
  OperationsProfile operationsProfile = OperationsProfile();
  ProfileData profileData;
  ProfileData profileData2;
  List addresses = [];
  List<String> choices = ['Logout'];
  List<String> addressChoise = ['Edit','Delete'];
  var isLoading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    getProfileData();

  /*  if(storage.read(key: "token")==null)
      {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => OrderHistory(),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 800),
          ),
        );
      }
    else {
      getProfileData();
    }*/
  }

  getToken()async{
    print("token "+ await storage.read(key:'token').toString());
    if( await storage.read(key: "token")==null)
    {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => Login(),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 800),
        ),
      );
    }
  }

  getProfileData() async {
    profileData2 = await operationsProfile.getProfileData();
    setState(() {
      profileData = profileData2;
      addresses = json.decode(profileData.addresses);
      print("aadresses: "+addresses.toString());
      isLoading = false;
    });
    print("profileData " + profileData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Scaffold(
          body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          )),
        )
        :Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xFF85CE16),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          title: Text(
            "My Profile",
            style: TextStyle(
                fontFamily: "Gothic", color: Colors.white, fontSize: 18.0),
          ),
        ),
        body:
        Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/bgreg.png"),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter)),
                  ),
                  Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Card(
                            elevation: 3.0,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0, left: 20.0, bottom: 20.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      profileData.name == null
                                                          ? ""
                                                          : profileData.name
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontFamily: "Gothicb",
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: 16.0)),
                                                  SizedBox(height: 10.0),
                                                  Text(
                                                      profileData.contact ==
                                                              null
                                                          ? ""
                                                          : profileData.contact
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontFamily: "Gothic",
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: 12.0)),
                                                  Text(
                                                      profileData.email == null
                                                          ? ""
                                                          : profileData.email
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontFamily: "Gothic",
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: 12.0)),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.10,
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: FaIcon(
                                                  FontAwesomeIcons.pencilAlt,
                                                  color: Colors.grey[600],
                                                  size: 20.0,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Row(children: [
                            Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "Addresses",
                                  style: TextStyle(
                                      fontFamily: "Gothicb",
                                      fontSize: 16.0,
                                      color: Colors.white),
                                ))
                          ]),
                          SizedBox(height: 5.0),
                          addresses.length==0?Container(
                            height: MediaQuery.of(context).size.height * 0.18,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.red,
                          )
                              :Container(
                            height: MediaQuery.of(context).size.height * 0.18,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: addresses.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    elevation: 3.0,
                                    color: Colors.white,
                                    child: Container(
                                      margin: EdgeInsets.all(10.0),
                                      width: 230.0,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    addresses[index]
                                                            ['addressType']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: "Gothicb",
                                                        color:
                                                            Colors.grey[800]),
                                                  ),
                                                  PopupMenuButton<String>(
                                                    onSelected: (String value) async {
                                                    },
                                                    color: Colors.white,
                                                    icon: Icon(
                                                      Icons.more_vert,
                                                    ),
                                                    itemBuilder: (BuildContext context) {
                                                      return addressChoise.map((String addressChoise) {
                                                        return PopupMenuItem<String>(
                                                          value: addressChoise,
                                                          child: Text(addressChoise),
                                                        );
                                                      }).toList();
                                                    },
                                                  )
                                                ]),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            Expanded(
                                                child: Column(
                                              children: [
                                                Container(
                                                  height: 50.0,
                                                  child: ListView(
                                                      shrinkWrap: true,
                                                      children: [
                                                        Text(
                                                          addresses[index]
                                                                  ['address']
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Gothic",
                                                              color: Colors
                                                                  .grey[600]),
                                                        ),
                                                      ]),
                                                ),
                                              ],
                                            )),
                                          ]),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Card(
                            color: Colors.white,
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.07,
                              child: ListTile(
                                leading: FaIcon(FontAwesomeIcons.key,color:Colors.grey[500]),
                                title: Text("Change Password",style: TextStyle(fontFamily: "Gothicb",color: Colors.grey[700]),),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => OrderHistory(),
                                  transitionsBuilder: (c, anim, a2, child) =>
                                      FadeTransition(opacity: anim, child: child),
                                  transitionDuration: Duration(milliseconds: 800),
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.07,
                                child: ListTile(
                                  leading: FaIcon(FontAwesomeIcons.history,color:Colors.grey[500]),
                                  title: Text("Order History",style: TextStyle(fontFamily: "Gothicb",color: Colors.grey[700]),),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          GestureDetector(
                            onTap: () async {
                              operationsProfile.deleteProfileData();
                                await storage.delete(key: "token");
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) => Login(),
                                    transitionsBuilder: (c, anim, a2, child) =>
                                        FadeTransition(opacity: anim, child: child),
                                    transitionDuration: Duration(milliseconds: 800),
                                  ),
                                );
                            },
                            child: Card(
                              color: Colors.white,
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.07,
                                child: ListTile(
                                  leading: FaIcon(FontAwesomeIcons.signOutAlt,color:Colors.red),
                                  title: Text("Log out",style: TextStyle(fontFamily: "Gothicb",color: Colors.red),),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ));
  }
}
