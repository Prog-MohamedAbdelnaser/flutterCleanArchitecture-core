
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

final BorderRadius radius = BorderRadius.circular(6.0);

final ThemeData kAppTheme = ThemeData(
  scaffoldBackgroundColor: kBackgroundColor,
  primaryColor: kPrimaryDark,
  primaryColorLight: kPrimaryDark,
  primaryColorDark: kPrimaryDark,
  disabledColor: kGreyColor,
  splashColor: kPrimaryDark,
  //-----
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kPrimaryDark,
    focusColor: kPrimaryDark,
  ),
  //------------
  cardTheme: const CardTheme(
    color: kPrimaryLight,
    shadowColor: kPrimaryDark,
  ),
  //---------
  appBarTheme: const AppBarTheme(
    color: kPrimaryLight,
    centerTitle: true,
    shadowColor: kPrimaryDark,
    actionsIconTheme: IconThemeData(color: kBackgroundColor),
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
    titleTextStyle: TextStyle(
        color: kPrimaryDark, fontSize: 18
    ),
    iconTheme:
    IconThemeData(color: kBackgroundColor, size: 22),
  ),
  //----------
  buttonTheme:  ButtonThemeData(
    shape: StadiumBorder(),
    disabledColor: kGreyColor,
    buttonColor: kPrimaryDark,
    splashColor: kPrimaryDark,
    textTheme:  ButtonTextTheme.primary

  ),
  //--------------
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          color: kPrimaryLight,
          fontSize: 16,
        ),

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16))),
  ),

  //------------------
  textTheme: const TextTheme(
    displayLarge: kTextExtraBold,
    displayMedium: kTextBold,
    displaySmall: kTextMedium,

    headlineLarge: kTextLabel,

    labelLarge: kTextLabel,
    labelMedium: kTextLabel,
    labelSmall: kTextLabel,

    titleMedium: kTextBold,
    titleSmall: kTextBold,
    titleLarge: kTextBold,

    bodyLarge: kTextMedium,
    bodySmall: kTextRegular,
    bodyMedium: kTextMedium
  ),
  //-------------
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: kTextRegular.copyWith(color: kGreyColor),
    labelStyle: kTextLabelNormal,
    errorStyle: kTextRegular,
    filled: true,),
  //-----------
);
