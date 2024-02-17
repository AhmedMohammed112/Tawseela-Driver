import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twseela_driver/App/Constants/constants.dart';
import '../../Data/Network/failure.dart';
import '../../Presentation/Resources/values_manager.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class SaveDriverEarningsUsecase extends BaseUseCase<double,void> {
  final Repository repository;

  SaveDriverEarningsUsecase({required this.repository});

  @override
  Future<Either<Failure,void>> execute(input) {
    return repository.updateDriverEarnings(input);
  }
}

