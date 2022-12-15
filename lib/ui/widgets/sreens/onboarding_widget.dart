import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_application/domain/constants.dart';
import 'package:todo_application/domain/size_config.dart';
import 'package:todo_application/ui/navigation/main_navigation.dart';

import '../components/continueButton.dart';

//MARK: VIEW MODEL

class _ViewModel extends ChangeNotifier {
  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(int val) {
    _currentPage = val;
    notifyListeners();
  }

  BuildContext context;

  PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  final sharedPreferences = SharedPreferences.getInstance();

  _ViewModel(this.context) {
    didLoad();
  }

  List<Map<String, String>> splashData = [
    {
      "text": "Thank you for downloading and welcome to Simple Planner!",
      "image": "assets/images/Tasks.png"
    },
    {
      "text": "Management your tasks offline or from account",
      "image": "assets/images/management.png"
    },
  ];

  Future<void> onButtonPressed(BuildContext context) async {
    if (_currentPage == 1) {
      (await sharedPreferences).setBool(isShowedOnBoardingScreen, true);
      MainNavigation.showStartingScreen(context);
      return;
    }
    _currentPage += 1;
    pageController.animateToPage(_currentPage,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
    notifyListeners();
  }

  Future<void> didLoad() async {
    final isShowed =
        (await sharedPreferences).getBool(isShowedOnBoardingScreen);
    if (isShowed != null && isShowed) {
      MainNavigation.showStartingScreen(context);
    }
  }
}

//MARK: WIDGET

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
        create: (context) => _ViewModel(context),
        child: const OnBoardingWidget());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<_ViewModel>();

    return SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: PageView.builder(
                        controller: model.pageController,
                        onPageChanged: (value) {
                          model.currentPage = value;
                        },
                        itemCount: model.splashData.length,
                        itemBuilder: ((context, index) {
                          return _SplashContent(
                              text: model.splashData[index]["text"] ?? "",
                              image: model.splashData[index]["image"] ??
                                  "assets/images/default.png");
                        }))),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(context, 20)),
                      child: Column(
                        children: [
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                model.splashData.length,
                                (index) => _Dots(
                                      index: index,
                                    )),
                          ),
                          const Spacer(flex: 3),
                          ContinueButton(
                            text: model.currentPage == 1 ? "Start" : "Continue",
                            press: () {
                              model.onButtonPressed.call(context);
                            }, backColor: Colors.orange,
                          ),
                          const Spacer()
                        ],
                      ),
                    )),
              ],
            )));
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Text("Simple Planner",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(context, 36),
                        color: Colors.orange,
                        fontWeight: FontWeight.bold)),
                Text(
                  text,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Image.asset(
                  image,
                  height: getProportionateScreenHeight(context, 265),
                  width: getProportionateScreenWidth(context, 235),
                )
              ],
            )),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<_ViewModel>();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: model.currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: model.currentPage == index ? Colors.orange : Colors.grey,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
