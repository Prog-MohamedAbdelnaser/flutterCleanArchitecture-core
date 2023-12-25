import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onPressed;
  final double? size;
  const AppIconButton({Key? key, required this.icon,  this.onPressed, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SvgPicture.asset(
        icon,
        height: size ?? 20,
        width: size ?? 20,
        color: Theme.of(context).appBarTheme.iconTheme!.color,
      )
    );
  }
}
