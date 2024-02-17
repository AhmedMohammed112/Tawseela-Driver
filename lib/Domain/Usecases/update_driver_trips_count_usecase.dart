import 'package:dartz/dartz.dart';
import '../../Data/Network/failure.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class UpdateDriverTripsCountUsecase extends BaseUseCase<void,void> {
  final Repository repository;

  UpdateDriverTripsCountUsecase({required this.repository});

  @override
  Future<Either<Failure,void>> execute(input) {
    return repository.updateDriverTripsCount();
  }
}
