import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../config/Themes/colors.dart';
import '../../../config/Themes/text_styles.dart';
import '../base_stateless_widget.dart';

class OptionsMenuButton extends BaseStatelessWidget {
  final List<Widget>? options;
  final List<String>? optionsString;
  final Widget? title;
  final Widget? icon;
  final ShapeBorder? shape;
  final Function(int index) onSelect;
  OptionsMenuButton(
      {super.key, this.options,
        required this.onSelect,
        this.title,
        this.icon,
        this.optionsString,
        this.shape
      })
      : assert(options == null || optionsString == null,
  'Cannot provide both a optionsString and a options');
  @override
  Widget build(BuildContext context) {
    return buildOptions();
  }

  Widget buildOptions() {
    return PopupMenuButton(
        icon: icon,
        position: PopupMenuPosition.under,
        itemBuilder: (_) =>
        options != null ? optionItems() : optionItemsBuildWidget(),
        shape: shape ?? RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onSelected: (value) {
          onSelect(int.parse(value.toString()));
        },
        child: title);
  }

  List<PopupMenuItem> optionItemsBuildWidget() {
    final items = <PopupMenuItem>[];
    for (int i = 0; i < optionsString!.length; i++) {
      items.add(menuItem(menuItemWidget(optionsString![i]), i));
    }
    return items;
  }

  List<PopupMenuItem> optionItems() {
    final items = <PopupMenuItem>[];
    for (int i = 0; i < options!.length; i++) {
      items.add(menuItem(options![i], i));
    }
    return items;
  }

  PopupMenuItem menuItem(Widget child, int value) {
    return PopupMenuItem<int>(value: value, child: child);
  }

  Widget menuItemWidget(String name) {
    return Text(name,
        style: kTextRegular.copyWith(fontSize: 16, color: kGreyColor));
  }
}