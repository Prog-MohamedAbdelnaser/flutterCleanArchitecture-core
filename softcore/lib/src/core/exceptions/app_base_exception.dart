import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:platform/platform.dart';

abstract class AppBaseException implements Exception {
   String  get messageEn;
   String  get messageAr;

   @override
  String toString() {
     final  lang = Get.locale!.languageCode.toString() ;
     return  lang == "ar" ?messageAr : messageEn ;
  }

  String  toLocalizeMessage (){
     return '';
  }

  String toLocalize(String local) {
     return '';
  }
}
