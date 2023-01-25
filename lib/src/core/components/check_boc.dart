import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main_index.dart';

class MaterialCheckBox extends StatefulWidget {

  final String label ;

  const MaterialCheckBox({super.key, required this.label});
  @override
  _CopyRightsState createState() {
    return _CopyRightsState();
  }
}

class _CopyRightsState extends State<MaterialCheckBox> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            checked = (!checked);
            setState(() {});
          },
          child: Row(
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(end: 6, top: 16, bottom: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  border: Border.all(color: kBorderColor, width: 1.5),
                ),
                width: 20,
                height: 20,
                child: Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.transparent),
                  child: Checkbox(
                    checkColor: kBorderColor,
                    activeColor: Colors.transparent,
                    value: checked,
                    tristate: false,
                    shape: const CircleBorder(),
                    onChanged: (bool? value) {
                      checked = (value!);
                      setState(() {});
                    },
                  ),
                ),
              ),
              Text(widget.label,style: kTextLight.copyWith(fontSize: 18,color: kGreyColor),)
            ],
          ),
        ),
      ],
    );
  }
}
