// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../data/repositories/authorization_repository_imp.dart' as _i6;
import '../data/source/remote/api/authorization_api.dart' as _i3;
import '../domain/repositories/authorization_repostiory.dart' as _i5;
import '../domain/usecases/auhorization/authoization_usecases.dart' as _i9;
import '../domain/usecases/auhorization/login_usescase.dart' as _i7;
import '../features/login/bloc/login_bloc.dart' as _i10;
import 'injection_module.dart' as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final injectionModule = _$InjectionModule();
  gh.factory<_i3.AuthorizationApi>(() => _i3.AuthorizationApi(get<_i4.Dio>()));
  gh.factory<_i5.AuthorizationRepository<dynamic>>(
      () => _i6.AuthorizationRepositoryImp(get<_i3.AuthorizationApi>()));
  gh.factory<_i7.LoginUseCase>(
      () => _i7.LoginUseCase(get<_i5.AuthorizationRepository<dynamic>>()));
  await gh.factoryAsync<_i8.SharedPreferences>(
    () => injectionModule.prefs,
    preResolve: true,
  );
  gh.factory<_i9.AuthorizationUseCases>(
      () => _i9.AuthorizationUseCases(loginUseCase: get<_i7.LoginUseCase>()));
  gh.factory<_i10.LoginBloc>(
      () => _i10.LoginBloc(get<_i9.AuthorizationUseCases>()));
  return get;
}

class _$InjectionModule extends _i11.InjectionModule {}
