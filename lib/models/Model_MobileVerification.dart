class Model_MobileVerification {
  String state;
  String msg;
  String statusCode;

  Model_MobileVerification({this.state, this.msg});

  Model_MobileVerification.fromJson(Map<String, dynamic> json,String status_Code) {
    state = json['state'];
    msg = json['msg'];
    statusCode=status_Code;
  }
}