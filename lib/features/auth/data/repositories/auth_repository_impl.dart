import 'package:dartz/dartz.dart';
import 'package:flutter_template/core/errors/exceptions.dart';
import 'package:flutter_template/core/errors/failures.dart';
import 'package:flutter_template/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_template/features/auth/domain/entities/auth.entity.dart';
import 'package:flutter_template/features/auth/domain/repositories/auth.repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource = AuthRemoteDataSourceImpl();

  @override
  Future<Either<Failure, Login>> login(
      {required String email, required String password}) async {
    try {
      return Right(await remoteDataSource.emailLogin(username: email, password: password));
    } on ServerException catch (e) {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, Profile>> profile() async  {
    try {
      return Right(await remoteDataSource.getProfile());
    } on ServerException catch (e) {
      return Left(ServerFailure());
    }
  }
}
