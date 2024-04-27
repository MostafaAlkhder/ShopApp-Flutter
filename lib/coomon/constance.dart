import 'package:shopapp/All/login/loginScreen.dart';
import 'package:shopapp/network/local/cacheHelper.dart';
import 'package:shopapp/shared/components.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) => {
        if (value == true) {navigateAndFinish(context, LoginScreen())}
      });

  void printFullText(String text) {
    final pattern = RegExp('.{1,000}');
    pattern.allMatches(text).forEach((match) {
      print(match.group(0));
    });
  }
}

String? token = '';
