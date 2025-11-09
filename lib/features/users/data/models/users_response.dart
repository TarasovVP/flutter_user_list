import 'package:json_annotation/json_annotation.dart';
import 'remote_user.dart';

part 'users_response.g.dart';

@JsonSerializable()
class UsersResponse {
  final List<RemoteUser> users;

  UsersResponse({required this.users});

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UsersResponseToJson(this);
}
