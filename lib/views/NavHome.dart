import 'dart:ui';

import 'package:aaishani_store_user_app/bloc/navHomeBloc.dart';
import 'package:aaishani_store_user_app/dbClient/OperationsCart.dart';
import 'package:aaishani_store_user_app/models/DataModel.dart';
import 'package:aaishani_store_user_app/models/destination_model.dart';
import 'package:aaishani_store_user_app/models/model_album.dart';
import 'package:aaishani_store_user_app/utilities/utils.dart';
import 'package:aaishani_store_user_app/views/ProductsListPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Cart.dart';
import 'destination_screen.dart';

class NavHome extends StatefulWidget {

  List aaishaniStores=[];

  NavHome(this.aaishaniStores);

  @override
  _NavHomeState createState() => _NavHomeState();
}

class _NavHomeState extends State<NavHome> {

  List<DataModel> dataList = List();
  List StoreCatogory = List();
  List<Model_Album> modelAlbumList = List();
  List<Model_Album> modelAlbumList2 = List();
  var searchClicked;
  final String title = "";
  final bool isActive = false;
  List _tabs = List();
  OperationsCart operationsCart = OperationsCart();
  var cartLength=0;

  //final Function press;

  @override
  void initState() {
    super.initState();
    setState(() {
      StoreCatogory=widget.aaishaniStores;
    });
    get_album_data();
    setState(() {
      searchClicked = false;
    });
    getCartLength();
  }

  getCartLength()async{
    var length = await operationsCart.getCartData();
    print("Cartlength: "+length.length.toString());
    setState(() {
      cartLength= length.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchClicked == true
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              /*leading: IconButton(
                icon: SvgPicture.asset("assets/images/menu_ham.svg"),
                onPressed: () {},
              ),*/
              title: ListTile(
                title: TextFormField(
                  onChanged: (text) {},
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[800])
                    ),
                    labelText: "Search here",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      searchClicked = false;
                    });
                  },
                ),
              ),
            )
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                icon: SvgPicture.asset("assets/images/menu_ham.svg"),
                onPressed: () {},
              ),
              title: Center(
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: "Ala",
                          style: TextStyle(color: Color(0xFF85CE16))),
                      TextSpan(
                          text: "Cart",
                          style: TextStyle(color: Color(0xFFffbd5c))),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey[500],
                  ),
                  onPressed: () {
                    setState(() {
                      searchClicked = true;
                    });
                  },
                ),
              ],
            ),
      body: StoreCatogory.length==0? Scaffold(body: Center(child:CircularProgressIndicator(backgroundColor: Colors.red,))): Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              height: 300.0,
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
                          Positioned(
                            bottom: 15.0,
                            child: Container(
                              height: 120.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${destination.activities.length} activities',
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    Text(
                                      destination.description,
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
            SizedBox(height: 10.0),
            Container(
              child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: StoreCatogory[0]['categories'].length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: (){
                          print("C2000: CatIndex  "+StoreCatogory[0]['categories'][index].toString());
                          print("C2000: _id  "+StoreCatogory[0]['_id'].toString());
                          print("C2000: name  "+StoreCatogory[0]['name'].toString());
                          print("C2000: name  "+index.toString());
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (c, a1, a2) => ProductsListPage(StoreCatogory[0]['categories'][index],StoreCatogory[0]['_id'],StoreCatogory[0]['name'],index),
                              transitionsBuilder: (c, anim, a2, child) =>
                                  FadeTransition(opacity: anim, child: child),
                              transitionDuration: Duration(milliseconds: 800),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 3.0 ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(StoreCatogory[0]['categories'][index]['img_url']),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow:[
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0,2.0),
                                  blurRadius: 6.0
                                )
                              ]
                            ),
                            child: Column(
                              children: <Widget>[
                                Spacer(),
                                Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
                                  ),
                                  child: Center(
                                    child: Text(StoreCatogory[0]['categories'][index]['name'].toString(), style: TextStyle(fontSize: 16.0,color: Colors.white),)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) {
                    int totalCount = modelAlbumList.length - 4985;
                    return StaggeredTile.count(
                        index == totalCount - 1 && index.isEven ? 2 : 1, 1);
                  }),
            )
          ]),
        ),
      ),
    );
  }

  get_album_data() async {
    modelAlbumList = await navHomeBloc.get_album_data();
    if(mounted){
      setState(() {
        modelAlbumList2 = modelAlbumList;
      });
    }
    print("modelAlbumList.length" + modelAlbumList.length.toString());
  }
}
