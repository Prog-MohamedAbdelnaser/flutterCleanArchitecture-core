import 'package:injectable/injectable.dart';

import 'login_usescase.dart';

@injectable
class AuthorizationUseCases {
  final LoginUseCase loginUseCase ;
  AuthorizationUseCases({required this.loginUseCase});
}