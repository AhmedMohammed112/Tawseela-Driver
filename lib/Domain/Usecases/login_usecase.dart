import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Data/Network/failure.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class LoginUsecase extends BaseUseCase<LoginUseCaseInput, UserCredential> {
  final Repository repository;

  LoginUsecase({required this.repository});

  @override
  Future<Either<Failure, UserCredential>> execute(input) async {
    return await repository.signInWithEmailAndPassword(input);
  }
}

class LoginUseCaseInput
{
    final String? email;
    final String? password;

    LoginUseCaseInput({this.email,this.password});
}