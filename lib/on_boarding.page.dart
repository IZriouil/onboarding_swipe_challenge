import 'package:custom_swipe_challenge/config/custom_controller.dart';
import 'package:flutter/material.dart';

const List<Color> _colors = [
  Color(0xFF985EE1),
  Color(0xFF4365FF),
  Color(0xFFFF7D57),
  Color(0xFFFEAB23),
];

class AnimatedButton extends StatefulWidget {
  final SteizyController controller;
  const AnimatedButton({super.key, required this.controller});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool switchDone = false;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    widget.controller.closeAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          switchDone = false;
        });
      }
    });
    widget.controller.openAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentPage = widget.controller.page.page!.ceil();
          switchDone = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: _colors[_currentPage],
        ),
        if (!switchDone)
          Align(
            alignment: Alignment.bottomCenter + const Alignment(0, -0.2),
            child: AnimatedBuilder(
              animation: widget.controller.openAnimation,
              builder: (context, child) {
                return Transform.scale(
                  alignment: Alignment.centerLeft,
                  scale: Tween<double>(begin: 1, end: 500)
                      .animate(
                          CurvedAnimation(parent: widget.controller.openAnimation, curve: Curves.easeInCirc))
                      .value,
                  child: child,
                );
              },
              child: GestureDetector(
                onTap: () {
                  widget.controller.nextPage();
                  widget.controller.startAnimation();
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color:
                        _colors[(_currentPage + 1) >= _colors.length ? _colors.length - 1 : _currentPage + 1],
                    shape: BoxShape.circle,
                  ),
                  child: _currentPage == _colors.length - 1
                      ? null
                      : const Icon(
                          Icons.chevron_right,
                          size: 35,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
          ),
        if (switchDone)
          Align(
            alignment: Alignment.bottomCenter + const Alignment(0, -0.2),
            child: AnimatedBuilder(
              animation: widget.controller.closeAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    Tween<double>(begin: -70, end: 0)
                        .animate(CurvedAnimation(
                            parent: widget.controller.closeAnimation, curve: Curves.easeInExpo))
                        .value,
                    0,
                  ),
                  child: Transform.scale(
                    alignment: Alignment.centerRight,
                    scale: Tween<double>(begin: 500, end: 0)
                        .animate(CurvedAnimation(
                            parent: widget.controller.closeAnimation, curve: Curves.easeOutCirc))
                        .value,
                    child: child,
                  ),
                );
              },
              child: GestureDetector(
                onTap: () {
                  if (switchDone) {
                    widget.controller.closeAnimation.reverse().then((value) {
                      widget.controller.previousPage();
                      widget.controller.reverseOpenAnimation();
                    });
                  } else {
                    widget.controller.closeAnimation.forward(from: 0).then((value) {
                      setState(() {
                        switchDone = false;
                      });
                    });
                  }
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: _colors[_currentPage - 1],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
