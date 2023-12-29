import 'package:flutter/material.dart';
import 'package:movie_app/pages/splashscreen_page.dart';

void main() {
  runApp(
    SplashScreenPage(key: UniqueKey(), onInitializationComplete: () => null),
  );
}
