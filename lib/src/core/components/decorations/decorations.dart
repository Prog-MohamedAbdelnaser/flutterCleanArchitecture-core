import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:support/src/config/Themes/colors.dart';

import '../../../config/Themes/text_styles.dart';

class Decorations {




  static Decoration decorationWithGradient({Color? color, Color? shadowColor, double? radius, List<BoxShadow>? boxShadow}) {
    return BoxDecoration(
      color: color ?? kBackgroundColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: boxShadow ?? [
        BoxShadow(
          color: shadowColor ?? kPrimaryLight,
          spreadRadius: 0,
          blurRadius: 0,
          offset: Offset(3, 0), // changes position of shadow
        ),
      ],
      gradient: const LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [
          kGreyColor4,
          kBackgroundColor,
        ],
      ),
    );
  }


  static BoxDecoration boxDecorationShaded({
    Color? color,
    Color? shadowColor,
    Color? borderColor,
    double? radius,
  }) {
    return BoxDecoration(
        color: color ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
    );
  }

  static Decoration createRectangleDecoration({   double? radius,
    double? border,Color? color}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius??6),
    /*  border:border Border.all(
        color: kBordColor,
        width: 2.0,
      ),*/
        color:color ,
        border:border==0 ? Border.all(style: BorderStyle.none): Border.all(color: kBorderColor, width: border ?? 2.0)

    );
  }

  static Decoration createRectangleWithColorDecoration(Color   color ,Color bag,double radius ) {
    return BoxDecoration(
      color: bag,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: color,
        width: 1.0,
      ),
    );
  }

 static Decoration createRectangleDecorationOnlyBottom() {
    return BoxDecoration(
      color: kPrimaryDark,
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      border: Border.all(
        color: kPrimaryDark,
        width: 2.0,
      ),
    );
  }

  static createRectangleDecorationOnlyTob({
    Color? color,
    Color? shadowColor,
    Color? borderColor,
    double? radius,
  }) {
    return BoxDecoration(
        color: color ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
        border: Border.all(color: borderColor ?? kBorderColor, width: 0.5));
  }

  // by Harbey- decoration for container in job offer details
  static Decoration get decorationContainer => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 3),
      ),
    ],
  );

  static InputDecoration commonDecoration(
      {String? hint,
        Widget? icon,
        Widget? endIcon,
        String? helperText,
        TextStyle? helperStyle,
        Widget? suffix,
        Widget? prefix,
        TextDirection? textDirection}) {
    return kTextFieldDecoration.copyWith(
        prefixIcon: icon,
        hintText: hint,
        hintTextDirection: textDirection,
        suffixIcon: endIcon,
        suffix: suffix,
        prefix: prefix,
        helperText: helperText,
        helperStyle: helperStyle,
        suffixIconConstraints: const BoxConstraints(maxHeight: 20, minWidth: 40),
        hintStyle: kTextRegular.copyWith(fontSize: 13, color: kGreyColor),
        prefixIconConstraints: const BoxConstraints(maxHeight: 20, minWidth: 30));
  }

}
