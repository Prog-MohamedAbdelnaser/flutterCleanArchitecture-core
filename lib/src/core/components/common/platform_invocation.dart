import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PlatFormInvocation{
  static const UPDATE_LOCAL_METHOD="updateLocal";
  static const CHANGE_LOCAL_METHOD="changeLocal";
  static const platform = const MethodChannel('com.sedk.fultter/channel');


  // static updateLanguage(BuildContext context){
  //   if(kIsWeb) return ;
  //   try {
  //     platform.invokeMethod(UPDATE_LOCAL_METHOD, {
  //       "lang": context
  //           .getLocal()
  //           .languageCode
  //     });
  //   }catch(e){
  //     print(e);
  //   }
  // }
  // static changeLanguage(String lang){
  //   try {
  //     platform.invokeMethod(CHANGE_LOCAL_METHOD, {
  //       "lang":lang
  //     });
  //   }catch(e){
  //     print(e);
  //   }
  // }
}