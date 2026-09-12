import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user_entity.freezed.dart';

/// Профиль авторизованного пользователя.
///
/// Кешируется локально: имя и почта должны рисоваться офлайн и мгновенно
/// на старте, до ответа `/me`.
@freezed
sealed class AuthUserEntity with _$AuthUserEntity {
  const factory AuthUserEntity({
    required String id,
    required String email,

    /// Тариф: `free` | `pro`.
    required String plan,

    /// Имя из OAuth-профиля. Может отсутствовать.
    String? displayName,

    /// Аватар из OAuth-профиля.
    ///
    /// Навсегда nullable: у аккаунта без фото Google ничего не отдаст,
    /// а сами URL'ы периодически меняются и отдают 404. Инициалы —
    /// постоянный фолбэк, а не временная заглушка.
    String? avatarUrl,
  }) = _AuthUserEntity;

  const AuthUserEntity._();

  /// Что показывать в карточке профиля: имя, иначе часть почты до `@`.
  String get title {
    final name = displayName?.trim();
    if (name != null && name.isNotEmpty) return name;

    final local = email.split('@').first;

    return local.isEmpty ? email : local;
  }

  /// Инициалы для плашки-фолбэка аватара.
  String get initials {
    final words = title
        .split(RegExp(r'[\s._-]+'))
        .where((word) => word.isNotEmpty)
        .toList();
    if (words.isEmpty) return '?';

    final letters =
        words.take(2).map((word) => word[0].toUpperCase()).join();

    return letters.isEmpty ? '?' : letters;
  }
}
