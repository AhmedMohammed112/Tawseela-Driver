import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:twseela_driver/Data/Mappers/mappers.dart';
import 'package:twseela_driver/Data/Network/error_handler.dart';
import 'package:twseela_driver/Domain/Models/ride_request_data.dart';
import 'package:twseela_driver/Domain/Models/user_data.dart';
import '../../Domain/Models/direction_details_info.dart';
import '../../Domain/Models/place_autocomplete_response_model.dart';
import '../../Domain/Models/place_details_model.dart';
import '../../Domain/Models/user_model.dart';
import '../../Domain/Repository/repository.dart';
import '../../Domain/Usecases/get_direction_info_usecase.dart';
import '../../Domain/Usecases/login_usecase.dart';
import '../../Domain/Usecases/register_usecase.dart';
import '../../Domain/Usecases/update_driver_data_usecase.dart';
import '../../Domain/Usecases/update_driver_location_usecase.dart';
import '../../Domain/Usecases/update_trip_history.dart';
import '../Network/connection_checker.dart';
import '../Network/failure.dart';
import '../Remote_Data_Source/remote_data_source.dart';

class RepositoryImplementer extends Repository
{
  final RemoteDataSource _remoteDataSource;
  final ConnectionCheckerImpl _connectionCheckerImpl;

  RepositoryImplementer(this._remoteDataSource, this._connectionCheckerImpl);


  @override
  Future<Either<Failure,UserCredential>> createUserWithEmailAndPassword(UserDataUseCaseInput data) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      final result = await _remoteDataSource.createUserWithEmailAndPassword(data);
      if(result.userCredential != null)
      {
        return Right(result.userCredential!);
      }
      else
      {
        return Left(Failure(message: result.message));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword(LoginUseCaseInput data) async{
    if(await _connectionCheckerImpl.hasConnection)
    {
      final result = await _remoteDataSource.signInWithEmailAndPassword(data);
      if(result.userCredential != null)
      {
        return Right(result.userCredential!);
      }
      else
      {
        return Left(Failure(message: result.message));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(String email) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      final result = await _remoteDataSource.resetPassword(email);
      if(result.isEmpty)
      {
        return Right(result);
      }
      else
      {
        return Left(Failure(message: "Failed to recovery"));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUserData(String uid) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      final result = await _remoteDataSource.getCurrentUserData(uid);
      if(result != null)
      {
        return Right(result.toDomain());
      }
      else
      {
        return Left(Failure(message: "Failed to get user data"));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      final result = await _remoteDataSource.logout();
        return Right(result);
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getFormattedAddress(double lat, double lng) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      final result = await _remoteDataSource.getFormattedAddress(lat, lng);
      if(result.statusCode == ResponseCode.SUCCESS)
      {
        return Right(result.formattedAddress);
      }
      else
      {
        return Left(Failure(message: result.message,code: result.statusCode!));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, PlaceAutocomplete>> getPredictions(String query) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      final result = await _remoteDataSource.getPlaceAutocomplete(query);
      if(result.statusCode == ResponseCode.SUCCESS)
      {
        return Right(result.toDomain());
      }
      else
      {
        return Left(Failure(code: result.statusCode!,message: result.message));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, PlaceDetails>> getPlaceDetails(String placeId) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      final result = await _remoteDataSource.getPlaceDetails(placeId);
      if(result.statusCode == ResponseCode.SUCCESS)
      {
        return Right(result.toDomain());
      }
      else
      {
        return Left(Failure(code: result.statusCode!,message: result.message));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }


  @override
  Future<Either<Failure, DirectionDetailsInfo>> getDirectionDetails(DirectionDetailsInfoUsecaseParams params) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      final result = await _remoteDataSource.getDirectionDetails(params);
      if(result.statusCode == ResponseCode.SUCCESS)
      {
        return Right(result.toDomain());
      }
      else
      {
        return Left(Failure(code: result.statusCode!,message: result.message));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<RideRequestData>>> getDriverTripsHistory() async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      try{
        final result = await _remoteDataSource.getDriverTripsHistory();
        return right(result.map((e) => e.toDomain()).toList());
      }
      catch(e)
      {
        return left(Failure(message: e.toString()));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateCurrentUserData(UpdateUserDataUseCaseInput data) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      final result = await _remoteDataSource.updateCurrentUserData(data);
      if(result == "OK")
      {
        return Right(result);
      }
      else
      {
        return Left(Failure(message: "Failed to update user data"));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> cancelTrip(String rideRequestId) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      try{
        await _remoteDataSource.cancelTrip(rideRequestId);
        return right("Success");
      }
      catch(e)
      {
        return left(Failure(message: e.toString()));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTripStatus(UpdateTripStatusUsecasedata data) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      try{
        await _remoteDataSource.updateTripStatus(data);
        return right("Success");
      }
      catch(e)
      {
        return left(Failure(message: e.toString()));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateDriverEarnings(double earnings) async {
        if(await _connectionCheckerImpl.hasConnection)
            {
              try{
                await _remoteDataSource.saveDriverEarnings(earnings);
                return right("Success");
              }
              catch(e)
              {
                return left(Failure(message: e.toString()));
              }
            }
            else
            {
              return Left(DataSource.NO_INTERNET.getFailure());
            }
          }

  @override
  Future<Either<Failure, void>> updateDriverTripsCount() async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      try{
        await _remoteDataSource.updateDriverTripsCount();
        return right("Success");
      }
      catch(e)
      {
        return left(Failure(message: e.toString()));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateDriverStatus(String status) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      try{
        await _remoteDataSource.updateDriverStatus(status);
        return right("Success");
      }
      catch(e)
      {
        return left(Failure(message: e.toString()));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveDeviceToken(String token) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      try{
        await _remoteDataSource.saveDeviceToken(token);
        return right("Success");
      }
      catch(e)
      {
        return left(Failure(message: e.toString()));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateDriverLocationOnRequest(UpdateDriverLocationOnRequestUsecaseData data) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      try{
        await _remoteDataSource.updateDriverLocationOnRequest(data);
        return right("Success");
      }
      catch(e)
      {
        return left(Failure(message: e.toString()));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }

  }

  @override
  Future<Either<Failure, UserData>> getUserData(String userId) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      try{
        final result = await _remoteDataSource.getUserData(userId);
        return right(result.toDomain());
      }
      catch(e)
      {
        return left(Failure(message: e.toString()));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, RideRequestData>> getRideRequestData(String rideRequestId) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      try{
        final result = await _remoteDataSource.getRideRequestData(rideRequestId);
        return right(result.toDomain());
      }
      catch(e)
      {
        return left(Failure(message: e.toString()));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getDriverStatus() async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      try{
        final result = await _remoteDataSource.getDriverStatus();
        return right(result);
      }
      catch(e)
      {
        return left(Failure(message: e.toString()));
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, DatabaseReference>> listenToRideRequest(String rideRequestId) async {
        if(await _connectionCheckerImpl.hasConnection)
        {
          try{
            final result = _remoteDataSource.listenToRideRequest(rideRequestId);
            return right(result);
          }
          catch(e)
          {
            return left(Failure(message: e.toString()));
          }
        }
        else
        {
          return left(DataSource.NO_INTERNET.getFailure());
        }
  }

  @override
  Future<Either<Failure, DatabaseReference>> getRequestDriverId(String rideRequestId) async {
    if(await _connectionCheckerImpl.hasConnection)
    {
      try{
        final result = _remoteDataSource.getRequestDriverId(rideRequestId);
        return right(result);
      }
      catch(e)
      {
        return left(Failure(message: e.toString()));
      }
    }
    else
    {
      return left(DataSource.NO_INTERNET.getFailure());
    }
  }

}