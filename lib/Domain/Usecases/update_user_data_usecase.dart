import 'package:dartz/dartz.dart';
import 'package:twseela_driver/Domain/Usecases/register_usecase.dart';
import 'package:twseela_driver/Domain/Usecases/update_driver_data_usecase.dart';

import '../../Data/Network/failure.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class UpdateUserDataUsecase extends BaseUseCase<UpdateUserDataUseCaseInput,String> {
  final Repository repository;

  UpdateUserDataUsecase({required this.repository});

  @override
  Future<Either<Failure,String>> execute(input) {
    return repository.updateCurrentUserData(input);
  }
}