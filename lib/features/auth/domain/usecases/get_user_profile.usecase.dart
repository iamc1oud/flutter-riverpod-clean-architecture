import 'package:dartz/dartz.dart';
import 'package:flutter_template/core/errors/failures.dart';
import 'package:flutter_template/core/usecases/usecase.dart';
import 'package:flutter_template/features/auth/domain/entities/auth.entity.dart';
import 'package:flutter_template/features/auth/domain/repositories/auth.repository.dart';

class GetUserProfile implements UseCase<Profile, NoParams> {
  final AuthRepository repository;

  GetUserProfile(this.repository);

  @override
  Future<Either<Failure, Profile>?> call(NoParams params) async  {
    return await repository.profile();
  }
}