import 'package:flutter/material.dart';

import '../../domain/model/user.dart';
import 'user_avatar.dart';
import 'contact_field.dart';

class UserRow extends StatelessWidget {
  final User user;

  const UserRow({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserAvatar(
          imageUrl: user.image,
          description: '${user.firstName} ${user.lastName}',
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.firstName} ${user.lastName}',
                style: theme.textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Birth: ${user.birthDate} (${user.age} years old)',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 6),
              ContactField(
                icon: Icons.email_outlined,
                value: user.email,
              ),
              ContactField(
                icon: Icons.phone_outlined,
                value: user.phone,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
