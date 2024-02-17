import 'package:dartz/dartz.dart';
import '../../Data/Network/failure.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class UpdateDriverLocationUsecase extends BaseUseCase<UpdateDriverLocationOnRequestUsecaseData,void> {
  final Repository repository;

  UpdateDriverLocationUsecase({required this.repository});

  @override
  Future<Either<Failure,void>> execute(input) {
    return repository.updateDriverLocationOnRequest(input);
  }
}


class UpdateDriverLocationOnRequestUsecaseData {
  String? requestId;
  double? latitude;
  double? longitude;

  UpdateDriverLocationOnRequestUsecaseData({required this.requestId,required this.latitude,required this.longitude});
}