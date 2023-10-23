import 'dart:convert';

import 'package:flutter_template/core/errors/exceptions.dart';
import 'package:flutter_template/core/network/http_client.dart';
import 'package:flutter_template/features/auth/data/models/email_login.model.dart';
import 'package:flutter_template/features/auth/data/models/profile.model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
  Future<EmailLoginModel> emailLogin({String username, String password});
  Future<ProfileModel> getProfile();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<EmailLoginModel> emailLogin({String? username, String? password}) async {
    try {
      final response = await ApiService()
          .post('/login', body: {"username": username, "password": password});
      

      SharedPreferences prefs = await SharedPreferences.getInstance();

      var r = EmailLoginModel.fromJson(response.data);
      prefs.setString('token', r.accesstoken);
      return r;
    } catch (e) {
      print('Error: $e');
      throw ServerException();
    }
  }

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final response = await ApiService().get(
        '/profile',
      );

      return ProfileModel.fromJson(response.data);
    } catch (e) {
      print('Error: $e');
      throw ServerException();
    }
  }
}
