// import 'package:flutter/material.dart';
// import 'package:support/src/config/Themes/colors.dart';
//
// import '../../../config/Themes/text_styles.dart';
// import '../decorations/decorations.dart';
//
//
//
//
// class DropDownCustom2 extends StatelessWidget {
//   final String? hint;
//   final String? value;
//   final List<DropdownMenuItem<Object>>? items;
//   final List<Widget> Function(BuildContext)? selectedItemBuilder;
//   final Function(Object?)? onChanged;
//   final String? Function(Object?)? validator;
//   const DropDownCustom2({Key? key, this.hint, this.value, this.items, this.selectedItemBuilder, this.onChanged, this.validator}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 4,
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(8),
//       child: DropdownButtonFormField2(
//         decoration: const InputDecoration(
//           //Add isDense true and zero Padding.
//           //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
//           isDense: true,
//           contentPadding: EdgeInsets.only(right: 10),
//           border: InputBorder.none,
//         ),
//         isDense: true,
//         isExpanded: true,
//         hint: Text(
//           hint ?? '',
//           style: kTextRegular.copyWith(color: kGreyColor, fontSize: 12),
//         ),
//         icon: const Icon(
//           Icons.keyboard_arrow_down,
//           color: kPrimaryDark,
//         ),
//         value: value,
//         selectedItemBuilder: selectedItemBuilder,
//         iconSize: 30,
//         buttonHeight: 48,
//         buttonPadding: const EdgeInsets.only(left: 20, right: 10),
//         dropdownDecoration: Decorations.boxDecorationShaded(),
//         items: items,
//         validator: validator,
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
