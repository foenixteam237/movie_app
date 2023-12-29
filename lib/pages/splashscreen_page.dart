import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashScreenPage({
    super.key,
    required this.onInitializationComplete,
  });

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RamseysMovie",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Center(
          child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.contain, image: AssetImage('assets/images/'))),
      )),
    );
  }
}
