import '../../domain/model/user.dart';
import '../database/users_local_db.dart';
import '../mapper/user_entity_mapper.dart';

abstract class LocalUserDataSource {
  Future<List<User>> getUsers();
  Future<void> replaceAll(List<User> users);
}

class LocalUserDataSourceImpl implements LocalUserDataSource {
  final UsersLocalDb db;

  LocalUserDataSourceImpl(this.db);

  @override
  Future<List<User>> getUsers() async {
    final rows = await db.getAllUsers();
    return rows.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> replaceAll(List<User> users) async {
    final entries = users.map((u) => u.toEntity()).toList();
    await db.clearAndInsertAll(entries);
  }
}
