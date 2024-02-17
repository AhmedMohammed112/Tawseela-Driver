import 'package:dartz/dartz.dart';

import '../../Data/Network/failure.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class LogoutUsecase extends BaseUseCase<void,void> {
  final Repository repository;

  LogoutUsecase({required this.repository});

  @override
  Future<Either<Failure,void>> execute(input) {
    return repository.logout();
  }
}