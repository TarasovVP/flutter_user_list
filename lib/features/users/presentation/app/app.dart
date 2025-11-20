import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_user_list/core/constants.dart';

import '../../../../di/injection_container.dart';
import '../cubit/users_cubit.dart';
import '../pages/users_page.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersCubit>(
      create: (_) => sl<UsersCubit>(),
      child: MaterialApp(
        title: Constants.flutterUserList,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const UsersPage(),
      ),
    );
  }
}