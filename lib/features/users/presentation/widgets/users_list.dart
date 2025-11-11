import 'package:flutter/material.dart';

import '../../domain/model/user.dart';
import 'user_row.dart';

class UsersList extends StatelessWidget {
  final List<User> users;

  const UsersList({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final user = users[index];
        return UserRow(user: user);
      },
    );
  }
}
