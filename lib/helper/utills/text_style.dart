import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/helper/constants/colors_resources.dart';
import 'package:todo_app/helper/constants/dimentions_resources.dart';
import 'package:todo_app/helper/constants/string_resources.dart';

class TextStyles {
  static TextStyle tileStyle() {
    return TextStyle(
      color: ColorsResources.BLACK_COLOR,
      fontFamily: StringResources.POPPINE_LIGHT,
    );
  }

  static TextStyle buttonStyle(Color? color) {
    return TextStyle(
      color: color,
      fontFamily: StringResources.POPPINE_REGULAR,
    );
  }

  static TextStyle splashStyle() {
    return TextStyle(
      letterSpacing: 2,
      color: ColorsResources.BLACK_COLOR,
      fontFamily: StringResources.POPPINE_BOLD,
    );
  }

  static TextStyle titleStyle() {
    return TextStyle(
      fontSize: DimensionsResource.FONT_SIZE_MEDIUM.sp,
      letterSpacing: 1,
      color: ColorsResources.BLACK_COLOR,
      fontFamily: StringResources.POPPINE_REGULAR,
    );
  }
}
