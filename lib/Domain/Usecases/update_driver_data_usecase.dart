import 'package:dartz/dartz.dart';
import 'package:twseela_driver/Domain/Usecases/register_usecase.dart';

import '../../Data/Network/failure.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class UpdateUserDataUsecase extends BaseUseCase<UpdateUserDataUseCaseInput,String> {
  final Repository repository;

  UpdateUserDataUsecase({required this.repository});

  @override
  Future<Either<Failure,String>> execute(input) {
    return repository.updateCurrentUserData(input);
  }
}

class UpdateUserDataUseCaseInput
{
    final String name;
    final String email;
    final String phone;
    final String address;
    final VehicleUseCaseInput vehicle;
    String? image;

  UpdateUserDataUseCaseInput(
      {
        required this.vehicle,
        required this.name,
        required this.email,
        required this.phone,
        required this.address,
        this.image = "https://firebasestorage.googleapis.com/v0/b/twseela-2c9f0.appspot.com/o/Default%20Images%2Fuser.png?alt=media&token=3b9b9b1a-9b0a-4b0e-9e1a-9b8b8b8b8b8b",
      });

  Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['name'] = name;
      data['email'] = email;
      data['phone'] = phone;
      data['address'] = address;
      data['vehicle'] = vehicle.toJson();
      data['image'] = image;
      return data;
    }
}