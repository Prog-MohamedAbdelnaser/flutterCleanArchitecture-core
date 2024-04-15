import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcon extends StatelessWidget {
  final String icon;
  final double? size;
  final Color? color;
  const AppIcon({Key? key, required this.icon, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: size ?? 25,
      width: size ?? 25,
      color: color
    );
  }
}
