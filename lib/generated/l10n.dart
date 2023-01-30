// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok_button {
    return Intl.message(
      'Ok',
      name: 'ok_button',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back our dear customer, we are glad to have you with us.`
  String get welcome_text {
    return Intl.message(
      'Welcome back our dear customer, we are glad to have you with us.',
      name: 'welcome_text',
      desc: '',
      args: [],
    );
  }

  /// `LOG IN`
  String get login_title {
    return Intl.message(
      'LOG IN',
      name: 'login_title',
      desc: '',
      args: [],
    );
  }

  /// `Email / Username`
  String get email_or_userName {
    return Intl.message(
      'Email / Username',
      name: 'email_or_userName',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get remember_me {
    return Intl.message(
      'Remember me',
      name: 'remember_me',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get login_button {
    return Intl.message(
      'LOGIN',
      name: 'login_button',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password`
  String get invalid_password {
    return Intl.message(
      'Invalid password',
      name: 'invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `Forget password`
  String get forget_password {
    return Intl.message(
      'Forget password',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email or password`
  String get invalid_email_or_user_name {
    return Intl.message(
      'Invalid email or password',
      name: 'invalid_email_or_user_name',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Gates`
  String get gates {
    return Intl.message(
      'Gates',
      name: 'gates',
      desc: '',
      args: [],
    );
  }

  /// `Mosques`
  String get mosques {
    return Intl.message(
      'Mosques',
      name: 'mosques',
      desc: '',
      args: [],
    );
  }

  /// `Restaurants`
  String get restaurants {
    return Intl.message(
      'Restaurants',
      name: 'restaurants',
      desc: '',
      args: [],
    );
  }

  /// `Required number {number}`
  String required_number(dynamic number) {
    return Intl.message(
      'Required number $number',
      name: 'required_number',
      desc: 'Gate number',
      args: [number],
    );
  }

  /// `Gate number {number}`
  String gate_number(dynamic number) {
    return Intl.message(
      'Gate number $number',
      name: 'gate_number',
      desc: 'Gate number',
      args: [number],
    );
  }

  /// `Resident employees`
  String get resident_employees {
    return Intl.message(
      'Resident employees',
      name: 'resident_employees',
      desc: '',
      args: [],
    );
  }

  /// `Non resident employees`
  String get non_resident_employees {
    return Intl.message(
      'Non resident employees',
      name: 'non_resident_employees',
      desc: '',
      args: [],
    );
  }

  /// `Add new employee`
  String get add_new_employee {
    return Intl.message(
      'Add new employee',
      name: 'add_new_employee',
      desc: '',
      args: [],
    );
  }

  /// `Remaining number`
  String get remaining_number {
    return Intl.message(
      'Remaining number',
      name: 'remaining_number',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Number completed`
  String get number_completed {
    return Intl.message(
      'Number completed',
      name: 'number_completed',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
