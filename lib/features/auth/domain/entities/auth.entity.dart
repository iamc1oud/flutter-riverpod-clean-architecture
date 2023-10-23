class Login {
  final String accesstoken;

  const Login({required this.accesstoken});
}

class Profile {
  final int sub;
  final String username;
  final num issuedAt;
  final num expireAt;

  const Profile(
      {required this.sub,
      required this.username,
      required this.issuedAt,
      required this.expireAt});
}
