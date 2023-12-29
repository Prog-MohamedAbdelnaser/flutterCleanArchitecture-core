import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:platform/platform.dart';

import '../managers/app_error.dart';

class AppBaseException implements Exception {
  final  String   messageEn;
  final  String   messageAr;
  final ErrorType errorType ;

  AppBaseException({required this.errorType, required this.messageEn, required this.messageAr});

   String toLocalize(String local) {
     return  local == "ar" ?messageAr : messageAr ;
   }


   @override
   String toString() {
     final  lang = Get.locale!.languageCode.toString() ;
     return  lang == "ar" ?messageAr : messageEn ;
   }

   String toLocalizeMessage() {
     final  lang = Get.locale!.languageCode.toString() ;
     return toLocalize(lang);
   }

}
