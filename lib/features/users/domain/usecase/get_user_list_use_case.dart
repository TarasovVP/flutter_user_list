import '../model/user.dart';
import '../repository/user_repository.dart';

abstract class GetUserListUseCase {
  Future<List<User>> execute({bool forceRefresh = false});
}

class GetUserListUseCaseImpl implements GetUserListUseCase {
  final UserRepository repository;

  GetUserListUseCaseImpl(this.repository);

  @override
  Future<List<User>> execute({bool forceRefresh = false}) {
    return repository.getUsers(forceRefresh: forceRefresh);
  }
}