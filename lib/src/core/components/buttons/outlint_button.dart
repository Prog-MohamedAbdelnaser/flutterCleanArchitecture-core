import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


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
        overlayColor: MaterialStateProperty.all(context.theme.primaryColor.withOpacity(0.4)),
        textStyle: MaterialStateProperty.all(context.textTheme.bodyMedium?.copyWith(color: context.theme.primaryColor)),
        padding:MaterialStateProperty.all(padding??const EdgeInsets.all(4)),
        side: MaterialStateProperty.all(BorderSide(color:strokeColor?? context.theme.primaryColor,width: borderWidth ?? 1.5)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 8.0),)),
      ),
      child: child==null ?Text(text!, style: context.textTheme.bodyMedium?.copyWith(color:textColor?? context.theme.primaryColor)):child!,

    );
  }
}