import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:support/src/config/Themes/colors.dart';

import '../../../config/Themes/text_styles.dart';

class Item {
  int index;
  final String value;
  final String? description;
  Item({required this.index, required this.value , this.description});
}

class DropDownFiledCustom extends StatefulWidget {
  final Function(Item) onItemSelected;
  final Function(int)? onIndexSelected;
  final Widget Function(BuildContext context, int index)? itemBuilder;
  final String? header;
  final int? initIndex;
  final String? label;
  final String? hintText;
  final String? errorText;
  final bool? enabled;
  final Widget? prefix;
  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator<dynamic>? validator;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final List<String> items;
  final List<int>? disableItems;
  final bool isVisible;
  final TextStyle? labelStyle;
  final bool? isLabel;
  final InputDecoration? inputDecoration;

  DropDownFiledCustom(
      {this.label,
      this.hintText,
      this.errorText,
      this.enabled,
      this.margin,
      this.decoration,
      required this.items,
      required this.onItemSelected,
      this.labelStyle,
      this.isVisible = true,
      this.onIndexSelected,
      this.header,
      this.disableItems,
      this.prefix,
      this.initIndex,
      this.itemBuilder,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.validator,
      this.isLabel = true,
      this.inputDecoration
      })
      : super();
  @override
  State<StatefulWidget> createState() {
    return _DropdownFiled();
  }
}

class _DropdownFiled extends State<DropDownFiledCustom> {
  Item? selectedValue;
  bool headerAdded = false;
  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry margin =
        widget.margin != null ? widget.margin! : EdgeInsets.zero;
    final labelStyle = widget.labelStyle ??
        kTextMedium.copyWith(fontSize: 12, color: kPrimaryDark);
    List<Item> listItems = [];
    for (int i = 0; i < widget.items.length; i++) {
      int index = widget.header != null ? i + 1 : i;
      listItems.add(Item(index: index, value: widget.items[i]));
    }

    if (selectedValue == null && widget.initIndex != null) {
      print(
          'Start with SELECTED ${widget.initIndex} => ${widget.items[widget.initIndex!]}');
      int index = widget.initIndex!;
      if (widget.header != null) {
        index = index + 1;
      }
      selectedValue = Item(index: index, value: listItems[index].value);
      widget.onItemSelected(Item(
          index: widget.initIndex!, value: widget.items[widget.initIndex!]));
    }
    return widget.isVisible
        ? Padding(
            padding: margin,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /*  widget.label != null
                      ? Text(
                          widget.label!,
                          textAlign: TextAlign.start,
                          style: labelStyle,
                        )
                      : Container(),*/
                  SizedBox(
                    height: widget.label != null ? 10 : 0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(child: getAndroidPicker(listItems)),
                      ],
                    ),
                  ),
                ]))
        : Container();
  }

  Widget getAndroidPicker(List<Item> listItems) {
    print('Start with SELECTED ${selectedValue} => ${selectedValue}');
    if (widget.header != null) {
      listItems.insert(0, Item(index: 0, value: widget.header!));
    }
    return DropdownButtonFormField<Item>(
        isExpanded: true,
        autofocus: false,
        elevation: 16,
        autovalidateMode: widget.autovalidateMode,
        validator: widget.validator,
        iconSize: 0,
        decoration: widget.inputDecoration ?? kTextFieldDecoration.copyWith(
          label: widget.isLabel! ? Text(widget.label.toString()) : null,
          labelStyle: kTextLabelFontDark,
          floatingLabelStyle: kTextLabelFontDark.copyWith(color: kPrimaryDark),
          prefixIcon: widget.prefix,
          prefixIconConstraints: const BoxConstraints(maxWidth: 36),
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black45,
          ),
        ),
        onTap: () {
         // context.removeFocus();
        },
        value: selectedValue != null
            ? listItems
                .firstWhere((element) => element.index == selectedValue!.index)
            : null,
        onChanged: (value) {
          if (value!.index == 0 && widget.header != null) {
            print(
                'selectedValue transpo ${widget.disableItems!.contains(value.index)}');
          } else {
            setState(() {
              selectedValue = value;
            });
            Item realValue = Item(value: value.value, index: value.index);
            if (widget.header != null) {
              realValue.index = realValue.index - 1;
            }
            widget.onItemSelected(realValue);
          }
        },
        dropdownColor: Colors.white,
        items: getDropdownMenuItem(listItems));
  }

  List<DropdownMenuItem<Item>> getDropdownMenuItem(List<Item> list) {
    var dropdownMenuItemList = list.map<DropdownMenuItem<Item>>((Item value) {
      bool disabled = (widget.disableItems != null &&
          widget.disableItems!.contains(value.index));
      return DropdownMenuItem<Item>(
        value: value,
        child: value.index == 0 && widget.header != null
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  value.value.toString(),
                  style: kTextLabel.copyWith(color: kGreyColor, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
              )
            : widget.itemBuilder != null
                ? widget.itemBuilder!(context, value.index)
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      value.value.toString(),
                      style: kTextLabel.copyWith(
                          fontSize: 14, color: disabled ? kGreyColor : kPrimaryDark),
                      textAlign: TextAlign.start,
                    ),
                  ),
      );
    });
    return dropdownMenuItemList.toList();
  }
}
