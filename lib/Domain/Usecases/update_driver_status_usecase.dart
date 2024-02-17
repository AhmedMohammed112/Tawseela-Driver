import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twseela_driver/App/Constants/constants.dart';
import '../../Data/Network/failure.dart';
import '../../Presentation/Resources/values_manager.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class UpdateDriverStatusUsecase extends BaseUseCase<String,void> {
  final Repository repository;

  UpdateDriverStatusUsecase({required this.repository});

  @override
  Future<Either<Failure,void>> execute(input) {
    return repository.updateDriverStatus(input);
  }
}
