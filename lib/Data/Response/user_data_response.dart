import 'package:firebase_database/firebase_database.dart';

import 'current_user_info-response.dart';

class UserDataResponse extends BaseResponse
{
  String? uid;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  String? image;
  int? trips;
  int? freeTrips;
  List<dynamic>? discounts;

  UserDataResponse({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.image,
    required this.trips,
    required this.freeTrips,
    required this.discounts,
  });

  UserDataResponse.fromJson(DataSnapshot dataSnapshot) {
    uid = dataSnapshot.key;
    name = (dataSnapshot.value as dynamic)['name'];
    email = (dataSnapshot.value as dynamic)['email'];
    phoneNumber = (dataSnapshot.value as dynamic)['phone'];
    address = (dataSnapshot.value as dynamic)['address'];
    image = (dataSnapshot.value as dynamic)['image'];
    trips = (dataSnapshot.value as dynamic)['trips'];
    freeTrips = (dataSnapshot.value as dynamic)['free_trips'];
    discounts = (dataSnapshot.value as dynamic)['discounts']?.map((e) => e as int).toList();
  }
}