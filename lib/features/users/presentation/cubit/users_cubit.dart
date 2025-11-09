import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/user.dart';
import '../../domain/usecase/get_user_list_use_case.dart';
import '../state/users_ui_state.dart';

class UsersCubit extends Cubit<UsersUiState> {
  final GetUserListUseCase getUserListUseCase;

  UsersCubit(this.getUserListUseCase) : super(const UsersUiState()) {
    initialize();
  }

  Future<void> initialize() async {
    emit(state.copyWith(isLoading: true, error: null));

    List<User> cached = const [];
    try {
      cached = await getUserListUseCase.execute(forceRefresh: false);
    } catch (_) {

    }

    emit(
      state.copyWith(
        isLoading: false,
        error: null,
        users: cached,
      ),
    );

    try {
      final fresh = await getUserListUseCase.execute(forceRefresh: true);
      emit(
        state.copyWith(
          isLoading: false,
          error: null,
          users: fresh,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> refresh() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final fresh = await getUserListUseCase.execute(forceRefresh: true);
      emit(
        state.copyWith(
          isLoading: false,
          error: null,
          users: fresh,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }
}
