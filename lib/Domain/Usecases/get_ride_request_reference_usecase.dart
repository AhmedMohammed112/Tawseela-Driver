import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:twseela_driver/App/Constants/constants.dart';
import '../../Data/Network/failure.dart';
import '../../Presentation/Resources/values_manager.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class GetRideRequestReferenceUsecase extends BaseUseCase<String,DatabaseReference> {
  final Repository repository;

  GetRideRequestReferenceUsecase({required this.repository});

  @override
  Future<Either<Failure, DatabaseReference>> execute(input) async {
    return await repository.listenToRideRequest(input);
  }
}
