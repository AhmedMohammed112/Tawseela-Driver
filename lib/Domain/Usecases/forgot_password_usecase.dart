import 'package:dartz/dartz.dart';

import '../../Data/Network/failure.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class ForgotPasswordUsecase extends BaseUseCase<String,String> {
  final Repository repository;

  ForgotPasswordUsecase({required this.repository});

  @override
  Future<Either<Failure,String>> execute(input) async {
    return await repository.resetPassword(input);
  }
}