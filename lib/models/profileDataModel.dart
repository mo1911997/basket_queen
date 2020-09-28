class ProfileData{
  int id;
  String mid;
  String name;
  String contact;
  String email;
  String addresses;

  ProfileData({this.id,this.mid,this.name, this.contact, this.email, this.addresses});
  Map<String, dynamic> toMap() {
    return {
      'id' :id,
      'mid' :mid,
      'name': name,
      'contact': contact,
      'email' : email,
      'addresses' :addresses,
    };
  }

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    mid = json['mid'];
    name = json['name'];
    contact = json['contact'];
    email= json['email'];
    addresses = json['addresses'];
  }
}