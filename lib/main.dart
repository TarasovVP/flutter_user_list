import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di/injection_container.dart';
import 'features/users/presentation/cubit/users_cubit.dart';
import 'features/users/presentation/pages/users_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersCubit>(
      create: (_) => sl<UsersCubit>(),
      child: MaterialApp(
        title: 'Flutter User List',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const UsersPage(),
      ),
    );
  }
}
