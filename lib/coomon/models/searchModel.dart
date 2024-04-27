class SearchModel {
  late bool status;
  late SearchDataModel data;
  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = SearchDataModel.fromJson(json['data']);
  }
}

class SearchDataModel {
  late List<SearchDataDataModel> data = [];
  SearchDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(SearchDataDataModel.fromJson(element));
    });
  }
}

class SearchDataDataModel {
  late int id;
  late dynamic price;
  // late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;
  SearchDataDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    // oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
