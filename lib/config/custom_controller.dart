import 'package:flutter/material.dart';

class SteizyController {
  late final PageController pageController;
  late final AnimationController openAnimation;
  late final AnimationController closeAnimation;

  // getters
  PageController get page => pageController;
  AnimationController get open => openAnimation;
  AnimationController get close => closeAnimation;

  SteizyController(TickerProvider vsync) {
    pageController = PageController(initialPage: 0);

    openAnimation = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 500),
    );
    closeAnimation = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 500),
    );

    // When openAnimation is completed, trigger closeAnimation
    openAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        closeAnimation.forward();
        openAnimation.reset();
      }
    });

    // When closeAnimation is completed, reset it
    closeAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        closeAnimation.reset();
      }
    });
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInCirc,
    );
  }

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInCirc,
    );
  }

  void startAnimation({double from = 0}) {
    openAnimation.forward(from: from);
  }

  void reverseOpenAnimation({double from = 1}) {
    openAnimation.reverse(from: from);
  }

  void reverseAnimation({double from = 1}) {
    closeAnimation.reverse(from: from).then((value) => openAnimation.reverse(from: 1));
  }

  void dispose() {
    pageController.dispose();
    openAnimation.dispose();
    closeAnimation.dispose();
  }
}
