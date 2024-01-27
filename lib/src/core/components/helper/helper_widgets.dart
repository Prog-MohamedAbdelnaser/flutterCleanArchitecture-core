import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../main_index.dart';
import '../slide_animation.dart';
import '../text_field/material_text_field.dart';


Future showAppModalBottomSheet(
    {required BuildContext context,
    bool? isScrollControlled = true,
    required Widget child,
    String? title,double ? topMargin,
    Widget? titleWidget,
      EdgeInsetsGeometry ?padding,
      double ?  radius ,

      bool? isDivider = true,
    }) {


 return  showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled == true,
      isDismissible: true,
      enableDrag: true,
      constraints: isScrollControlled == true ? null : const BoxConstraints(maxHeight: 500),
      backgroundColor: Colors.transparent,
      builder: (BuildContext builder) {
        return SlideAnimationWidget(
          child: Container(
              decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius??30.0),
                      topRight: Radius.circular(radius??30.0))),
              margin: isScrollControlled == true
                  ?  EdgeInsets.only(top:topMargin?? 100)
                  : EdgeInsets.zero,
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 40),
                        child: titleWidget ??
                            Text(
                              title ?? '',
                              style: context.textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                      )),
                      CloseButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  isDivider! ?
                  const Divider(

                  ) : const SizedBox(),
                  Expanded(
                    child: Padding(
                      padding:padding?? const EdgeInsetsDirectional.only(
                          start: 16, end: 16, top: 20),
                      child: child,
                    ),
                  ),
                ],
              )),
        );
      });
}