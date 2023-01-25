import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:support/src/config/Themes/colors.dart';

import '../../../config/Themes/text_styles.dart';
import '../drop_down/slide_animation.dart';
import '../text_field/material_text_field.dart';

Widget buildSearchWidget(
    {required Function(String text) onChange,
    required String hint,
    TextEditingController? controller}) {
  return MaterialTextField(
    style: kTextRegular.copyWith(fontSize: 13),
    controller: controller,
    onChanged: onChange,
    inputDecoration: kTextFieldDecoration.copyWith(
        prefixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(start: 16, end: 8),
          child: SvgPicture.asset(
            'images/ic_search.svg',
            width: 15,
            height: 15,
          ),
        ),
        hintText: hint,
        contentPadding: const EdgeInsetsDirectional.only(start: 16, end: 16),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 15,
        ),
        hintStyle:
            kTextRegular.copyWith(fontSize: 10, color: kGreyColor)),
  );
}

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
                              style: kTextSemiBold.copyWith(fontSize: 18),
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
                    color: kGreyColor,
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