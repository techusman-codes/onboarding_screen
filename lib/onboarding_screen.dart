import 'package:flutter/material.dart';
import 'package:onboarding_screen/intro_screens/home_page.dart';
import 'package:onboarding_screen/intro_screens/intro_page.dart';
import 'package:onboarding_screen/intro_screens/intro_page2.dart';
import 'package:onboarding_screen/intro_screens/intro_page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // controller is how many page we are track on
  PageController _controller = PageController();
  // keep track if we are i the last page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // pageview widget is used to create swipable widget for your project
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              IntroPage(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          // dot indicators

          Container(
              alignment: Alignment(0, 0.75),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SKIP
                    GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(2);
                      },
                      child: Text('Skip'),
                    ),
                    // DOT INDICATOR
                    SmoothPageIndicator(controller: _controller, count: 3),
                    onLastPage
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return HomePage();
                                  },
                                ),
                              );
                            },
                            child: Text('Done'),
                          )
                        : GestureDetector(
                            onTap: () {
                              _controller.nextPage(
                                  duration: (Duration(milliseconds: 500)),
                                  curve: Curves.easeIn);
                            },
                            child: Text('Next'),
                          ),
                    // last page done
                  ]))
        ],
      ),
    );
  }
}
