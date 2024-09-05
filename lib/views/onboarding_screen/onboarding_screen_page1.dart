import 'package:flutter/material.dart';

class OnboardingScreenpage1 extends StatelessWidget {
  const OnboardingScreenpage1({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Image.asset('assets/images/onboardinimage1.jpg',
      height: size.height,),
    );
  }
}
