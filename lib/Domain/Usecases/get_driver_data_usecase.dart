import 'package:dartz/dartz.dart';
import '../../Data/Network/failure.dart';
import '../Models/user_model.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class GetCurrentDriverInfoUsecase extends BaseUseCase<String,UserModel> {
  final Repository repository;

  GetCurrentDriverInfoUsecase({required this.repository});

  @override
  Future<Either<Failure,UserModel>> execute(input) async {
    return await repository.getCurrentUserData(input);
  }
}