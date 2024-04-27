class ShopLoginModel {
  bool? status;
  late String message;
  UserData? data;
  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? cridit;
  String? token;

  // named constructor

  UserData.fromJson(Map<String, dynamic> json) {
    cridit = json['cridit'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    name = json['name'];
    phone = json['phone'];
    points = json['points'];
    token = json['token'];
  }
}
