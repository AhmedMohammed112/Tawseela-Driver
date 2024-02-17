import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Data/Network/failure.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';


class GetFormattedAddressUsecase extends BaseUseCase<LatLng,String> {
  final Repository repository;

  GetFormattedAddressUsecase({required this.repository});

  @override
  Future<Either<Failure,String>> execute(input) async {
    return await repository.getFormattedAddress(input.latitude, input.longitude);
  }
}