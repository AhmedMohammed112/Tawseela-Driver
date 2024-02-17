import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twseela_driver/App/Constants/constants.dart';
import '../../Data/Network/failure.dart';
import '../../Presentation/Resources/values_manager.dart';
import '../Models/user_data.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class GetUserDataUsecase extends BaseUseCase<String,UserData> {
  final Repository repository;

  GetUserDataUsecase({required this.repository});

  @override
  Future<Either<Failure,UserData>> execute(input) {
    return repository.getUserData(input);
  }
}