import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../assets/fonts.dart';
import 'colors.dart';

const kTextLabel = TextStyle(
  color: kFontDarkColor,
  fontFamily: 'Regular',
  height: 1.2, //SETTING THIS CAN SOLVE YOUR PROBLEM
);
const kTextLabelWhite = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontFamily: 'Regular',
);
const kTextLabelNormal = TextStyle(
  color: kFontDarkColor,
  fontSize: 14.0,
  fontFamily: 'Regular',
);
const kTextLabelSmall = TextStyle(
  color: Colors.black,
  fontSize: 10.0,
  fontFamily: 'Regular',
);

const kTextLabelFontDark = TextStyle(
  color: kFontDarkColor,
  fontSize: 16.0,
  fontFamily: 'Regular',
);
final kAppBarShape = RoundedRectangleBorder(
  borderRadius: new BorderRadius.vertical(
    bottom: new Radius.elliptical(500, 50),
  ),
);

const kTextMedium = TextStyle(
  color: kFontDarkColor,
  fontSize: 16.0,
  height: 1.2, //SETTING THIS CAN SOLVE YOUR PROBLEM
  fontFamily: 'Medium',
);
const kTextSemiBold = TextStyle(
  color: kFontDarkColor,
  fontSize: 20.0,
  height: 1,
  fontFamily: 'SemiBold',
);
const kDrawerItemStyle =
    TextStyle(fontFamily: 'Regular', fontSize: 15, color: kPrimary);

const kTextRegular = TextStyle(
  color: kFontDarkColor,
  fontSize: 16.0,
  fontFamily: Fonts.regular,
);

const kTextLight = TextStyle(
  color: kFontDarkColor,
  fontSize: 12.0,
  fontFamily: 'Light',
);
final kTextRegularPrimary =
    kTextRegular.copyWith(color: kPrimary, fontSize: 12);

const kTextBold = TextStyle(
  color: kFontDarkColor,
  fontSize: 16.0,
  fontFamily: 'Bold',
);

const kTextBoldTitle = TextStyle(
  color: kFontDarkColor,
  fontSize: 18.0,
  fontFamily: 'Bold',
);
const kTextBoldSmall = TextStyle(
  color: kFontDarkColor,
  fontSize: 11.0,
  fontFamily: 'Bold',
);

const kTextBodyBold = TextStyle(
  color: kFontDarkColor,
  fontSize: 14.0,
  fontFamily: 'Bold',
);

const kTextExtraBold = TextStyle(
  color: kFontDarkColor,
  fontSize: 18.0,
  fontFamily: 'Black',
);

const kProfileFieldDecoration = InputDecoration(
    fillColor: kWhitTwo,
    filled: true,
    errorMaxLines: 1,
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ));


final kTextFieldDecoration = InputDecoration(
    filled: false,
    hintStyle: kTextLabelFontDark.copyWith(fontSize: 18, color: kBorderColor),
    contentPadding:  EdgeInsets.symmetric(vertical: 10, horizontal: 24),
    border:  OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: kBorderColor),
    ),

    enabledBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide:
      BorderSide(color: kBorderColor, width: 1.1, style: BorderStyle.solid),
    ),
    focusedBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide:
      BorderSide(color: kBorderColor, width: 1.1, style: BorderStyle.solid),
    ));


const kButtonTextStyle = TextStyle(
  fontSize: 24.0,
  color: Colors.white,
  fontFamily: 'Medium',
);
