import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../../core/constants.dart';
import '../../../features/users/data/users_api.dart';
import '../../../features/users/data/database/users_local_db.dart';
import '../../../features/users/data/datasource/local_user_data_source.dart';
import '../../../features/users/data/datasource/remote_user_data_source.dart';
import '../../../features/users/data/repository/user_repository_impl.dart';
import '../../../features/users/domain/repository/user_repository.dart';
import '../../../features/users/domain/usecase/get_user_list_use_case.dart';
import '../../../features/users/presentation/cubit/users_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {

  sl.registerLazySingleton<Dio>(
        () => Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );

  sl.registerLazySingleton<UsersApi>(
        () => UsersApi(sl<Dio>()),
  );

  sl.registerLazySingleton<UsersLocalDb>(
        () => UsersLocalDb(),
  );

  sl.registerLazySingleton<RemoteUserDataSource>(
        () => RemoteUserDataSourceImpl(sl<UsersApi>()),
  );

  sl.registerLazySingleton<LocalUserDataSource>(
        () => LocalUserDataSourceImpl(sl<UsersLocalDb>()),
  );

  sl.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(
      remote: sl<RemoteUserDataSource>(),
      local: sl<LocalUserDataSource>(),
    ),
  );

  sl.registerLazySingleton<GetUserListUseCase>(
        () => GetUserListUseCaseImpl(sl<UserRepository>()),
  );

  sl.registerFactory<UsersCubit>(
        () => UsersCubit(sl<GetUserListUseCase>()),
  );
}
