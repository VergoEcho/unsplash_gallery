import 'package:flutter/material.dart';
import 'package:unsplash_gallery/screens/image_list.dart';

final ThemeData _unsplashGalleryTheme = buildUnsplashGalleryTheme();

ThemeData buildUnsplashGalleryTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.black
    ),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.black,
        )),
    primaryTextTheme: TextTheme(
        headline6: TextStyle(
            color: Colors.black
        ),
      bodyText2: TextStyle(
        color: Colors.black
      )
    ),
  );
}

void main() {
  runApp(MaterialApp(
    theme: _unsplashGalleryTheme,
    home: Gallery(),
  ));
}
