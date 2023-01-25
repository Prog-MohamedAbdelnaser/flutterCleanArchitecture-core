import 'package:dio/src/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class InjectionModule {

//injecting third party libraries
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

}