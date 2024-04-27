import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/ShopCubit/shopCubit.dart';
import 'package:shopapp/bloc/ShopCubit/shopStates.dart';
import 'package:shopapp/bloc/cubit/bloc_observer.dart';
import 'package:shopapp/coomon/constance.dart';
import 'package:shopapp/All/login/loginScreen.dart';
import 'package:shopapp/modules/onBoarding.dart';
import 'package:shopapp/network/local/cacheHelper.dart';
import 'package:shopapp/network/remote/dioHelper.dart';
import 'package:shopapp/shopLayout.dart';
import 'package:shopapp/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget startWidget;
  // CacheHelper.sharedPreferences.clear();
  dynamic onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print("token is .. ${token}");
  if (onBoarding != null) {
    if (token != null) {
      startWidget = ShopLayout();
    } else {
      startWidget = LoginScreen();
    }
  } else {
    startWidget = OnBoardingScreen();
  }
  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: Themes.mainTheme,
            // darkTheme: Themes.darkTheme,
            home: Scaffold(
                // appBar: AppBar(),
                body: startWidget),
          );
        },
      ),
    );
  }
}
