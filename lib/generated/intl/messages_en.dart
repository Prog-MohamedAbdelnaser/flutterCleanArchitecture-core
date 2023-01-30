// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(number) => "Gate number ${number}";

  static String m1(number) => "Required number ${number}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_new_employee":
            MessageLookupByLibrary.simpleMessage("Add new employee"),
        "email_or_userName":
            MessageLookupByLibrary.simpleMessage("Email / Username"),
        "forget_password":
            MessageLookupByLibrary.simpleMessage("Forget password"),
        "gate_number": m0,
        "gates": MessageLookupByLibrary.simpleMessage("Gates"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "invalid_email_or_user_name":
            MessageLookupByLibrary.simpleMessage("Invalid email or password"),
        "invalid_password":
            MessageLookupByLibrary.simpleMessage("Invalid password"),
        "login_button": MessageLookupByLibrary.simpleMessage("LOGIN"),
        "login_title": MessageLookupByLibrary.simpleMessage("LOG IN"),
        "more": MessageLookupByLibrary.simpleMessage("More"),
        "mosques": MessageLookupByLibrary.simpleMessage("Mosques"),
        "non_resident_employees":
            MessageLookupByLibrary.simpleMessage("Non resident employees"),
        "number_completed":
            MessageLookupByLibrary.simpleMessage("Number completed"),
        "ok_button": MessageLookupByLibrary.simpleMessage("Ok"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "remaining_number":
            MessageLookupByLibrary.simpleMessage("Remaining number"),
        "remember_me": MessageLookupByLibrary.simpleMessage("Remember me"),
        "required_number": m1,
        "resident_employees":
            MessageLookupByLibrary.simpleMessage("Resident employees"),
        "restaurants": MessageLookupByLibrary.simpleMessage("Restaurants"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "welcome_text": MessageLookupByLibrary.simpleMessage(
            "Welcome back our dear customer, we are glad to have you with us.")
      };
}
