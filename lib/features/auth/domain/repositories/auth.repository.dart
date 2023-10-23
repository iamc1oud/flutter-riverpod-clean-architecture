import 'package:dartz/dartz.dart';
import 'package:flutter_template/core/errors/failures.dart';
import 'package:flutter_template/features/auth/domain/entities/auth.entity.dart';

abstract class AuthRepository {
  // Either login will fail or access token is received.
  Future<Either<Failure, Login>> login({required String email,required String password});
  Future<Either<Failure, Profile>> profile();
}