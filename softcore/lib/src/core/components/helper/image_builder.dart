import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';





Widget kBuildCircleImagePlaceHolder({double? scale, String? placeHolder}) {
  return ClipOval(
    child: Image.asset(
      placeHolder ?? 'images/user.png',
      scale: scale ?? 2.5,
    ),
  );
}

Widget kBuildCircleImageWithCash(String path,
    {double? size, String? placeHolder}) {
  return FadeInImage.assetNetwork(
    fit: BoxFit.fitWidth,
    image: path,
    placeholderScale: 3,
    placeholderCacheHeight: 10,
    height: size ?? 40,
    width: size ?? 40,
    imageErrorBuilder: (c, o, s) {
      print('imageErrorBuilder error ${s.toString()} }');
      return Container(
        width: size ?? 40,
        height: size ?? 40,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Image.asset(
          placeHolder ?? 'images/user.png',
          scale: 3,
        ),
      );
    },
    placeholder: placeHolder ?? 'images/user.png',
  );
}

Widget kBuildCircleContainer(
    {double? size, double? border, required Widget child}) {
  return Container(
    width: size ?? 40,
    height: size ?? 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 7,
          offset: const Offset(0, 3),
        )
      ],
    ),
    child: ClipOval(
      child: child,
    ),
  );
}

Widget kBuildCircleImageCard(
    {required String imagePath, double? size, double? padding}) {
  return kBuildCircleContainer(
      size: size ?? 60,
      child: Padding(
        padding: EdgeInsets.all(padding ?? 12.0),
        child: Image.network(
          imagePath,
          scale: 0.9,
        ),
      ));
}




Widget kLoadSvgInCircle(String path, {double? height, double? width}) {
  return SvgPicture.asset(
    'images/$path.svg',
    height: height,
    width: width,
  );
}

Widget kLoadSvgInCirclePath(String path, {double? height, double? width}) {
  return SvgPicture.asset(
    path,
    height: height,
    width: width,
  );
}
