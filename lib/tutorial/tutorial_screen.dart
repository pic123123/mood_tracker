import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../common/constants/gaps.dart';
import '../common/constants/sizes.dart';
import '../common/utils/util.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final controller = PageController();

  ///Tutorial 완료시 Home 화면으로 이동
  void _onEnterAppTap() {
    context.go('/home');
  }

  final tutorialSecondImage = 'assets/images/tutorial_second.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          bool isLastPage = controller.hasClients &&
              controller.page != null &&
              controller.page! >= 2.0;
          return Container(
            width: MediaQuery.of(context).size.width * 0.7, // 화면 너비의 약 70%만큼 설정
            color: isDarkMode(context)
                ? Colors.black
                : Theme.of(context).appBarTheme.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size64,
                left: Sizes.size24,
                right: Sizes.size24,
              ),
              child: AnimatedOpacity(
                opacity: isLastPage ? 1.0 : 0.0,
                duration: const Duration(microseconds: 300),
                child: CupertinoButton(
                  onPressed: isLastPage ? _onEnterAppTap : null,
                  color: Theme.of(context).primaryColor,
                  child: const Text('Enter the app!'),
                ),
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: const ExpandingDotsEffect(),
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller,
                children: <Widget>[
                  // 첫 번째 페이지 내용...
                  const Center(
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: Sizes.size40,
                      ),
                    ),
                  ),
                  // 두 번째 페이지 내용...
                  Center(
                      child: Column(
                    children: [
                      Gaps.v40,
                      Image.asset(
                        tutorialSecondImage,
                        width: 400, // 원하는 너비로 설정
                        height: 400, // 원하는 높이로 설정
                      ),
                      Gaps.v40,
                      const Text(
                        "Express how you feel today",
                        style: TextStyle(
                          fontSize: Sizes.size28,
                        ),
                      ),
                    ],
                  )),
                  // 세 번째 페이지 내용...
                  Center(
                      child: Column(
                    children: const [
                      Gaps.v40,
                      Text(
                        "Let's start the app",
                        style: TextStyle(fontSize: 28),
                      ),
                      Gaps.v80,
                      Text(
                        "Please click the button below",
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
