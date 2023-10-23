
import 'package:flutter_template/features/auth/domain/entities/auth.entity.dart';

class EmailLoginModel extends Login {
  const EmailLoginModel({required String accessToken})
      : super(accesstoken: accessToken);

  factory EmailLoginModel.fromJson(Map<String, dynamic> json) {
    return EmailLoginModel(
      accessToken: json['access_token']
    );
  }

  Map<String, dynamic> toJson() {
    return {'accessToken': accesstoken};
  }
}
