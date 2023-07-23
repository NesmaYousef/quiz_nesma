import 'dart:convert';
import 'dart:ui';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_nesma/services/imageProvider.dart';
import 'package:quiz_nesma/services/quoteProvider.dart';
import 'package:quiz_nesma/widgets/qoute_author.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.yellow : Colors.black,
        ),
      );
    },
  );
  late Future imageApi;
  late Future quoteApi;
  void update() {
    setState(() {
      imageApi = imageProvider().getImage();
      quoteApi = quoteProvider().getData();
    });
  }

  @override
  void initState() {
    update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            FutureBuilder<dynamic>(
              future: imageApi,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return spinkit; // Show a loading indicator while waiting for data
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  if (snapshot.hasData) {
                    final imageData = snapshot.data;
                    final image = imageData[
                        'url']; // Assuming the API response contains image
                    return ClipRRect(
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Image.network(
                          image,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return Text('No image available');
                  }
                }
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 44),
              child: FutureBuilder<dynamic>(
                  future: quoteApi,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        '',
                      ); // Show a loading indicator while waiting for data
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      if (snapshot.hasData) {
                        final data = snapshot.data;
                        final quote = data['content'];
                        final author = data[
                            'authorSlug']; // Assuming the API response contains a 'fact' field
                        return quote_author(
                            quote: quote, author: author, function: update);
                      } else {
                        return Text('No quote available');
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
