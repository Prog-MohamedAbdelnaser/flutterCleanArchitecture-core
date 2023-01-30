// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(number) => "البوابة رقم :  ${number}";

  static String m1(number) => "العدد المطلوب : ${number}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_new_employee":
            MessageLookupByLibrary.simpleMessage("إضافة موظف جديد"),
        "email_or_userName": MessageLookupByLibrary.simpleMessage(
            "البريد الإلكتروني / اسم المستخدم"),
        "forget_password":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور؟"),
        "gate_number": m0,
        "gates": MessageLookupByLibrary.simpleMessage("بوابات"),
        "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
        "invalid_email_or_user_name": MessageLookupByLibrary.simpleMessage(
            "البريد الإلكتروني / اسم المستخدم غير صحيح"),
        "invalid_password":
            MessageLookupByLibrary.simpleMessage("كلمة المرور غير صحيحة"),
        "login_button": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "login_title": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "more": MessageLookupByLibrary.simpleMessage("المزيد"),
        "mosques": MessageLookupByLibrary.simpleMessage("مساجد"),
        "non_resident_employees":
            MessageLookupByLibrary.simpleMessage("الموظفين الغير مسكنين"),
        "number_completed": MessageLookupByLibrary.simpleMessage("اكتمل العدد"),
        "ok_button": MessageLookupByLibrary.simpleMessage("موافق"),
        "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
        "remaining_number":
            MessageLookupByLibrary.simpleMessage("العدد المتبقي"),
        "remember_me": MessageLookupByLibrary.simpleMessage("تذكرني"),
        "required_number": m1,
        "resident_employees":
            MessageLookupByLibrary.simpleMessage("الموظفين مسكنين"),
        "restaurants": MessageLookupByLibrary.simpleMessage("مطاعم"),
        "today": MessageLookupByLibrary.simpleMessage("اليوم"),
        "welcome_text": MessageLookupByLibrary.simpleMessage(
            "مرحبََا بك مجددََا عميلنا العزيز, نحن سعداء بوجودك معنا")
      };
}
