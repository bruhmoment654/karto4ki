/// Пара токенов, как она лежит в защищённом хранилище.
class AuthTokenPair {
  final String accessToken;
  final String refreshToken;

  const AuthTokenPair({
    required this.accessToken,
    required this.refreshToken,
  });
}
