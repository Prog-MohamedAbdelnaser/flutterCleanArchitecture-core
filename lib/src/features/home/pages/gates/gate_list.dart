import 'package:flutter/material.dart';

import '../../../../config/Themes/colors.dart';
import '../../../../core/components/base_stateless_widget.dart';
import '../../../../core/components/decorations/decorations.dart';
import 'header_gate_item.dart';

class GatesList extends StatelessWidget {
  const GatesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return GateItem();
      },
    );
  }
}

class GateItem extends BaseStatelessWidget {
  GateItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: Decorations.decorationWithGradient(
        boxShadow: [
          BoxShadow(
            color: kPrimaryLight.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderGateItem(),
          Divider(height: 30),
          Text('بوابة 1', style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kGreyColor)),
          const SizedBox(height: 10,),
          Text('المشروع النخيل مول', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: kPrimaryLight)),
        ],
      ),
    );
  }
}

