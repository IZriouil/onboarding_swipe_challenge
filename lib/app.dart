import 'dart:math';

import 'package:custom_swipe_challenge/on_boarding.page.dart';
import 'package:custom_swipe_challenge/widget/logo_animated.dart';
import 'package:custom_swipe_challenge/widget/single.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config/custom_controller.dart';
import 'config/scroll_config.dart';

// Three colors for pages as array
const List<Color> _colors = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
];

class SteizyOnBoarding extends StatefulWidget {
  const SteizyOnBoarding({super.key});

  @override
  State<SteizyOnBoarding> createState() => _SteizyOnBoardingState();
}

class _SteizyOnBoardingState extends State<SteizyOnBoarding> with TickerProviderStateMixin {
  late final SteizyController _steizyController;
  // final _pageController = PageController(initialPage: 0);
  // late final AnimationController _openController;
  // late final AnimationController _closeController;

  double _velocity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _steizyController = SteizyController(this);
    // _openController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 500),
    // );
    // _closeController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 500),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: GestureDetector(
          onHorizontalDragEnd: (details) {
            Size size = MediaQuery.of(context).size;
            // absolute number
            if (details.primaryVelocity!.abs() > size.width / 4) {
              if (details.primaryVelocity! > 0) {
                _steizyController.nextPage();
                _steizyController.startAnimation(from: _velocity.abs() / MediaQuery.of(context).size.width);
              }
              if (details.primaryVelocity! < 0) {
                _steizyController.previousPage();
                _steizyController.close
                    .reverse(from: _velocity.abs() / MediaQuery.of(context).size.width)
                    .then(
                  (value) {
                    _steizyController.reverseOpenAnimation();
                  },
                );
                _steizyController.reverseAnimation(from: _velocity.abs() / MediaQuery.of(context).size.width);
              }
              // _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeInCirc);
            } else {
              if (_velocity != 0) {
                _steizyController.reverseOpenAnimation(from: _velocity / MediaQuery.of(context).size.width);
                // _openController.reverse(from: _velocity / MediaQuery.of(context).size.width);
              }
            }
            _velocity = 0;
          },
          onHorizontalDragUpdate: (details) {
            Size size = MediaQuery.of(context).size;
            _velocity = details.localPosition.dx - size.width / 2;
            if (_velocity > 0) {
              _steizyController.openAnimation.value = _velocity / MediaQuery.of(context).size.width;
            } else {
              _steizyController.closeAnimation.value = 1 - _velocity / MediaQuery.of(context).size.width;
            }
            // We have the button centered on the screen
            // if we swipe 25% of the screen width to the right we go to the next page
            // if we swipe 25% of the screen width to the left we go to the previous page
            // if we swipe less than 25% of the screen width we add the open controller value relative to the drag distance
          },
          child: Stack(
            children: [
              AnimatedButton(
                controller: _steizyController,
              ),
              IgnorePointer(
                ignoring: true,
                child: PageView.builder(
                    controller: _steizyController.page,
                    scrollBehavior: WindowsScrollBehaviour(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return SinglePage(index: index);
                    }),
              ),
              LogoAnimatedWidget(controller: _steizyController)
            ],
          ),
        ));
  }
}
