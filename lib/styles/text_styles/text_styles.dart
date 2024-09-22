
import 'package:flutter/material.dart';
import 'package:games_app/core/helper/app_size_config.dart';
import 'package:games_app/styles/colors/color_manager.dart';

class TextStyles {
  /// normal text style
  static TextStyle textStyle18Bold= TextStyle(
    fontSize: SizeConfig.height * 0.02,
    color: ColorManager.textColor,
    fontWeight: FontWeight.bold
  );

  static TextStyle textStyle18Medium= TextStyle(
      fontSize: SizeConfig.height * 0.02,
      color: ColorManager.textColor,
      fontWeight: FontWeight.w500
  );

  static TextStyle textStyle18Regular= TextStyle(
      fontSize: SizeConfig.height * 0.02,
      color: ColorManager.textColor,
      fontWeight: FontWeight.w500
  );

  /// medium text style
  static TextStyle textStyle24Bold= TextStyle(
      fontSize: SizeConfig.height * 0.024,
      color: ColorManager.textColor,
      fontWeight: FontWeight.bold
  );

  static TextStyle textStyle24Medium= TextStyle(
      fontSize: SizeConfig.height * 0.024,
      color: ColorManager.textColor,
      fontWeight: FontWeight.w500
  );

  static TextStyle textStyle24Regular= TextStyle(
      fontSize: SizeConfig.height * 0.024,
      color: ColorManager.textColor,
      fontWeight: FontWeight.w500
  );

  /// large text style
  static TextStyle textStyle30Bold= TextStyle(
      fontSize: SizeConfig.height * 0.06,
      color: ColorManager.textColor,
      fontWeight: FontWeight.bold,
  );

  static TextStyle textStyle30Medium= TextStyle(
      fontSize: SizeConfig.height * 0.06,
      color: ColorManager.textColor,
      fontWeight: FontWeight.w500
  );

  static TextStyle textStyle30Regular= TextStyle(
      fontSize: SizeConfig.height * 0.06,
      color: ColorManager.textColor,
      fontWeight: FontWeight.w500
  );
}

