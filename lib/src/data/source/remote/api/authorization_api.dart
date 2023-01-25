import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/uitls/constants.dart';
import '../../../models/api_response.dart';

part 'authorization_api.g.dart';

@Injectable()
@RestApi(baseUrl: kBaseUrl)
abstract class AuthorizationApi {

  @factoryMethod
  factory AuthorizationApi(Dio dio) = _AuthorizationApi;

  @POST('/v2/FreeLancerInfoV/Login')
  Future<ApiResponse<String>> login(@Body() loginParams);

}
