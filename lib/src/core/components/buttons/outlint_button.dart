import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:support/src/config/Themes/colors.dart';

import '../../../config/Themes/text_styles.dart';


class AppOutlineButton extends StatelessWidget {
  final String ?text ;
  final Function() onClick ;
  final Widget? child ;
  final double ? borderWidth ;
  final double ? radius ;
  final Color ? textColor ;
  final Color ? strokeColor ;
  final double ? height ;
  final double ?width ;
  final EdgeInsetsGeometry  ? padding ;
  const AppOutlineButton({Key? key,this.radius,this.borderWidth, this.height , this.width , this.text,required this.onClick, this.child ,this.padding , this.strokeColor, this.textColor}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  OutlinedButton(
      onPressed:onClick,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(kPrimaryDark.withOpacity(0.4)),
        textStyle: MaterialStateProperty.all(kTextLabelFontDark),
        padding:MaterialStateProperty.all(padding??const EdgeInsets.all(4)),
        side: MaterialStateProperty.all(BorderSide(color:strokeColor?? kPrimaryDark,width: borderWidth ?? 1.5)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 8.0),)),
      ),
      child: child==null ?Text(text!, style: kTextMedium.copyWith(fontSize: 14,color: textColor??kPrimaryDark),):child!,

    );
  }
}