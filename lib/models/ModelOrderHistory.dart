class ModelOrderHistory {
  String state;
  List<Data> data;
  String statusCode;

  ModelOrderHistory({this.state, this.data});

  ModelOrderHistory.fromJson(Map<String, dynamic> json, String status_Code) {
    state = json['state'];
    statusCode=status_Code;
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  String sId;
  List<Items> items;
  String user;
  String orderStatus;
  String paymentMode;
  String paymentStatus;
  String date;
  var store;
  String total;
  int deliveryCharges;
  int orderId;
  int iV;

  Data(
      {this.sId,
        this.items,
        this.user,
        this.orderStatus,
        this.paymentMode,
        this.paymentStatus,
        this.date,
        this.store,
        this.total,
        this.deliveryCharges,
        this.orderId,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    user = json['user'];
    orderStatus = json['order_status'];
    paymentMode = json['payment_mode'];
    paymentStatus = json['payment_status'];
    date = json['date'];
    store = json['store'];
    total = json['total'];
    deliveryCharges = json['delivery_charges'];
    orderId = json['order_id'];
    iV = json['__v'];
  }

}

class Items {
  String sId;
  String product;
  String itemName;
  String rate;
  int qty;
  String total;

  Items(
      {this.sId, this.product, this.itemName, this.rate, this.qty, this.total});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product = json['product'];
    itemName = json['item_name'];
    rate = json['rate'];
    qty = json['qty'];
    total = json['total'];
  }

}