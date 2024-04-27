import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/All/search/searchStates.dart';
import 'package:shopapp/coomon/constance.dart';
import 'package:shopapp/coomon/models/searchModel.dart';
import 'package:shopapp/network/endPoints.dart';
import 'package:shopapp/network/remote/dioHelper.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void search(String text) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      print(
          "Search Search Search Search Search Search Search Search Search Search Search ");
      print(model!.status);
      emit(ShopSearchSuccessState());
    }).catchError((onError) {
      print(
          "NoSearch NoSearch NoSearch NoSearch NoSearch NoSearch NoSearch NoSearch NoSearch NoSearch ");
      print(onError.toString());
      emit(ShopSearchErrorState(onError));
    });
  }
}
