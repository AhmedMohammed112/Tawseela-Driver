import 'package:dartz/dartz.dart';
import '../../Data/Network/failure.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class SaveDeviceTokenUsecase extends BaseUseCase<String,void> {
  final Repository repository;

  SaveDeviceTokenUsecase({required this.repository});

  @override
  Future<Either<Failure,void>> execute(input) {
    return repository.saveDeviceToken(input);
  }
}