import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/network/graphql_client.dart';
import 'package:flutter_template/core/usecases/usecase.dart';
import 'package:flutter_template/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_template/features/auth/domain/entities/auth.entity.dart';
import 'package:flutter_template/features/auth/domain/repositories/auth.repository.dart';
import 'package:flutter_template/features/auth/domain/usecases/email_login.usecase.dart';
import 'package:flutter_template/features/auth/domain/usecases/get_user_profile.usecase.dart';

final authNotifier = ChangeNotifierProvider((ref) {
  return AuthProvider();
});

class AuthProvider extends ChangeNotifier {
  final GetEmailLogin getEmailLogin = GetEmailLogin(AuthRepositoryImpl());
  final GetUserProfile getUserProfile = GetUserProfile(AuthRepositoryImpl());

  Profile? profile;

  set setProfile(Profile p) {
    profile = p;
    notifyListeners();
  }

  void login() async {
    final response = await getEmailLogin
        .call(const Params(email: 'john', password: 'changeme'));

    response!.fold((l) => debugPrint('Login failed ${l}'),
        (r) => debugPrint('Login success ${r.accesstoken}'));
  }

  getProfile() async {
    final response = await getUserProfile.call(NoParams());
    response!.fold(
        (l) => debugPrint('User profile failed: ${l}'), (r) => setProfile = r);
  }

  getProfileGql() async {
    final query = await GraphQL().resolve('''{
                            profile {
                              username,
                              iat,
                              exp,
                              sub,
                              __typename
                            }
                          }''');
    if(query.hasException) {
      print(query.exception);
    } else {
      print(query.data);
    }
  }
}
