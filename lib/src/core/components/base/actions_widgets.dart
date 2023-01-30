import 'package:flutter/material.dart';
import 'package:support/src/config/Themes/colors.dart';
import 'package:support/src/config/assets/app_icons.dart';

import '../buttons/app_icon_button.dart';

class ActionsWidgets extends StatelessWidget {
  const ActionsWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIconButton(
          icon: AppIcons.tap,
          onPressed: () {},
        ),
        const SizedBox(width: 10,),
        AppIconButton(
          icon: AppIcons.notification,
          onPressed: () {},
        ),
        const SizedBox(width: 10,),
        AppIconButton(
          icon: AppIcons.calendar,
          onPressed: () {},
        ),
        const SizedBox(width: 10,),
        const VerticalDivider(
          color: kBackgroundColor,
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),
        const CircleAvatar(
          radius: 15,
          backgroundColor: Colors.white,
        ),
        const SizedBox(width: 10,),
        Text('مرحبا , حسن', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: kBackgroundColor, fontSize: 12),),
        const SizedBox(width: 10,),
        AppIconButton(
          icon: AppIcons.dropDown,
          size: 8,
          onPressed: () {},
        ),
        const SizedBox(width: 10,),
      ],
    );
  }
}
