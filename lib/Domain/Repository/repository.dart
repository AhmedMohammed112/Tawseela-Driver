import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:twseela_driver/Domain/Models/ride_request_data.dart';
import '../../Data/Network/failure.dart';
import '../Models/direction_details_info.dart';
import '../Models/place_autocomplete_response_model.dart';
import '../Models/place_details_model.dart';
import '../Models/user_data.dart';
import '../Models/user_model.dart';
import '../Usecases/get_direction_info_usecase.dart';
import '../Usecases/login_usecase.dart';
import '../Usecases/register_usecase.dart';
import '../Usecases/update_driver_data_usecase.dart';
import '../Usecases/update_driver_location_usecase.dart';
import '../Usecases/update_trip_history.dart';

abstract class Repository
{
  Future<Either<Failure,UserCredential>> createUserWithEmailAndPassword(UserDataUseCaseInput data);
  Future<Either<Failure,UserCredential>> signInWithEmailAndPassword(LoginUseCaseInput data);
  Future<Either<Failure,String>> resetPassword(String email);
  Future<Either<Failure,UserModel>> getCurrentUserData(String uid);
  Future<Either<Failure,String>> updateCurrentUserData(UpdateUserDataUseCaseInput data);
  Future<Either<Failure,void>> logout();
  Future<Either<Failure,List<RideRequestData>>> getDriverTripsHistory();
  Future<Either<Failure,void>> cancelTrip(String rideRequestId);
  Future<Either<Failure,void>> updateTripStatus(UpdateTripStatusUsecasedata data);
  Future<Either<Failure,void>> updateDriverStatus(String status);
  Future<Either<Failure,void>> updateDriverEarnings(double earnings);
  Future<Either<Failure,void>> updateDriverTripsCount();
  Future<Either<Failure,void>> saveDeviceToken(String token);
  Future<Either<Failure,void>> updateDriverLocationOnRequest(UpdateDriverLocationOnRequestUsecaseData data);
  Future<Either<Failure,UserData>> getUserData(String userId);
  Future<Either<Failure,RideRequestData>> getRideRequestData(String rideRequestId);
  Future<Either<Failure,String>> getDriverStatus();
  Future<Either<Failure,DatabaseReference>> listenToRideRequest(String rideRequestId);
  Future<Either<Failure,DatabaseReference>> getRequestDriverId(String rideRequestId);


  Future<Either<Failure,String>> getFormattedAddress(double lat, double lng);
  Future<Either<Failure,PlaceAutocomplete>> getPredictions(String query);
Future<Either<Failure,PlaceDetails>> getPlaceDetails(String placeId);
  Future<Either<Failure,DirectionDetailsInfo>> getDirectionDetails(DirectionDetailsInfoUsecaseParams params);
}