import 'package:flutter/material.dart';

import '../../../main_index.dart';
import '../helper/image_builder.dart';
import '../texts/material_text.dart';

class ListPickerItemWidget extends BaseStatelessWidget {
  //final Bank bank;
  final String name  ;
  final String ? logo;
  ListPickerItemWidget( {super.key, required this.name,  this.logo,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialText(
            name,
          style: kTextRegular.copyWith(color: kPrimaryDark,fontSize: 14),
          startIcon: kBuildCircleImage(logo.toString(), placeHolder: 'images/bank.png'),
          startIconPadding: const EdgeInsets.only(left: 8,right: 8),
        ),
        const Divider()
      ],
    );
  }
}