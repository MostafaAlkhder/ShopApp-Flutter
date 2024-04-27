import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/All/categories/categoriesScreen.dart';
import 'package:shopapp/All/favorites/favoritesScreen.dart';
import 'package:shopapp/All/products/productsScreen.dart';
import 'package:shopapp/All/settings/settingsScreen.dart';
import 'package:shopapp/bloc/ShopCubit/shopStates.dart';
import 'package:shopapp/coomon/constance.dart';
import 'package:shopapp/coomon/models/categoriesModel.dart';
import 'package:shopapp/coomon/models/changeFavoritesModel.dart';
import 'package:shopapp/coomon/models/favoritesModel.dart';
import 'package:shopapp/coomon/models/homeModel.dart';
import 'package:shopapp/coomon/models/userDataModel.dart';
import 'package:shopapp/network/endPoints.dart';
import 'package:shopapp/network/remote/dioHelper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int?, bool?> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data.products.forEach((element) {
        favorites.addAll({element['id']: element['in_favorites']});
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    if (favorites[productId] == true)
      favorites[productId] = false;
    else
      favorites[productId] = true;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel?.status == false) {
        if (favorites[productId] == true)
          favorites[productId] = false;
        else
          favorites[productId] = true;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState());
    }).catchError((onError) {
      if (changeFavoritesModel?.status == false) {
        if (favorites[productId] == true)
          favorites[productId] = false;
        else
          favorites[productId] = true;
      }
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopProfileLoginModel? shopProfileLoginModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      shopProfileLoginModel = ShopProfileLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData(
      {required String name, required String phone, required String email}) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(url: PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      shopProfileLoginModel = ShopProfileLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }

  search() {}
}
