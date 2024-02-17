import 'package:dartz/dartz.dart';
import 'package:twseela_driver/Domain/Models/ride_request_data.dart';

import '../../Data/Network/failure.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class GetDriverTripsHistoryUsecase extends BaseUseCase<void,List<RideRequestData>> {
  final Repository repository;

  GetDriverTripsHistoryUsecase({required this.repository});

  @override
  Future<Either<Failure,List<RideRequestData>>> execute(input) {
    return repository.getDriverTripsHistory();
  }
}