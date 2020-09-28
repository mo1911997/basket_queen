import 'package:flutter/material.dart';

class OrderHistoryDetails extends StatefulWidget {
  var orderData;

  OrderHistoryDetails(this.orderData);

  @override
  _OrderHistoryDetailsState createState() => _OrderHistoryDetailsState();
}

class _OrderHistoryDetailsState extends State<OrderHistoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(widget.orderData.date.toString()),
      ),
    );
  }
}
