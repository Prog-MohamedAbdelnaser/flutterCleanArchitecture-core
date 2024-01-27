import 'package:get/get.dart';

import '../../../../main_index.dart';

class MaterialTextField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final String? label;

  final TextEditingController? controller ;
  final EdgeInsetsGeometry? margin ;
   final AutovalidateMode? autovalidateMode ;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode ;
  final double radius ;
  final bool ? enabled ;
  final TextStyle ?style ;
  final bool ?obscureText ;
  final bool ? readOnly ;
  final Color? color;
  final int maxLines ;
  final Widget ?startIcon ;
  final GestureTapCallback ? onTap;
  final String? initialValue;
  final InputDecoration ?inputDecoration ;
  final TextInputAction? textInputAction ;
  final TextInputType ?keyboardType ;
  final ValueChanged<String>? onChanged;
  const MaterialTextField({Key? key,this.style ,this.hintText,this.label,  this.controller, this.margin, this.autovalidateMode= AutovalidateMode.onUserInteraction, this.validator,
    this.focusNode, this.inputDecoration, this.keyboardType, this.onChanged, this.radius = 8, this.initialValue, this.enabled,
    this.color , this.obscureText, this.textInputAction = TextInputAction.next,this.startIcon, this.onTap, this.readOnly =false, this.maxLines=1, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: margin!=null?margin!:EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title!=null ?
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              title ?? '',
              style: context.textTheme.bodyMedium),
          ) : const SizedBox(),
          Row(
            children: [
              startIcon!=null ? startIcon! : Container(),
              Expanded(
                child: TextFormField(
                  textInputAction: textInputAction,
                  initialValue:initialValue ,
                  controller:controller ,
                  autovalidateMode:autovalidateMode ,
                  validator:validator,
                  onTap:onTap,
                  enabled: enabled,
                  cursorColor: context.theme.primaryColor,
                  style: style ?? context.textTheme.bodyMedium,
                  maxLines: maxLines,
                  readOnly: readOnly==true,
                  autofocus: false ,
                  showCursor: readOnly==true?false:true,
                  obscureText: obscureText==true,
                  onChanged:onChanged,
                  keyboardType: keyboardType,
                  decoration: inputDecoration!=null ? inputDecoration! :context.inputDecoration().copyWith(label:label!=null ? Text(label!):SizedBox.shrink(),hintText: hintText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
