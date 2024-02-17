import 'dart:async';

import 'package:flutter/material.dart';
import '../../Resources/router_manager.dart';
import '../../Widgets/my_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {

  var timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 3), _goToNextScreen);
  }

  _goToNextScreen() {
    Navigator.pushNamed(context, AppRoutes.landingPage);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyText(
          text: 'Tawseela',
          size: 50,
          style: Theme.of(context).textTheme.displayLarge!,
        ),
      ),
    );
  }
}