import 'package:dartz/dartz.dart';

import '../../Data/Network/failure.dart';
import '../Models/place_details_model.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';


class GetPlaceDetailsUsecase extends BaseUseCase<String,PlaceDetails> {
  final Repository repository;

  GetPlaceDetailsUsecase({required this.repository});

  @override
  Future<Either<Failure,PlaceDetails>> execute(input) {
    return repository.getPlaceDetails(input);
  }
}