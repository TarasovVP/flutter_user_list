import '../../domain/model/user.dart';
import '../../domain/repository/user_repository.dart';
import '../datasource/local_user_data_source.dart';
import '../datasource/remote_user_data_source.dart';
import '../mapper/user_mapper.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteUserDataSource remote;
  final LocalUserDataSource local;

  UserRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<List<User>> getUsers({bool forceRefresh = false}) async {
    final cached = await local.getUsers();
    if (cached.isNotEmpty && !forceRefresh) return cached;

    final remoteUsers = await remote.fetchUsers();
    final fresh = remoteUsers.map((u) => u.toDomain()).toList();

    await local.replaceAll(fresh);
    return fresh;
  }
}
