import 'package:dartz/dartz.dart';
import 'package:flutter_template/core/errors/failures.dart';
import 'package:flutter_template/core/usecases/usecase.dart';
import 'package:flutter_template/features/auth/domain/entities/auth.entity.dart';
import 'package:flutter_template/features/auth/domain/repositories/auth.repository.dart';
import 'package:equatable/equatable.dart';

class GetEmailLogin implements UseCase<Login, Params> {
  final AuthRepository repository;

  GetEmailLogin(this.repository);

  @override
  Future<Either<Failure, Login>?> call(Params params) async {
    return await repository.login(email: params.email, password: params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({required this.email, required this.password});
  
  @override
  List<Object?> get props => throw UnimplementedError();
}