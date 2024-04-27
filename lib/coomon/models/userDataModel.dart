class ShopProfileLoginModel {
  late bool status;
  late ProfileData data;
  ShopProfileLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = ProfileData.fromJson(json['data']);
  }
}

class ProfileData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
  }
}
