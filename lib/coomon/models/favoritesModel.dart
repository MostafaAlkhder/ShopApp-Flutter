class FavoritesModel {
  late bool status;
  late FavDataModel data;
  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = FavDataModel.fromJson(json['data']);
  }
}

class FavDataModel {
  List<FDataModel> data = [];
  FavDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((ele) {
      data.add(FDataModel.fromJson(ele));
    });
  }
}

class FDataModel {
  late int id;
  late FavProductModel product;
  FDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = FavProductModel.fromJson(json['product']);
  }
}

class FavProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String? image;
  late String? name;
  late String? description;
  FavProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
