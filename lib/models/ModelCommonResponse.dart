class ModelCommonResponse{
  String state;
  String msg;
  String statusCode;

  ModelCommonResponse(this.state, this.msg, this.statusCode);

  ModelCommonResponse.fromJson(Map<String, dynamic> json,String status_Code) {
    state = json['state'];
    msg = json['msg'];
    statusCode=status_Code;
  }
}