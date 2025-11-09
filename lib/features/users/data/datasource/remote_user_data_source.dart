import '../models/remote_user.dart';
import '../users_api.dart';

abstract class RemoteUserDataSource {
  Future<List<RemoteUser>> fetchUsers();
}

class RemoteUserDataSourceImpl implements RemoteUserDataSource {
  final UsersApi api;

  RemoteUserDataSourceImpl(this.api);

  @override
  Future<List<RemoteUser>> fetchUsers() async {
    final response = await api.getUsers();
    return response.users;
  }
}
