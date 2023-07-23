import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class quote_author extends StatelessWidget {
  final String quote;
  final String author;
  final Function() function;
  const quote_author({
    super.key,
    required this.quote,
    required this.author,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(children: [
        TextButton(
          onPressed: () {
            function();
          },
          child: Icon(
            Icons.refresh,
            size: 50,
            color: Colors.yellow,
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Image(
          image: AssetImage('assets/qoute.png'),
          height: 50,
        ),
        AutoSizeText(
          quote,
          style: GoogleFonts.gamjaFlower(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
          maxLines: 3,
        ),
        AutoSizeText(
          author,
          style: GoogleFonts.gamjaFlower(
              color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 28),
          maxLines: 3,
        ),
        Image(
          image: AssetImage('assets/2.png'),
          height: 50,
        ),
      ]),
    );
  }
}
