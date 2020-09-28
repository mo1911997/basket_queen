import 'package:aaishani_store_user_app/dbClient/OperationsCart.dart';
import 'package:aaishani_store_user_app/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cart extends StatefulWidget {

  var selectedIndex;

  Cart(this.selectedIndex);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart>
{
  List cartData = [];
  List cartQty = [];
  List cartData2 = [];
  int amount = 0;
  double height;
  var cartLength=0;


  var total=0.0;

  OperationsCart operationsCart = OperationsCart();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCartData();
    height = AppBar().preferredSize.height;
    print("appbar height: "+ height.toString());
  }

  getCartData() async {
    cartData2 = await operationsCart.getCartData();
    setState(() {
      for(var i in cartData2)
        {
          cartData.add(i);
        }
    });
    for(var i in cartData)
      {
        print("total price in init = "+total.toString()+" + "+double.parse(i['price']).toString()+" * "+int.parse(i['qty']).toString());
        total=total+(double.parse(i['price'])* int.parse(i['qty']));
        cartQty.add(int.parse(i['qty']));
      }
    print("CartData: " + cartData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return cartData.length==0?
        Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Color(0xFF85CE16),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFFffbd5c),
              ),
              onPressed: () {
                print("pop result: "+"$widget.selectedIndex");
                Navigator.pop(context,widget.selectedIndex);
              },
            ),
            title: Text(
              "My Cart",
              style: TextStyle(
                  fontFamily: "Gothic", color: Colors.white, fontSize: 18.0),
            ),
          ),
          body:Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bgreg.png"),
                      alignment: Alignment.topCenter)),
            child: Text("Your cart is Empty",style: TextStyle(fontFamily:"Gothic",color: Colors.white
            ),),
          ),
        )
        : WillPopScope(
          onWillPop: () async {
            print("pop result inCart: "+"$widget.selectedIndex");
            Navigator.pop(context,widget.selectedIndex);
            return false;
          },
          child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Color(0xFF85CE16),
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
              "My Cart",
              style: TextStyle(
                  fontFamily: "Gothic", color: Colors.white, fontSize: 18.0),
            ),
            actions: [

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: (){
                      operationsCart.deleteCartData();
                      setState(() {
                        cartData=[];
                        total=0.0;
                      });
                    },
                    child: Container(
                      width: 80.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey, blurRadius: 4, offset: Offset(0, 2))
                          ]),

                      child: Center(
                        child: Text(
                          "Clear Cart",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gothic',
                              fontSize: 12.0),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bgreg.png"),
                    alignment: Alignment.topCenter)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Items in cart",
                            style: TextStyle(
                                fontFamily: "Gothic",
                                fontSize: 14.0,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            cartData.length.toString(),
                            style: TextStyle(
                                fontFamily: "Gothic",
                                fontSize: 14.0,
                                color: Colors.white),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartData.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 3.0,
                                child: Container(
                                  color: Colors.transparent,
                                  height: 140.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 120.0,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://picsum.photos/200/300"),
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cartData[index]['product_name'],
                                                  style: TextStyle(
                                                      fontFamily: "Gothicb",
                                                      fontSize: 18.0,
                                                      color: Colors.grey[700]),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Text(
                                                      cartData[index]['variant']),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.52,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Price",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Gothicb",
                                                                fontSize: 14.0,
                                                                color: Colors
                                                                    .grey[800]),
                                                          ),
                                                          SizedBox(
                                                            width: 5.0,
                                                          ),
                                                          Text(
                                                            "₹ " + (double.parse(cartData[ index]['price']) * cartQty[index]).toString(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Gothicb",
                                                                fontSize: 14.0,
                                                                color: Colors
                                                                    .grey[800]),
                                                          ),
                                                          SizedBox(
                                                            width: 5.0,
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        "save ₹ " + (double.parse(cartData[index]['savings'])*cartQty[index]).toString(),
                                                        style: TextStyle(
                                                            fontFamily: "Gothic",
                                                            fontSize: 10.0,
                                                            color:
                                                                Colors.grey[700]),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        //border: Border.all(color: Colors.grey[800], width: 1)),
                                                        border: Border.all(
                                                            color:
                                                                Color(0xFF85CE16),
                                                            width: 1)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          //child: Icon(Icons.remove,color: Colors.grey[800],),
                                                          child: Icon(
                                                            Icons.remove,
                                                            color:
                                                                Color(0xFF85CE16),
                                                          ),
                                                          onTap: () async {
                                                            setState(() {

                                                              if((cartQty[index]-1)<1)
                                                              {
                                                                operationsCart.deleteCartItemData(cartData[index]['product_id'], cartData[index]['variant']);
                                                                setState(() {
                                                                  try{
                                                                    cartData.removeAt(index);
                                                                    cartQty[index]=int.parse(cartData[index]['qty']);
                                                                    total=total-(double.parse(cartData[index]['price']));
                                                                  }catch(e){
                                                                    print("error101: "+e.toString());
                                                                  }
                                                                });
                                                              }
                                                              else
                                                              {
                                                                cartQty[index]=cartQty[index]-1;
                                                                total=total-(double.parse(cartData[index]['price']));
                                                                operationsCart.updateCartData(cartQty[index], cartData[index]['product_id'], cartData[index]['variant']);
                                                              }
                                                            });
                                                          },
                                                        ),
                                                        //Text('$amount',style: TextStyle(fontFamily: "Gothic",color: Colors.grey[800]),),
                                                        Text(
                                                          cartQty[index].toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Gothicb",
                                                              color: Color(
                                                                  0xFF85CE16)),
                                                        ),
                                                        GestureDetector(
                                                          //child: Icon(Icons.add,color:Colors.grey[800]),
                                                          child: Icon(Icons.add,
                                                              color: Color(
                                                                  0xFF85CE16)),
                                                          onTap: () async {
                                                            //Add
                                                              setState(() {
                                                                operationsCart.updateCartData(cartQty[index]+1, cartData[index]['product_id'], cartData[index]['variant']);
                                                                cartQty[index]=cartQty[index]+1;
                                                                print("total price = "+total.toString()+" + "+double.parse(cartData[index]['price']).toString()+" * "+cartQty[index].toString());
                                                                total=total+(double.parse(cartData[index]['price']));
                                                              });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(-2, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Cart Total",style: TextStyle(fontFamily: "Gothic"),),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Text("₹ ",style: TextStyle(fontFamily: "Gothicb",fontSize: 18.0),),
                                Text(total.toString(),style: TextStyle(fontFamily: "Gothicb"),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: RaisedButton(
                          elevation: 3.0,
                          onPressed: () {
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Color(0xFF85CE16),
                          child: Text(
                            'Proceed >',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Gothic",
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
        );
  }

   getItemPrice(double price, int quantity) {
    var totalItemPrice = price * quantity;
    return totalItemPrice.toString();
  }
}
