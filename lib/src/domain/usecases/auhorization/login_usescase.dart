import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/usecase/usecase.dart';
import '../../repositories/authorization_repostiory.dart';

@Injectable()
class LoginUseCase extends UseCase<String, dynamic>{
  final AuthorizationRepository repository ;
  LoginUseCase(this.repository);

  @override
  Future<String> call({params}) {
    return repository.login(params);
  }

}