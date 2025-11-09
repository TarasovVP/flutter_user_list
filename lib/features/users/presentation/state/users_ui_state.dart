import '../../domain/model/user.dart';

class UsersUiState {
  final bool isLoading;
  final List<User> users;
  final String? error;

  const UsersUiState({
    this.isLoading = false,
    this.users = const [],
    this.error,
  });

  UsersUiState copyWith({
    bool? isLoading,
    List<User>? users,
    String? error,
  }) {
    return UsersUiState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      error: error,
    );
  }
}
