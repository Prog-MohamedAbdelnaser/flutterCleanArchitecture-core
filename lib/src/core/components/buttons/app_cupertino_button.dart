import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main_index.dart';


class AppCupertinoButton extends StatelessWidget {
  final Function()? onPressed;
  final String ? text;
  final Widget ? child ;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Widget? startIcon;
  final double? height;
  final bool ?  enable;
  final double? elevation;
  final EdgeInsetsGeometry? startIconPadding;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? raduis;

  const AppCupertinoButton(
      {this.onPressed,
         this.text,
        this.backgroundColor,
        this.textStyle,
        this.enable =true,
        this.startIcon,
        this.padding,
        this.margin,
        this.raduis,
        this.height,
        this.child ,
        this.startIconPadding,
        this.elevation}):assert(text == null || child == null, 'Cannot provide both a text and a child');

  @override
  Widget build(BuildContext context) {

    Color enabledColor = backgroundColor != null
        ? backgroundColor!
        : context.theme.disabledColor;

    return Padding(
      padding: margin != null ? margin! : const EdgeInsets.all(0),
      child: CupertinoButton(
        padding: padding ?? const EdgeInsets.all(12),
        borderRadius: raduis ?? BorderRadius.circular(8),
        onPressed: enable==true ? onPressed:null,
        minSize: height,
        disabledColor: context.theme.primaryColor.withOpacity(0.5),
        color: enabledColor,
        child: child??_buildButton(context)
      ),
    );
  }
  Widget _buildButton(BuildContext context){
    return startIcon != null
        ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: startIconPadding != null
              ? startIconPadding!
              : const EdgeInsets.all(0.0),
          child: startIcon,
        ),
        Text(
          text??'',
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: textStyle ?? context.theme.textTheme.bodyMedium,
        ),
      ],
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text??'',
          style: textStyle ?? context.theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
