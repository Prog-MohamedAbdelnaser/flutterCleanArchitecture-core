import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:support/src/config/Themes/colors.dart';


Widget kBuildImage(String path, {double? size, double? border}) {
  print('kBuildImage $path');
  return Container(
    width: size ?? 40,
    height: size ?? 40,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: border == 0
            ? Border.all(style: BorderStyle.none)
            : Border.all(color: kBorderColor, width: border ?? 0.0)),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: FadeInImage.assetNetwork(
        fit: BoxFit.fill,
        placeholder: 'images/loading.gif',
        image: path,
        height: size ?? 40,
        width: size ?? 40,
        imageErrorBuilder: (c, o, s) {
          print('imageErrorBuilder error  $s ');
          return SizedBox(
            height: size ?? 40,
            width: size,
            child: Container(
                child: const Icon(
              Icons.info_rounded,
              color: kBorderColor,
            )),
          );
        },
      ),
    ),
  );
}

Widget kBuildImageFixedSize(String path, {double? width,double? height, double? border}) {
  print('kBuildImage $path');
  return Container(
    height: 200,
    width: 80,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: border == 0
            ? Border.all(style: BorderStyle.none)
            : Border.all(color: kBorderColor, width: border ?? 0.0)),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: FadeInImage.assetNetwork(
        placeholder: 'images/loading.gif',
        image: path,
        height: 300,
        imageErrorBuilder: (c, o, s) {
          print('imageErrorBuilder error  $s ');
          return SizedBox(
            child: Container(
                child: const Icon(
              Icons.image_not_supported_sharp,
              color: kBorderColor,
            )),
          );
        },
      ),
    ),
  );
}

Widget kBuildCircleImage(String path,
    {double? size, String? placeHolder, double? border,Color  ? borderColor}) {
  return Container(
    width: size ?? 40,
    height: size ?? 40,
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
        border: border == 0
            ? Border.all(style: BorderStyle.none)
            : Border.all(color: borderColor??kBorderColor, width: border ?? 0.0)),
    child: ClipOval(
      child: Container(
        child: FadeInImage.assetNetwork(
          fit: BoxFit.fill,
          placeholder: 'images/loading.gif',
          image: path,
          height: size ?? 40,
          width: size ?? 40,
          imageErrorBuilder: (c, o, s) {
            print('imageErrorBuilder error  $s ');
            return SizedBox(
              height: size ?? 40,
              width: size,
              child: const Icon(
                Icons.image,
                color: kBorderColor,
              ),
            );
          },
        ),
      ),
    ),
  );
}

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

Widget kBuildCircleImageFromFile(File file, {double? size}) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      border: Border.all(
        color: kGreyColor.withOpacity(0.5),
        width: 1.0,
      ),
    ),
    child: ClipOval(
      child: Image.file(
        file,
        fit: BoxFit.fitWidth,
        height: size ?? 40,
        width: size ?? 40,
      ),
    ),
  );
}

Widget kBuildCircleImageFromAsset(String path,
    {double? size, Color color = Colors.white}) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      border: Border.all(
        color: kGreyColor.withOpacity(0.5),
        width: 1.0,
      ),
    ),
    child: ClipOval(
      child: Image.asset(
        path,
        fit: BoxFit.fitWidth,
        height: size ?? 40,
        width: size != null ? (size - 8) : 40,
      ),
    ),
  );
}

Widget kBuildCircleShape(
    {Widget? child, double? size,Color? colorBorder, Color? color = Colors.white}) {
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      border: Border.all(color: colorBorder??kBorderColor,),
    ),
    child: child,
  );
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
