import 'package:custom_swipe_challenge/config/custom_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const List<Color> _colors = [
  Color(0xFF985EE1),
  Color(0xFF4365FF),
  Color(0xFFFF7D57),
  Color(0xFFFEAB23),
];

class LogoAnimatedWidget extends StatefulWidget {
  final SteizyController controller;
  const LogoAnimatedWidget({super.key, required this.controller});

  @override
  State<LogoAnimatedWidget> createState() => _LogoAnimatedWidgetState();
}

class _LogoAnimatedWidgetState extends State<LogoAnimatedWidget> {
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.openAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_currentPage != widget.controller.page.page!.ceil()) {
          setState(() {
            _currentPage = widget.controller.page.page!.ceil();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 800),
      curve: Curves.elasticInOut,
      alignment: _getAlignment(),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 500),
        style: GoogleFonts.dancingScript(
            fontSize: (_currentPage == _colors.length - 1) ? 70 : 35,
            color: (_currentPage == _colors.length - 1) ? Colors.black : Colors.white70,
            fontWeight: FontWeight.bold),
        child: const Text(
          "Steizy",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Alignment _getAlignment() {
    switch (_currentPage) {
      case 0:
        return Alignment.topCenter + const Alignment(0.7, 0.22);
      case 1:
        return Alignment.topCenter + const Alignment(-.5, .85);
      case 2:
        return Alignment.topCenter + const Alignment(.30, .13);
      case 3:
        return Alignment.center + const Alignment(0, .1);
      default:
        return Alignment.center;
    }
  }
}
