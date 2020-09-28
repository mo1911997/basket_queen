class Model_Login {
  String state;
  String msg;
  String token;
  String mid;
  String name;
  String contact;
  String email;
  List addresses;

  String statusCode;

  Model_Login({this.state, this.msg, this.token, this.mid, this.name,
      this.contact, this.email, this.addresses, this.statusCode});

  Model_Login.fromJson(Map<String, dynamic> json,String status_Code) {
    state = json['state'];
    msg = json['msg'];
    token = json['token'];
    mid = json['id'];
    name = json['name'];
    contact = json['contact'];
    email= json['email'];
    addresses = json['addresses'];

    statusCode=status_Code;
  }


}