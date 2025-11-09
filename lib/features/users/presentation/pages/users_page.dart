import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/users_cubit.dart';
import '../state/users_ui_state.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: BlocBuilder<UsersCubit, UsersUiState>(
        builder: (context, state) {
          if (state.isLoading && state.users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null && state.users.isEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          }

          return RefreshIndicator(
            onRefresh: () => context.read<UsersCubit>().refresh(),
            child: ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.image),
                  ),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
