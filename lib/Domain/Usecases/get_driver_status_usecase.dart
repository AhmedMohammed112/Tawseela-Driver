import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twseela_driver/App/Constants/constants.dart';
import '../../Data/Network/failure.dart';
import '../../Presentation/Resources/values_manager.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class GetDriverStatusUsecase extends BaseUseCase<void,String> {
  final Repository repository;

  GetDriverStatusUsecase({required this.repository});

  @override
  Future<Either<Failure,String>> execute(input) {
    return repository.getDriverStatus();
  }
}
