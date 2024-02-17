import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:http/http.dart' as http;
import 'package:twseela_driver/Data/Response/user_data_response.dart';
import '../../App/Constants/constants.dart';
import '../../Domain/Usecases/get_direction_info_usecase.dart';
import '../../Domain/Usecases/login_usecase.dart';
import '../../Domain/Usecases/register_usecase.dart';
import '../../Domain/Usecases/update_driver_data_usecase.dart';
import '../../Domain/Usecases/update_driver_location_usecase.dart';
import '../../Domain/Usecases/update_trip_history.dart';
import '../Network/network_helper.dart';
import '../Response/authentication_response.dart';
import '../Response/current_user_info-response.dart';
import '../Response/direction_details_info_response.dart';
import '../Response/formated_address_response.dart';
import '../Response/place_autocomplete_response.dart';
import '../Response/place_details_response.dart';
import '../Response/ride_request_data_response.dart';



class AppServiceClientFirebaseApi {
// create user
  Future<AuthenticationResponse> createUserWithEmailAndPassword(
      UserDataUseCaseInput data) async {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data.email, password: data.password!);

      await FirebaseDatabase.instance
          .ref()
          .child(AppConstants.driverEndPoint)
          .child(userCredential.user!.uid)
          .set(
            data.toJson(),
          );
      return AuthenticationResponse(
          message: "Success", userCredential: userCredential);
  }

// sign in user
  Future<AuthenticationResponse> signInWithEmailAndPassword(
      LoginUseCaseInput data) async {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: data.email!, password: data.password!);
      return AuthenticationResponse(
          message: "Success", userCredential: userCredential);
  }

  // forgot password
  Future<String> forgotPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    return "Email sent";
  }

  //get user data from firebase database
  Future<CurrentUserDataResponse> getDriverData(String uid) async {
    DatabaseReference dataSnapshot =
        FirebaseDatabase.instance.ref().child(AppConstants.driverEndPoint).child(uid);
    DatabaseEvent snapshot = await dataSnapshot.once();
    return CurrentUserDataResponse.fromJson(snapshot.snapshot) .. message = "200";
  }

  // logout user
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // update user data
  Future<String> updateUserData(UpdateUserDataUseCaseInput data) async {
    print("data: ${data.toJson()}");
      await FirebaseDatabase.instance
          .ref()
          .child(AppConstants.driverEndPoint)
          .child(FirebaseAuth.instance.currentUser!.uid)
          .update(data.toJson()).then((value) {
        return "OK";
      }).catchError((e) {
        return e.toString();
      });
    return "OK";
  }

  Future<void> cancelTrip(String rideRequestId) async {
        FirebaseDatabase.instance.ref().child(AppConstants.requestsEndPoint).child(rideRequestId).child('trip_status').set('Cancelled by driver');
  }

  Future<void> updateTripStatus(UpdateTripStatusUsecasedata data) async {
    if(data.status == 'accepted') {
      FirebaseDatabase.instance.ref().child(AppConstants.requestsEndPoint).child(data.rideRequestId).child('driver_id').set(FirebaseAuth.instance.currentUser!.uid);
    }
    FirebaseDatabase.instance.ref().child(AppConstants.requestsEndPoint).child(data.rideRequestId).child('trip_status').set(data.status);
  }

  Future<void> updateDriverStatus(String status) async {
    FirebaseDatabase.instance.ref().child(AppConstants.driverEndPoint).child(FirebaseAuth.instance.currentUser!.uid).child('newRideStatus').set(status);
  }

  Future<String> getDriverStatus() async {
      DatabaseReference dataSnapshot = FirebaseDatabase.instance.ref().child(AppConstants.driverEndPoint).child(FirebaseAuth.instance.currentUser!.uid).child('newRideStatus');
      DatabaseEvent snapshot = await dataSnapshot.once();
      return snapshot.snapshot.value.toString();
  }

  Future<void> saveDriverEarnings(double earnings) async {
    FirebaseDatabase.instance.ref().child(AppConstants.driverEndPoint).child(FirebaseAuth.instance.currentUser!.uid).child("earnings").once().then((snap) {
      if(snap.snapshot.value == null) {
        FirebaseDatabase.instance.ref().child(AppConstants.driverEndPoint).child(FirebaseAuth.instance.currentUser!.uid).child("earnings").set(earnings);
      }
      else {
        double oldEarnings = double.parse(snap.snapshot.value.toString());
        double newEarnings = oldEarnings + earnings;
        FirebaseDatabase.instance.ref().child(AppConstants.driverEndPoint).child(FirebaseAuth.instance.currentUser!.uid).child("earnings").set(newEarnings);
      }
    });
  }

  Future<void> updateDriverTripsCount() async {
    FirebaseDatabase.instance.ref().child(AppConstants.driverEndPoint).child(FirebaseAuth.instance.currentUser!.uid).child('trips').once().then((snapshot) {
      int tripsCount = int.parse(snapshot.snapshot.value.toString());
      tripsCount++;
      FirebaseDatabase.instance.ref().child(AppConstants.driverEndPoint).child(FirebaseAuth.instance.currentUser!.uid).child('trips').set(tripsCount);
    });
  }

  Future<void> saveDeviceToken(String token) async {
    FirebaseDatabase.instance.ref().child("drivers").child(FirebaseAuth.instance.currentUser!.uid).child("token").set(token);
  }

  Future<void> updateDriverLocationOnRequest(UpdateDriverLocationOnRequestUsecaseData data) async {
    FirebaseDatabase.instance.ref().child("All Ride Requests").child(data.requestId!).child("driver_location").set({
      "latitude": data.latitude,
      "longitude": data.longitude,
    });
  }

  Future<UserDataResponse> getUserData(String userId) async {
    DatabaseReference dataSnapshot =
        FirebaseDatabase.instance.ref().child("users").child(userId);
    DatabaseEvent snapshot = await dataSnapshot.once();
    return UserDataResponse.fromJson(snapshot.snapshot);
  }

  Future<RideRequestDataResponse> getRideRequestData(String rideRequestId) async {
      return FirebaseDatabase.instance.ref().child("All Ride Requests").child(rideRequestId).once().then((value) => RideRequestDataResponse.fromJson(value.snapshot));
  }

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  DatabaseReference listenToRideRequest(String rideRequestId) {
    return _databaseReference.child(AppConstants.requestsEndPoint).child(rideRequestId);
  }

  DatabaseReference getRequestDriverId(String rideRequestId) {
    return FirebaseDatabase.instance.ref().child(AppConstants.requestsEndPoint).child(rideRequestId);
  }



  // get formatted address
  Future<FormattedAddressResponse> getFormattedAddress(
      double latitude, double longitude) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=${AppConstants.apiKey}";
    final response = await http.get(Uri.parse(url));
    return FormattedAddressResponse.fromJson(response) .. statusCode = response.statusCode .. message = response.reasonPhrase;
  }

  // get place autocomplete
  Future<PlaceAutocompleteResponse> getPlaceAutocomplete(String query) async {
    Uri uri =
        Uri.https("maps.googleapis.com", 'maps/api/place/autocomplete/json', {
      "input": query,
      "key": AppConstants.apiKey,
    });

    final response = await NetworkUtilities.fetchUrl(uri);
    return PlaceAutocompleteResponse.parseAutocompleteResponse(response!);
  }

  // get place details
  Future<PlaceDetailsResponse> getPlaceDetails(String placeID) async {
    Uri uri = Uri.https("maps.googleapis.com", 'maps/api/place/details/json', {
      "place_id": placeID,
      "key": AppConstants.apiKey,
    });

    final response = await http.get(uri);

    return PlaceDetailsResponse.fromJson(response.body) .. statusCode = response.statusCode .. message = response.reasonPhrase;
  }


  Future<DirectionDetailsInfoResponse> getDirectionDetailsInfo(DirectionDetailsInfoUsecaseParams params) async {
    final url = "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${params.destination.latitude},${params.destination.longitude}&origins=${params.origin.latitude},${params.origin.longitude}&units=imperial&key=${AppConstants.apiKey}";
    final response = await http.get(Uri.parse(url));
    return DirectionDetailsInfoResponse.fromJson(response.body) .. statusCode = response.statusCode .. message = response.reasonPhrase;
  }

  Future<List<RideRequestDataResponse>> getDriverTripsHistory() async {
      final List<RideRequestDataResponse> trips = [];
      return await FirebaseDatabase.instance
          .ref()
          .child(AppConstants.requestsEndPoint).
          orderByChild('driver_id').
          equalTo(FirebaseAuth.instance.currentUser!.uid).
          once().then((snapshot) {
            if (snapshot.snapshot.value != null) {
              for (var element in snapshot.snapshot.children) {
                trips.add(RideRequestDataResponse.fromJson(element));
              }
            }
            return trips;
          });
  }
}
