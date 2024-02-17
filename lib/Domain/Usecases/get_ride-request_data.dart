import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:twseela_driver/App/Constants/constants.dart';
import 'package:twseela_driver/Domain/Models/ride_request_data.dart';
import '../../Data/Network/failure.dart';
import '../../Presentation/Resources/values_manager.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class GetRideRequestDataUsecase extends BaseUseCase<String,RideRequestData> {
  final Repository repository;

  GetRideRequestDataUsecase({required this.repository});

  @override
  Future<Either<Failure,RideRequestData>> execute(input) {
    return repository.getRideRequestData(input);
  }
}