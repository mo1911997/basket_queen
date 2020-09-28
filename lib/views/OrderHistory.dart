import 'dart:convert';

import 'package:aaishani_store_user_app/NetworkProvider/ApiProvider.dart';
import 'package:aaishani_store_user_app/models/ModelOrderHistory.dart';
import 'package:aaishani_store_user_app/views/OrderHistoryDetails.dart';
import 'package:flutter/material.dart';
class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {

  ModelOrderHistory modelOrderHistory;
  ModelOrderHistory modelOrderHistory2;
  ApiProvider apiProvider = ApiProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderHistory();
  }

  getOrderHistory() async{
    modelOrderHistory2 = await apiProvider.requestOrderHistory();
    setState(() {
      modelOrderHistory=modelOrderHistory2;
    });
    print("ModelOrderData: "+modelOrderHistory.data.length.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF85CE16),
        elevation: 5.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: Text(
          "Order History",
          style: TextStyle(
              fontFamily: "Gothic", color: Colors.white, fontSize: 18.0),
        ),
      ),
      body:modelOrderHistory==null?Center(
        child: CircularProgressIndicator(backgroundColor: Color(0xFF85CE16),),
      ):Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgreg.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
          child: ListView.builder(
              itemCount: modelOrderHistory.data.length,
              itemBuilder: (ctx,index){
            return Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (c, a1, a2) => OrderHistoryDetails(modelOrderHistory.data[index]),
                      transitionsBuilder: (c, anim, a2, child) =>
                          FadeTransition(opacity: anim, child: child),
                      transitionDuration: Duration(milliseconds: 800),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 3.0,
                  child: Container(
                    height:MediaQuery.of(context).size.height*0.15,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomLeft: Radius.circular(10.0))
                          ),
                          child: Image.network(modelOrderHistory.data[index].store['thumbnail'],fit: BoxFit.fill,),
                        ),
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0,top: 5.0,right: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("#"+modelOrderHistory.data[index].orderId.toString(),style: TextStyle(fontFamily: "Gothic",fontSize: 12.0,color: Colors.red),),
                                      Text(modelOrderHistory.data[index].date.toString(),style: TextStyle(fontFamily: "Gothic",fontSize: 12.0,color: Colors.grey[700]),),
                                    ],
                                  ),
                                  SizedBox(height: 10.0,),
                                  Text(modelOrderHistory.data[index].store['name'].toString(),style: TextStyle(fontFamily: "Gothicb",fontSize: 16.0,color: Colors.grey[700]),),
                                  SizedBox(height: 5.0,),
                                  Text(json.decode(modelOrderHistory.data[index].orderStatus)['Placed']==1
                                      && json.decode(modelOrderHistory.data[index].orderStatus)['Accepted']==0
                                      && json.decode(modelOrderHistory.data[index].orderStatus)['Delivered']==0?"Order Status : Pending":
                                  json.decode(modelOrderHistory.data[index].orderStatus)['Placed']==1
                                      && json.decode(modelOrderHistory.data[index].orderStatus)['Accepted']==1
                                      && json.decode(modelOrderHistory.data[index].orderStatus)['Delivered']==0?"Order Status : Accepted":"Order Status : Delivered"
                                    ,style: TextStyle(fontFamily: "Gothic",fontSize: 12.0,color: Colors.grey[700]),),
                                  SizedBox(height: 5.0,),
                                  Text("Total Amount: "+ modelOrderHistory.data[index].total.toString(),style: TextStyle(fontFamily: "Gothic",fontSize: 12.0,color: Colors.grey[700]),),
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
