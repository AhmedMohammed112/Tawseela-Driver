import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twseela_driver/App/Constants/constants.dart';
import '../../Data/Network/failure.dart';
import '../../Presentation/Resources/values_manager.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class RegisterUsecase extends BaseUseCase<UserDataUseCaseInput,UserCredential> {
  final Repository repository;

  RegisterUsecase({required this.repository});

  @override
  Future<Either<Failure,UserCredential>> execute(input) {
    return repository.createUserWithEmailAndPassword(input);
  }
}

class UserDataUseCaseInput
{
    final String name;
    final String email;
    final String phone;
    final String address;
    final String? password;
    final double? rating;
    final int? trips;
    final double? earnings;
    final List<ReviewUseCaseInput>? review;
    final VehicleUseCaseInput vehicle;
    // set default image url
    String? image;

  UserDataUseCaseInput(
      {
        this.rating = AppSizes.s0,
        this.trips = 0,
        this.earnings = AppSizes.s0,
        required this.vehicle,
        required this.name,
        required this.email,
        required this.phone,
        required this.address,
        this.password,
        this.image = AppConstants.defaultUserImage,
        this.review
      });

  Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['name'] = name;
      data['email'] = email;
      data['phone'] = phone;
      data['address'] = address;
      data['rating'] = rating;
      data['trips'] = trips;
      data['earnings'] = earnings;
      //data['review'] = review!.map((e) => e.toJson()).toList();
      data['vehicle'] = vehicle.toJson();
      data['image'] = image;
      return data;
    }
}

class VehicleUseCaseInput
{
  final String name;
  final String model;
  final String color;
  final String plateNumber;
  final String type;

  VehicleUseCaseInput({required this.name,required this.model,required this.color,required this.plateNumber,required this.type});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['model'] = model;
    data['color'] = color;
    data['plate_number'] = plateNumber;
    data['type'] = type;
    return data;
  }
}

class ReviewUseCaseInput
{
  final int rate;
  final String comment;

  ReviewUseCaseInput({required this.rate,required this.comment});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['comment'] = comment;
    return data;
  }
}