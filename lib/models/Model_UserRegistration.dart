class Model_UserRegistration {
  String state;
  String msg;
  String statusCode;

  Model_UserRegistration({this.state, this.msg});

  Model_UserRegistration.fromJson(Map<String, dynamic> json,String status_Code) {
    state = json['state'];
    msg = json['msg'];
    statusCode=status_Code;
  }
}