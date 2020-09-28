class ServicesModel {
  String state;
  List<Data> data;
  String status_code;
  ServicesModel({this.state, this.data});

  ServicesModel.fromJson(Map<String, dynamic> json,String statusCode) {
    status_code = statusCode;
    state = json['state'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String sId;
  String name;
  String contact;
  String address;
  String imgUrl;
  String contactPersonName;
  String serviceType;
  int iV;

  Data(
      {this.sId,
      this.name,
      this.contact,
      this.address,
      this.imgUrl,
      this.contactPersonName,
      this.serviceType,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    contact = json['contact'];
    address = json['address'];
    imgUrl = json['img_url'];
    contactPersonName = json['contact_person_name'];
    serviceType = json['service_type'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['address'] = this.address;
    data['img_url'] = this.imgUrl;
    data['contact_person_name'] = this.contactPersonName;
    data['service_type'] = this.serviceType;
    data['__v'] = this.iV;
    return data;
  }
}