import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MaterialText extends StatelessWidget {
  final Widget? startIcon;
  final Widget? endIcon;
  final String text;
  final TextAlign? textAlign ;
  final Widget? subText;
  final TextStyle? style;
  final bool? mathWidth ;
  final int ? lines ;
  final AlignmentGeometry  ?align ;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? startIconPadding;
  final EdgeInsetsGeometry? endIconPadding;
  final Decoration? decoration;
  const MaterialText(this.text,
      {this.startIcon,
      this.style, this.mathWidth = false,
      this.endIcon,
      this.margin,
        this.lines ,
        this.align ,
      this.startIconPadding,
      this.endIconPadding,
      this.decoration,
      this.padding,
      this.subText, this.textAlign});

  @override
  Widget build(BuildContext context) {
    var padd = margin != null ? margin : EdgeInsets.all(0);
    return Align(
      alignment: align??AlignmentDirectional.centerStart,
      child: Padding(
        padding: padd!,
        child: Container(
          decoration: decoration,
          child: Padding(
            padding: (padding != null ? padding! : EdgeInsets.all(0.0)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: (startIconPadding != null && startIcon != null
                      ? startIconPadding!
                      : EdgeInsets.all(0)),
                  child: startIcon,
                ),
                mathWidth ==false ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      text,
                      textAlign: textAlign,
                      maxLines: lines,
                      style: style,
                      softWrap: true,),
                    subText!=null ?subText!:Container()
                  ],
                ):
                Expanded(child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      text,
                      textAlign: textAlign,
                      maxLines: lines,
                      style: style,
                      softWrap: true,),
                    subText!=null ?subText!:Container()
                  ],
                ),
                ),
                Padding(
                  padding: (endIconPadding != null && endIcon != null
                      ? endIconPadding!
                      : EdgeInsets.all(0)),
                  child: endIcon,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
