import 'package:firebase_database/firebase_database.dart';
import 'package:twseela_driver/Data/Response/ride_request_data_response.dart';

import '../../Domain/Usecases/get_direction_info_usecase.dart';
import '../../Domain/Usecases/login_usecase.dart';
import '../../Domain/Usecases/register_usecase.dart';
import '../../Domain/Usecases/update_driver_data_usecase.dart';
import '../../Domain/Usecases/update_driver_location_usecase.dart';
import '../../Domain/Usecases/update_trip_history.dart';
import '../App_Service_Client/app_api.dart';
import '../Response/authentication_response.dart';
import '../Response/current_user_info-response.dart';
import '../Response/direction_details_info_response.dart';
import '../Response/formated_address_response.dart';
import '../Response/place_autocomplete_response.dart';
import '../Response/place_details_response.dart';
import '../Response/user_data_response.dart';

abstract class RemoteDataSource
{
    Future<AuthenticationResponse> createUserWithEmailAndPassword(UserDataUseCaseInput data);
    Future<AuthenticationResponse> signInWithEmailAndPassword(LoginUseCaseInput data);
    Future<String> resetPassword(String email);
    Future<CurrentUserDataResponse> getCurrentUserData(String uid);
    Future<String> updateCurrentUserData(UpdateUserDataUseCaseInput data);
    Future<void> logout();
    Future<List<RideRequestDataResponse>> getDriverTripsHistory();
    Future<void> cancelTrip(String rideRequestId);
    Future<void> updateTripStatus(UpdateTripStatusUsecasedata data);
    Future<void> updateDriverStatus(String status);
    Future<void> saveDriverEarnings(double earnings);
    Future<void> updateDriverTripsCount();
    Future<void> saveDeviceToken(String token);
    Future<void> updateDriverLocationOnRequest(UpdateDriverLocationOnRequestUsecaseData data);
    Future<UserDataResponse> getUserData(String userId);
    Future<RideRequestDataResponse> getRideRequestData(String rideRequestId);
    Future<String> getDriverStatus();
    DatabaseReference listenToRideRequest(String rideRequestId);
    DatabaseReference getRequestDriverId(String rideRequestId);


    Future<FormattedAddressResponse> getFormattedAddress(double lat, double lng);
    Future<PlaceAutocompleteResponse> getPlaceAutocomplete(String query);
    Future<PlaceDetailsResponse> getPlaceDetails(String placeId);
    Future<DirectionDetailsInfoResponse> getDirectionDetails(DirectionDetailsInfoUsecaseParams params);
}


class RemoteDataSourceImpl implements RemoteDataSource
{
  final AppServiceClientFirebaseApi _appServiceClientFirebaseApi;

  RemoteDataSourceImpl(this._appServiceClientFirebaseApi);

  @override
  Future<AuthenticationResponse> createUserWithEmailAndPassword(UserDataUseCaseInput data) async {
    return await _appServiceClientFirebaseApi.createUserWithEmailAndPassword(data);
  }

  @override
  Future<AuthenticationResponse> signInWithEmailAndPassword(LoginUseCaseInput data) async {
    return await _appServiceClientFirebaseApi.signInWithEmailAndPassword(data);
  }

  @override
  Future<String> resetPassword(String email) async {
    return await _appServiceClientFirebaseApi.forgotPassword(email);
  }

  @override
  Future<CurrentUserDataResponse> getCurrentUserData(String uid) async {
    return await _appServiceClientFirebaseApi.getDriverData(uid);
  }

  @override
  Future<void> logout() async {
    return await _appServiceClientFirebaseApi.logout();
  }

  @override
  Future<FormattedAddressResponse> getFormattedAddress(double lat, double lng) async {
    return await _appServiceClientFirebaseApi.getFormattedAddress(lat, lng);
  }

  @override
  Future<PlaceAutocompleteResponse> getPlaceAutocomplete(String query) async {
    return await _appServiceClientFirebaseApi.getPlaceAutocomplete(query);
  }

  @override
  Future<PlaceDetailsResponse> getPlaceDetails(String placeId) async {
    return await _appServiceClientFirebaseApi.getPlaceDetails(placeId);
  }

  @override
  Future<DirectionDetailsInfoResponse> getDirectionDetails(DirectionDetailsInfoUsecaseParams params) async {
    return await _appServiceClientFirebaseApi.getDirectionDetailsInfo(params);
  }

  @override
  Future<List<RideRequestDataResponse>> getDriverTripsHistory() async {
    return await _appServiceClientFirebaseApi.getDriverTripsHistory();
  }

  @override
  Future<String> updateCurrentUserData(UpdateUserDataUseCaseInput data) async {
    return await _appServiceClientFirebaseApi.updateUserData(data);
  }

  @override
  Future<void> cancelTrip(String rideRequestId) async {
    return await _appServiceClientFirebaseApi.cancelTrip(rideRequestId);
  }

  @override
  Future<void> updateTripStatus(UpdateTripStatusUsecasedata data) async {
    return await _appServiceClientFirebaseApi.updateTripStatus(data);
  }

  @override
  Future<void> saveDriverEarnings(double earnings) async {
    return await _appServiceClientFirebaseApi.saveDriverEarnings(earnings);
  }

  @override
  Future<void> updateDriverTripsCount() async {
    return await _appServiceClientFirebaseApi.updateDriverTripsCount();
  }

  @override
  Future<void> updateDriverStatus(String status) async {
    return await _appServiceClientFirebaseApi.updateDriverStatus(status);
  }

  @override
  Future<void> saveDeviceToken(String token) async {
    return await _appServiceClientFirebaseApi.saveDeviceToken(token);
  }

  @override
  Future<void> updateDriverLocationOnRequest(UpdateDriverLocationOnRequestUsecaseData data) async {
    return await _appServiceClientFirebaseApi.updateDriverLocationOnRequest(data);
  }

  @override
  Future<UserDataResponse> getUserData(String userId) async {
    return await _appServiceClientFirebaseApi.getUserData(userId);
  }

  @override
  Future<RideRequestDataResponse> getRideRequestData(String rideRequestId) async {
    return await _appServiceClientFirebaseApi.getRideRequestData(rideRequestId);
  }

  @override
  Future<String> getDriverStatus() async {
    return await _appServiceClientFirebaseApi.getDriverStatus();
  }

  @override
  DatabaseReference listenToRideRequest(String rideRequestId) {
     return _appServiceClientFirebaseApi.listenToRideRequest(rideRequestId);
  }

  @override
  DatabaseReference getRequestDriverId(String rideRequestId) {
    return _appServiceClientFirebaseApi.getRequestDriverId(rideRequestId);
  }



}