import 'package:firebase_database/firebase_database.dart';

class RideRequestDataResponse {
  String id;
  String userId;
  String driverId;
  String userName;
  String userPhone;
  String originAddress;
  double originLat;
  double originLng;
  String destinationAddress;
  double destinationLat;
  double destinationLng;
  String date;
  String? tripStatus;
  double? fareAmount;
  double? rating;

  RideRequestDataResponse({
    required this.id,
    required this.userId,
    required this.driverId,
    required this.userName,
    required this.userPhone,
    required this.originAddress,
    required this.originLat,
    required this.originLng,
    required this.destinationAddress,
    required this.destinationLat,
    required this.destinationLng,
    required this.date,
    this.tripStatus,
    this.fareAmount,
    this.rating,
  });

  factory RideRequestDataResponse.fromJson(DataSnapshot data) => RideRequestDataResponse(
    id: data.key!,
    userId: (data.value as dynamic)['user_id'] ?? '',
    driverId: (data.value as dynamic)['driver_id'],
    userName: (data.value as dynamic)['user_name'],
    userPhone: (data.value as dynamic)['user_phone'],
    originAddress: (data.value as dynamic)['origin_address'],
    originLat: (data.value as dynamic)['origin_lat'],
    originLng: (data.value as dynamic)['origin_lng'],
    destinationAddress: (data.value as dynamic)['destination_address'],
    destinationLat: (data.value as dynamic)['destination_lat'],
    destinationLng: (data.value as dynamic)['destination_lng'],
    date: (data.value as dynamic)['date'],
    tripStatus: (data.value as dynamic)['trip_status'] ?? '',
    fareAmount: double.parse(((data.value as dynamic)['fare_amount'] ?? 0.0).toString()),
    rating: (data.value as dynamic)['rate'] == null ? 0.0 : double.parse((data.value as dynamic)['rate'].toString()),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "driver_id": driverId,
    "user_name": userName,
    "user_phone": userPhone,
    "origin_address": originAddress,
    "origin_lat": originLat,
    "origin_lng": originLng,
    "destination_address": destinationAddress,
    "destination_lat": destinationLat,
    "destination_lng": destinationLng,
    "date": date,
    "trip_status": tripStatus,
    "fare_amount": fareAmount,
    "rating": rating,
  };

}
