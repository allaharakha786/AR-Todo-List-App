import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/helper/constants/colors_resources.dart';
import 'package:todo_app/helper/constants/image_resources.dart';
import 'package:todo_app/helper/constants/screen_percentage.dart';
import 'package:todo_app/helper/constants/string_resources.dart';
import 'package:todo_app/helper/utills/text_style.dart';
import 'package:todo_app/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorsResources.BACKGROUND_COLOR,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_20.h,
              width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_45.w,
              child: Image.asset(
                ImageResources.ICON_URL,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              StringResources.AR_TODO_APP,
              style: TextStyles.splashStyle(),
            )
          ],
        ),
      ),
    );
  }
}
