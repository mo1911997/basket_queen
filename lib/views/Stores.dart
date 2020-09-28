import 'package:aaishani_store_user_app/dbClient/OperationsUserAndStoreData.dart';
import 'package:aaishani_store_user_app/models/Model_UserData.dart';
import 'package:aaishani_store_user_app/models/destination_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'destination_screen.dart';

class Stores extends StatefulWidget {
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  OperationsUserAndStoreData operationsUserAndStoreData =
      OperationsUserAndStoreData();

  List listStoreData = [];
  List listStoreData2 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStoresData();
  }

  getStoresData() async {
    listStoreData2 = await operationsUserAndStoreData.getStoreData();
    setState(() {
      listStoreData = listStoreData2;
    });
    print(listStoreData.length.toString());
    for(var i in listStoreData)
      {
        print("store image: "+i['thumbnail'].toString());
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF85CE16),
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFffbd5c),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Essentials",
            style: TextStyle(fontFamily: "Gothic", color: Colors.white),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bgreg.png"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter)),
          child: Column(
            children: [
              Container(
                height: 210.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: destinations.length,
                  itemBuilder: (BuildContext context, int index) {
                    Destination destination = destinations[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DestinationScreen(
                            destination: destination,
                          ),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        width: 310.0,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Hero(
                                    tag: destination.imageUrl,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image(
                                        height: 180.0,
                                        width: 300.0,
                                        image: AssetImage(destination.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.0,
                                    bottom: 10.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          destination.city,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.locationArrow,
                                              size: 10.0,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 5.0),
                                            Text(
                                              destination.country,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: listStoreData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 6.0)
                              ]),
                          child: Row(
                            children: [
                              Container(
                                width: 120.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(listStoreData[index]['thumbnail'].toString()),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        bottomLeft:
                                        Radius.circular(10.0)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 6.0)
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
