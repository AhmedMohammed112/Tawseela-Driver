import 'package:dartz/dartz.dart';
import '../../Data/Network/failure.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class CancelTripUsecase extends BaseUseCase<String,void> {
  final Repository repository;

  CancelTripUsecase({required this.repository});

  @override
  Future<Either<Failure,void>> execute(input) {
    return repository.cancelTrip(input);
  }
}
