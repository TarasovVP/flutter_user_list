import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/users_response.dart';
import '../../../core/constants.dart';

part 'users_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class UsersApi {
  factory UsersApi(Dio dio, {String baseUrl}) = _UsersApi;

  @GET(Constants.usersEndpoint)
  Future<UsersResponse> getUsers();
}
