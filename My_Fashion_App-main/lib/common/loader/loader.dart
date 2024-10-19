import 'package:my_fashion_app/resources/colors.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: white.withOpacity(
        0.6,
      ),
      alignment: Alignment.center,
      child: Lottie.asset(
        '${imagePath}loader.json',
      ),
    );
  }
}
