import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:quizzerg/feature/auth/domain/entity/auth_user_entity.dart';

/// Аватар пользователя: фото из OAuth-профиля, иначе инициалы.
///
/// Инициалы — и `placeholder`, и `errorWidget`, а не временная заглушка:
/// `avatarUrl` может не прийти вовсе (у аккаунта нет фото), а выданные
/// Google ссылки периодически протухают в 404.
class ProfileAvatar extends StatelessWidget {
  final AuthUserEntity? user;
  final double size;

  const ProfileAvatar({required this.user, this.size = 60, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final url = user?.avatarUrl;

    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: ColoredBox(
          color: colorScheme.primaryContainer,
          child: url == null || url.isEmpty
              ? _Initials(user: user, size: size)
              : CachedNetworkImage(
                  imageUrl: url,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => _Initials(user: user, size: size),
                  errorWidget: (_, __, ___) => _Initials(
                    user: user,
                    size: size,
                  ),
                ),
        ),
      ),
    );
  }
}

class _Initials extends StatelessWidget {
  final AuthUserEntity? user;
  final double size;

  const _Initials({required this.user, required this.size});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        user?.initials ?? '?',
        style: TextStyle(
          fontSize: size * 0.37,
          fontWeight: FontWeight.w700,
          color: colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
