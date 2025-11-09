import '../model/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers({bool forceRefresh = false});
}