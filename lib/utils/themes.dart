import 'package:flutter/material.dart';
import 'package:native_color/native_color.dart';

class Themes {

  // app Colors
  static final uWhite = HexColor('f5f5f5');

  static final cDarkBg = HexColor('1e1e25');
  static final cDarkButtons = HexColor('252831');
  static final cVioletButton = HexColor('775fcf');
  static final cPaleButtons = HexColor('302e44');
  static final calcNumbers = HexColor('eaebef');
  static final cWhiteNumbers = HexColor('f1f3f2');
  static final cButtonSplash = HexColor('977fdd');
  static final cButtonHighLight = HexColor('b6a4ec');

  static ThemeData basicTheme() {
    TextTheme _basicTextTheme(TextTheme base) {
      return base.copyWith(
        headline: base.headline.copyWith(
          fontFamily: 'CalibriBold',
          fontSize: 18.0,
          color: Themes.uWhite,
        ),
      );
    }
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      textTheme: _basicTextTheme(base.textTheme),
      primaryColor: Colors.blue,
    );
  }

}
