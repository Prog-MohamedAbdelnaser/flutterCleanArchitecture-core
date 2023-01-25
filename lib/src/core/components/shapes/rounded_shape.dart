import 'package:flutter/cupertino.dart';

import '../../../config/Themes/colors.dart';

class RoundedShape extends StatelessWidget {
  final Widget child ;
  final Color ? color ;
  final double ? height ;
  final double ? width ;
  final double   ? radius ;
  const RoundedShape({Key? key, this.color, required this.child ,this.height , this.width ,this.radius }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(height: height,width: width,
    alignment: AlignmentDirectional.center,
    decoration: BoxDecoration(
      color: color ?? kPrimaryDark.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(radius??14)),
    ),child: child,
    );
  }

}