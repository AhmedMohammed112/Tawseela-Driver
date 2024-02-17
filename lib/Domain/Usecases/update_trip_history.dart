import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twseela_driver/App/Constants/constants.dart';
import '../../Data/Network/failure.dart';
import '../../Presentation/Resources/values_manager.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class UpdateTripStatusUsecase extends BaseUseCase<UpdateTripStatusUsecasedata,void> {
  final Repository repository;

  UpdateTripStatusUsecase({required this.repository});

  @override
  Future<Either<Failure,void>> execute(input) {
    return repository.updateTripStatus(input);
  }
}

class UpdateTripStatusUsecasedata {
  final String rideRequestId;
  final String status;

  UpdateTripStatusUsecasedata({required this.rideRequestId,required this.status});
}