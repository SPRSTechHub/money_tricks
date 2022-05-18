// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:money_tricks/utils/colors.dart';

class StyleText {
  static const app_title_text = TextStyle(
      color: AppColors.appbarTitle,
      fontSize: 22,
      letterSpacing: .2,
      fontFamily: 'latoBold',
      fontWeight: FontWeight.bold);
  static const card_title_text = TextStyle(
      color: AppColors.appbarTitle,
      fontSize: 18,
      letterSpacing: .2,
      fontFamily: 'latoBold',
      fontWeight: FontWeight.bold);
  static const post_title_text = TextStyle(
      color: Colors.blue,
      fontSize: 22,
      letterSpacing: .2,
      fontFamily: 'PlayfairDisplay');
  static const post_desc_text = TextStyle(
    fontSize: 16,
    fontFamily: 'latoRegular',
  );
}
