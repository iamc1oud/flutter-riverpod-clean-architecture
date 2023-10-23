import 'package:flutter_template/features/auth/domain/entities/auth.entity.dart';

class ProfileModel extends Profile {
  ProfileModel(
      {required super.sub,
      required super.username,
      required super.issuedAt,
      required super.expireAt});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        expireAt: json['exp'],
        issuedAt: json['iat'],
        sub: json['sub'],
        username: json['username']);
  }

  Map<String, dynamic> toJson() {
    return {"sub": sub, "username": username, "iat": issuedAt, "exp": expireAt};
  }
}
