import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Decorations {




  static Decoration decorationWithGradient({Color? color, Color? shadowColor, double? radius, List<BoxShadow>? boxShadow}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
      boxShadow: boxShadow ?? [
        BoxShadow(
          color: shadowColor??Colors.grey.shade400 ,
          spreadRadius: 0,
          blurRadius: 0,
          offset: Offset(3, 0), // changes position of shadow
        ),
      ],
      gradient:  LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [
          shadowColor??Colors.grey.shade400,
          shadowColor??Colors.grey.shade50,
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

}
