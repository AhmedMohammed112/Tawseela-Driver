import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Data/Network/failure.dart';
import '../Models/place_autocomplete_response_model.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class GetPredictionsUsecase extends BaseUseCase<String,PlaceAutocomplete> {
  final Repository repository;

  GetPredictionsUsecase({required this.repository});

  @override
  Future<Either<Failure,PlaceAutocomplete>> execute(input) {
    return repository.getPredictions(input);
  }
}