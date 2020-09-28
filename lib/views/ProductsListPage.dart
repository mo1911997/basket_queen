import 'dart:convert';

import 'package:aaishani_store_user_app/dbClient/OperationsCart.dart';
import 'package:aaishani_store_user_app/dbClient/OperationsUserAndStoreData.dart';
import 'package:aaishani_store_user_app/views/Cart.dart';
import 'package:aaishani_store_user_app/views/ProductDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductsListPage extends StatefulWidget {
  var storeCategory;
  var storeid;
  var storeName;
  var catIndex;

  ProductsListPage(
      this.storeCategory, this.storeid, this.storeName, this.catIndex);

  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  var searchClicked;
  var selectedVariantValue;
  var selectedIndex;
  List categories = [];
  List selectedCategory = [];
  List productList = [];
  List listMRP = [];
  List listDP = [];
  List listQty = [];
  List<String> variantSelected = [];
  String encodedCategories;
  OperationsUserAndStoreData operationsUserAndStoreData =
      OperationsUserAndStoreData();
  OperationsCart operationsCart = OperationsCart();
  var price;
  var isLoading = true;
  var cartLength=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
        selectedIndex=0;
      });
    });

    print("widget.catIndex" + widget.catIndex.toString());
    for (int i = 0; i < widget.storeCategory['products'].length; i++) {
      listQty.add(0);
      variantSelected.add(
          widget.storeCategory['products'][i]['variants'][0]['description']);
      listMRP.add(widget.storeCategory['products'][i]['variants'][0]['mrp']);
      listDP.add(widget.storeCategory['products'][i]['variants'][0]
          ['discounted_price']);
    }
    getCategories();
  }

  void getCategories() async {
    encodedCategories = await operationsUserAndStoreData.getAaishaniStoreData();
    setState(() {
      categories = json.decode(encodedCategories);
    });
    for (var i in categories[0]['categories']) {
      selectedCategory.add(false);
    }
    for (int i = 0; i < selectedCategory.length; i++) {
      if (i == widget.catIndex) {
        setState(() {
          selectedCategory[i] = true;
        });
      }
    }
    print("categories Length : " + categories.length.toString());

    for (int i = 0; i < widget.storeCategory['products'].length; i++) {
      int val = await operationsCart.getVariantQty(
          widget.storeCategory['products'][i]['_id'],
          widget.storeCategory['products'][i]['variants'][0]['description']);
      setState(() {
        listQty[i] = val;
      });
    }
    getCartLength();
  }

  getCartLength()async{
    var length = await operationsCart.getCartData();
    setState(() {
      cartLength= length.length;
    });
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
            widget.storeName.toString(),
            style: TextStyle(fontFamily: "Gothic", color: Colors.white),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 5.0),
              child: Stack(
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Cart(selectedIndex)),
                      );
                      print("pop result: "+"$result");
                      try{
                        getCartLength();
                        refreshCartData(result ==null?0 :result);
                      }
                      catch(e){
                        getCartLength();
                        print("tryCatch error: "+e.toString());
                        refreshCartData(result ==null?0 :result);
                      }

                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: CircleAvatar(
                        radius: 10.0,
                        backgroundColor: Colors.red,
                        child: Text(
                          cartLength.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
        body: categories.length == 0
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/bgthreegreen.png"),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Column(
                    children: [
                      Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: categories[0]['categories'].length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: FilterChip(
                                selected: selectedCategory[index],
                                onSelected: (value) async {
                                  Future.delayed(
                                      const Duration(milliseconds: 1000), () {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });

                                  variantSelected.clear();
                                  listMRP.clear();
                                  listDP.clear();
                                  listQty = [];
                                  for (int i = 0;
                                      i < selectedCategory.length;
                                      i++) {
                                    if (i == index) {
                                      selectedCategory[index] = true;
                                      widget.storeCategory['products'] =
                                          categories[0]['categories'][index]
                                              ['products'];
                                      for (int i = 0;
                                          i <
                                              widget.storeCategory['products']
                                                  .length;
                                          i++) {
                                        listQty.add(0);
                                        variantSelected.add(
                                            widget.storeCategory['products'][i]
                                                ['variants'][0]['description']);
                                        listMRP.add(
                                            widget.storeCategory['products'][i]
                                                ['variants'][0]['mrp']);
                                        listDP.add(
                                            widget.storeCategory['products'][i]
                                                    ['variants'][0]
                                                ['discounted_price']);
                                        int val =
                                            await operationsCart.getVariantQty(
                                                widget.storeCategory['products']
                                                    [i]['_id'],
                                                widget.storeCategory['products']
                                                        [i]['variants'][0]
                                                    ['description']);
                                        print("val: " + val.toString());
                                        setState(() {
                                          listQty[i] = val;
                                        });
                                        print("listQty: I + val " +
                                            i.toString() +
                                            " : " +
                                            val.toString());
                                      }
                                    } else {
                                      selectedCategory[i] = false;
                                    }
                                  }
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                showCheckmark: true,
                                label: Text(categories[0]['categories'][index]
                                        ['name']
                                    .toString()),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      /*ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                          widget.storeCategory['products'].length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    */
                      /*Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ProductDetailPage()),
                                          );*/
                      /*
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                    elevation: 3.0,
                                    child: Container(
                                      color: Colors.transparent,
                                      height: 140.0,
                                      width:
                                      MediaQuery.of(context).size.width,
                                      child: Row(
                                        children: [
                                          Hero(
                                            tag:'productImage',
                                            child: Container(
                                              width: 120.0,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(widget
                                                        .storeCategory[
                                                    'products'][index]
                                                    ['images'][0]
                                                        .toString()),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(
                                                          10.0),
                                                      bottomLeft:
                                                      Radius.circular(
                                                          10.0)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black12,
                                                        offset:
                                                        Offset(0.0, 2.0),
                                                        blurRadius: 6.0)
                                                  ]),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      widget.storeCategory[
                                                      'products']
                                                      [index]['name'],
                                                      overflow:
                                                      TextOverflow.fade,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontFamily:
                                                          "Gothicb",
                                                          fontSize: 18.0,
                                                          color: Colors
                                                              .grey[700]),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(0.0),
                                                      child: widget
                                                          .storeCategory['products']
                                                      [index][
                                                      'variants']
                                                          .length ==
                                                          1
                                                          ? Text(widget.storeCategory[
                                                      'products']
                                                      [index]
                                                      ['variants'][0]
                                                      ['description'])
                                                          : DropdownButton<String>(
                                                        value:
                                                        variantSelected[
                                                        index],
                                                        style: TextStyle(
                                                            color: Colors
                                                                .deepPurple),
                                                        onChanged: (String
                                                        newValue) async {
                                                          int qty = await operationsCart.getVariantQty(
                                                              widget.storeCategory['products'][index]
                                                              [
                                                              '_id'],
                                                              newValue);
                                                          setState(
                                                                  () {
                                                                listQty[index] =
                                                                    qty;
                                                                variantSelected[
                                                                index] =
                                                                    newValue;
                                                                for (int i =
                                                                0;
                                                                i < widget.storeCategory['products'][index]['variants'].length;
                                                                i++) {
                                                                  if (newValue ==
                                                                      widget.storeCategory['products'][index]['variants'][i]['description']) {
                                                                    listMRP[index] =
                                                                    widget.storeCategory['products'][index]['variants'][i]['mrp'];
                                                                    listDP[index] =
                                                                    widget.storeCategory['products'][index]['variants'][i]['discounted_price'];
                                                                  }
                                                                }
                                                              });
                                                        },
                                                        items: widget
                                                            .storeCategory[
                                                        'products']
                                                        [
                                                        index]
                                                        [
                                                        'variants']
                                                            .map<DropdownMenuItem<String>>(
                                                                (var value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value[
                                                                'description'],
                                                                child:
                                                                Text(
                                                                  value['description']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      14.0),
                                                                ),
                                                              );
                                                            }).toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "MRP",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  "Gothicb",
                                                                  fontSize:
                                                                  12.0,
                                                                  color: Colors
                                                                      .grey[
                                                                  700]),
                                                            ),
                                                            SizedBox(
                                                              width: 5.0,
                                                            ),
                                                            Text(
                                                              "₹ " +
                                                                  listMRP[index]
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  "Gothicb",
                                                                  decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                                  fontSize:
                                                                  12.0,
                                                                  color: Colors
                                                                      .grey[
                                                                  700]),
                                                            ),
                                                            SizedBox(
                                                              width: 5.0,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Price",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  "Gothicb",
                                                                  fontSize:
                                                                  14.0,
                                                                  color: Colors
                                                                      .grey[
                                                                  800]),
                                                            ),
                                                            SizedBox(
                                                              width: 5.0,
                                                            ),
                                                            Text(
                                                              "₹ " +
                                                                  listDP[index]
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                  "Gothicb",
                                                                  fontSize:
                                                                  14.0,
                                                                  color: Colors
                                                                      .grey[
                                                                  800]),
                                                            ),
                                                            SizedBox(
                                                              width: 5.0,
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          "save ₹ " +
                                                              getAmt(
                                                                  listMRP[index]
                                                                      .toString(),
                                                                  listDP[index]
                                                                      .toString()),
                                                          style: TextStyle(
                                                              fontFamily:
                                                              "Gothic",
                                                              fontSize:
                                                              10.0,
                                                              color: Colors
                                                                  .grey[
                                                              700]),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 50.0,
                                                      width: 120.0,
                                                      color:
                                                      Color(0xFF85CE16),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {

                                                              setState(() {
                                                                listQty[index] =listQty[index] -1;
                                                                print("listQty[index] : "+listQty[index].toString());
                                                                if (listQty[index] <1)
                                                                {
                                                                  listQty[index]=0;
                                                                  operationsCart.deleteCartItemData(widget.storeCategory['products'][index]['_id'].toString(),variantSelected[index].toString());

                                                                }
                                                                else {
                                                                  print("listQty[index] in else : "+listQty[index].toString());
                                                                  operationsCart.updateCartData(listQty[index].toString(),widget.storeCategory['products'][index]['_id'].toString(),variantSelected[index].toString());
                                                                }
                                                                getCartLength();
                                                              });
                                                            },
                                                            child: Text(
                                                              "-",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  28.0,
                                                                  fontFamily:
                                                                  "Gothicb",
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          Text(
                                                              listQty[index]
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18.0,
                                                                  fontFamily:
                                                                  "Gothicb",
                                                                  color: Colors
                                                                      .white)),
                                                          InkWell(
                                                            onTap:
                                                                () async {
                                                              setState(() {
                                                                listQty[index] =
                                                                    listQty[index] +
                                                                        1;
                                                              });
                                                              int qty = await operationsCart.getVariantQty(
                                                                  widget.storeCategory['products']
                                                                  [
                                                                  index]
                                                                  [
                                                                  '_id'],
                                                                  variantSelected[
                                                                  index]);

                                                              if (qty ==0) {
                                                                operationsCart.insertCartData(
                                                                    widget
                                                                        .storeid
                                                                        .toString(),
                                                                    widget.storeCategory['products'][index]['_id']
                                                                        .toString(),
                                                                    widget.storeCategory['products'][index]['name']
                                                                        .toString(),
                                                                    variantSelected[index]
                                                                        .toString(),
                                                                    listDP[index]
                                                                        .toString(),
                                                                    getAmt(
                                                                        listMRP[index]
                                                                            .toString(),
                                                                        listDP[index]
                                                                            .toString()),
                                                                    listQty[index]
                                                                        .toString());
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                    "Added in cart",
                                                                    gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                    toastLength:
                                                                    Toast.LENGTH_SHORT);
                                                              } else {
                                                                operationsCart.updateCartData(
                                                                    listQty[index]
                                                                        .toString(),
                                                                    widget
                                                                        .storeCategory['products'][index][
                                                                    '_id']
                                                                        .toString(),
                                                                    variantSelected[index]
                                                                        .toString());
                                                              }
                                                              getCartLength();
                                                            },
                                                            child: Text("+",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    24.0,
                                                                    fontFamily:
                                                                    "Gothicb",
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                )
                              ],
                            );
                          }),
                      SizedBox(height: 10.0,),*/
                      Container(
                        child: isLoading == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.green,
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    widget.storeCategory['products'].length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          /*Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ProductDetailPage()),
                                          );*/
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 3.0,
                                          child: Container(
                                            color: Colors.transparent,
                                            height: 140.0,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            child: Row(
                                              children: [
                                                Hero(
                                                  tag:'productImage',
                                                  child: Container(
                                                    width: 120.0,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(widget
                                                              .storeCategory[
                                                                  'products'][index]
                                                                  ['images'][0]
                                                              .toString()),
                                                          fit: BoxFit.fill,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft:
                                                                    Radius.circular(
                                                                        10.0),
                                                                bottomLeft:
                                                                    Radius.circular(
                                                                        10.0)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.black12,
                                                              offset:
                                                                  Offset(0.0, 2.0),
                                                              blurRadius: 6.0)
                                                        ]),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            widget.storeCategory[
                                                                    'products']
                                                                [index]['name'],
                                                            overflow:
                                                                TextOverflow.fade,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Gothicb",
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .grey[700]),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            child: widget
                                                                        .storeCategory['products']
                                                                            [index][
                                                                            'variants']
                                                                        .length ==
                                                                    1
                                                                ? Text(widget.storeCategory[
                                                                                'products']
                                                                            [index]
                                                                        ['variants'][0]
                                                                    ['description'])
                                                                : DropdownButton<String>(
                                                                    value:
                                                                        variantSelected[
                                                                            index],
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .deepPurple),
                                                                    onChanged: (String
                                                                        newValue) async {
                                                                      int qty = await operationsCart.getVariantQty(
                                                                          widget.storeCategory['products'][index]
                                                                              [
                                                                              '_id'],
                                                                          newValue);
                                                                      setState(
                                                                          () {
                                                                        listQty[index] =
                                                                            qty;
                                                                        variantSelected[
                                                                                index] =
                                                                            newValue;
                                                                        for (int i =
                                                                                0;
                                                                            i < widget.storeCategory['products'][index]['variants'].length;
                                                                            i++) {
                                                                          if (newValue ==
                                                                              widget.storeCategory['products'][index]['variants'][i]['description']) {
                                                                            listMRP[index] =
                                                                                widget.storeCategory['products'][index]['variants'][i]['mrp'];
                                                                            listDP[index] =
                                                                                widget.storeCategory['products'][index]['variants'][i]['discounted_price'];
                                                                          }
                                                                        }
                                                                      });
                                                                    },
                                                                    items: widget
                                                                        .storeCategory[
                                                                            'products']
                                                                            [
                                                                            index]
                                                                            [
                                                                            'variants']
                                                                        .map<DropdownMenuItem<String>>(
                                                                            (var value) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        value: value[
                                                                            'description'],
                                                                        child:
                                                                            Text(
                                                                          value['description']
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  14.0),
                                                                        ),
                                                                      );
                                                                    }).toList(),
                                                                  ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "MRP",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Gothicb",
                                                                        fontSize:
                                                                            12.0,
                                                                        color: Colors
                                                                                .grey[
                                                                            700]),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.0,
                                                                  ),
                                                                  Text(
                                                                    "₹ " +
                                                                        listMRP[index]
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Gothicb",
                                                                        decoration:
                                                                            TextDecoration
                                                                                .lineThrough,
                                                                        fontSize:
                                                                            12.0,
                                                                        color: Colors
                                                                                .grey[
                                                                            700]),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Price",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Gothicb",
                                                                        fontSize:
                                                                            14.0,
                                                                        color: Colors
                                                                                .grey[
                                                                            800]),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.0,
                                                                  ),
                                                                  Text(
                                                                    "₹ " +
                                                                        listDP[index]
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Gothicb",
                                                                        fontSize:
                                                                            14.0,
                                                                        color: Colors
                                                                                .grey[
                                                                            800]),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                "save ₹ " +
                                                                    getAmt(
                                                                        listMRP[index]
                                                                            .toString(),
                                                                        listDP[index]
                                                                            .toString()),
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Gothic",
                                                                    fontSize:
                                                                        10.0,
                                                                    color: Colors
                                                                            .grey[
                                                                        700]),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            height: 50.0,
                                                            width: 120.0,
                                                            color:
                                                                Color(0xFF85CE16),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {

                                                                    setState(() {
                                                                      listQty[index] =listQty[index] -1;
                                                                      print("listQty[index] : "+listQty[index].toString());
                                                                      if (listQty[index] <1)
                                                                      {
                                                                        listQty[index]=0;
                                                                        operationsCart.deleteCartItemData(widget.storeCategory['products'][index]['_id'].toString(),variantSelected[index].toString());

                                                                      }
                                                                      else {
                                                                        print("listQty[index] in else : "+listQty[index].toString());
                                                                        operationsCart.updateCartData(listQty[index].toString(),widget.storeCategory['products'][index]['_id'].toString(),variantSelected[index].toString());
                                                                      }
                                                                      getCartLength();
                                                                    });
                                                                  },
                                                                  child: Text(
                                                                    "-",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            28.0,
                                                                        fontFamily:
                                                                            "Gothicb",
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                Text(
                                                                    listQty[index]
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18.0,
                                                                        fontFamily:
                                                                            "Gothicb",
                                                                        color: Colors
                                                                            .white)),
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    setState(() {
                                                                      listQty[index] =
                                                                          listQty[index] +
                                                                              1;
                                                                    });
                                                                    int qty = await operationsCart.getVariantQty(
                                                                        widget.storeCategory['products']
                                                                                [
                                                                                index]
                                                                            [
                                                                            '_id'],
                                                                        variantSelected[
                                                                            index]);

                                                                    if (qty ==0) {
                                                                      operationsCart.insertCartData(
                                                                          widget
                                                                              .storeid
                                                                              .toString(),
                                                                          widget.storeCategory['products'][index]['_id']
                                                                              .toString(),
                                                                          widget.storeCategory['products'][index]['name']
                                                                              .toString(),
                                                                          variantSelected[index]
                                                                              .toString(),
                                                                          listDP[index]
                                                                              .toString(),
                                                                          getAmt(
                                                                              listMRP[index]
                                                                                  .toString(),
                                                                              listDP[index]
                                                                                  .toString()),
                                                                          listQty[index]
                                                                              .toString());
                                                                      Fluttertoast.showToast(
                                                                          msg:
                                                                              "Added in cart",
                                                                          gravity:
                                                                              ToastGravity
                                                                                  .BOTTOM,
                                                                          toastLength:
                                                                              Toast.LENGTH_SHORT);
                                                                    } else {
                                                                      operationsCart.updateCartData(
                                                                          listQty[index]
                                                                              .toString(),
                                                                          widget
                                                                              .storeCategory['products'][index][
                                                                                  '_id']
                                                                              .toString(),
                                                                          variantSelected[index]
                                                                              .toString());
                                                                    }
                                                                    getCartLength();
                                                                  },
                                                                  child: Text("+",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              24.0,
                                                                          fontFamily:
                                                                              "Gothicb",
                                                                          color: Colors
                                                                              .white)),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      )
                                    ],
                                  );
                                }),
                      ),
                    ],
                  ),
                ),
              ));
  }

  String getAmt(String mrp, String dp) {
    price = double.parse(mrp) - double.parse(dp);
    return price.toString();
  }

  void refreshCartData(result) async {
          variantSelected.clear();
          listMRP.clear();
          listDP.clear();
          listQty = [];
          for (int i = 0; i < selectedCategory.length; i++) {
            if (i == result) {
              selectedCategory[result] = true;
              widget.storeCategory['products'] = categories[0]
              ['categories'][result]['products'];
              for (int i = 0;
              i < widget.storeCategory['products'].length;
              i++) {
                listQty.add(0);
                variantSelected.add(
                    widget.storeCategory['products'][i]
                    ['variants'][0]['description']);
                listMRP.add(widget.storeCategory['products'][i]
                ['variants'][0]['mrp']);
                listDP.add(widget.storeCategory['products'][i]
                ['variants'][0]['discounted_price']);
                int val = await operationsCart.getVariantQty(
                    widget.storeCategory['products'][i]['_id'],
                    widget.storeCategory['products'][i]
                    ['variants'][0]['description']);
                print("val: " + val.toString());
                setState(() {
                  listQty[i] = val;
                });
                print("listQty: I + val " +
                    i.toString() +
                    " : " +
                    val.toString());
              }
            } else {
              selectedCategory[i] = false;
            }
          }
  }
}
