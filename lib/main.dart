import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/pages/main_page.dart';
import 'package:movie_app/pages/splashscreen_page.dart';

void main() {
  runApp(
    SplashScreenPage(
      key: UniqueKey(),
      onInitializationComplete: () => runApp(
        ProviderScope(child: RamseysMovie()),
      ),
    ),
  );
}

class RamseysMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RamseysMovie',
      initialRoute: 'home',
      routes: {'home': (BuildContext _context) => MainPage()},
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}
