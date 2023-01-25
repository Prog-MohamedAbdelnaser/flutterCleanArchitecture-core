import 'package:injectable/injectable.dart';

import '../../domain/repositories/authorization_repostiory.dart';
import '../source/remote/api/authorization_api.dart';

@Injectable(as: AuthorizationRepository)
class AuthorizationRepositoryImp implements AuthorizationRepository{

  final AuthorizationApi api ;
  AuthorizationRepositoryImp(this.api);

  @override
  Future<String> login(params) async {
    final response = await api.login(params);
    return response.payload!;
  }

  static AuthorizationRepository create(AuthorizationApi api) {
    return AuthorizationRepositoryImp(api);
  }

}