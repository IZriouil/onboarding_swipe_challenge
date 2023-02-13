import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const List<String> titles = [
  'Turning Ideas into Reality',
  'The Art of Creating Beautiful Apps ',
  'Building for the Future',
  'Flutter away with',
];

class SinglePage extends StatelessWidget {
  final int index;
  const SinglePage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    if (index == 3) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(60),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Text(
                  titles[index],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.alice(fontSize: 35, color: Colors.white),
                ),
                Text(
                  "",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dancingScript(fontSize: 40, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: Image.asset(
            'assets/images/${index + 1}.png',
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(60),
            child: Text(
              titles[index],
              textAlign: TextAlign.center,
              style: GoogleFonts.alice(fontSize: 40, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
