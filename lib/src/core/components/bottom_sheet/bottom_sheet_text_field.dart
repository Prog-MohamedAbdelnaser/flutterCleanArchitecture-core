import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:support/src/config/Themes/colors.dart';

import '../../../config/Themes/text_styles.dart';
import '../base_stateless_widget.dart';
import '../decorations/decorations.dart';
import '../drop_down/dropdown_filed.dart';
import '../helper/image_builder.dart';
import '../text_field/material_text_field.dart';
import 'list_picker_widget.dart';

class BottomSheetTextField extends BaseStatelessWidget {
  final String? title;
  final String? initValue;
  final String? hint;
  final FormFieldValidator<String>? validator;
  final Widget? icon;
  final List<Item> items;
  final Function(Item position) onSelectItem;
  final String? searchHint;
  final bool? setSearch;
  final Widget Function(BuildContext context, Item item)? itemBuilder;
  final InputDecoration ? inputDecoration ;
  final TextStyle? style;
  BottomSheetTextField(
      {required this.items,
      required this.onSelectItem,
      this.searchHint,
      this.setSearch,
      this.itemBuilder,
      this.icon,
        this.inputDecoration ,
      this.validator,
      this.title,
      this.hint,
      this.initValue,
      this.style
      });
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(initValue!=null){
      controller.text = initValue!;
    }
    return MaterialTextField(
      style: style,
      inputDecoration:inputDecoration!=null ?inputDecoration!.copyWith(
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(end: 20),
          child: kLoadSvgInCirclePath('arrow_down'),

        ),
          suffixIconConstraints: const BoxConstraints(maxHeight: 20, minWidth: 40),
          hintStyle: kTextRegular.copyWith(fontSize: 13, color: kGreyColor),
        hintText: hint
      ) : Decorations.commonDecoration(
          icon: icon,
          endIcon: Padding(
            padding: const EdgeInsetsDirectional.only(end: 20),
            child: kLoadSvgInCirclePath('arrow_down'),
          ),
          hint: hint),
      controller: controller,
      onTap: () {
        ListPickerWidget.showPicker(
            context: context,
            title: title ?? '',
            items: items,
            searchHint: searchHint,
            itemBuilder: itemBuilder,
            setSearch: setSearch,
            onSelectItem: (item) {
              controller.text = item.value;
              onSelectItem(item);
            });
      },
      validator: validator,
      readOnly: true,
    );
  }
}
