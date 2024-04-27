import 'package:flutter/material.dart';
import 'package:shopapp/network/local/cacheHelper.dart';
import 'package:shopapp/shared/components.dart';
import 'package:shopapp/All/login/loginScreen.dart';
import 'package:shopapp/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

bool isLast = false;

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;
  BoardingModel({required this.title, required this.body, required this.image});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then(
      (value) {
        if (value == true) {
          navigateAndFinish(context, LoginScreen());
        }
      },
    );
  }

  List<BoardingModel> boarding = [
    BoardingModel(
        title: "Shopping",
        body: "Flutter Development",
        image: 'assets/images/onboarding_1.webp'),
    BoardingModel(
        title: "Marketing",
        body: "Flutter Development",
        image: 'assets/images/onboarding_2.webp'),
    BoardingModel(
        title: "Development",
        body: "Flutter Development",
        image: 'assets/images/onboarding_3.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: submit, child: Text("skip"))],
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (Index) {
                  if (Index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoaringItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defultColor,
                      dotHeight: 10,
                      spacing: 5.0,
                      expansionFactor: 4),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 1200),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoaringItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          Text(
            model.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            model.body,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      );
}
