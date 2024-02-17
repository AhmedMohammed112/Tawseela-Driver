import 'package:firebase_database/firebase_database.dart';

class BaseResponse
{
  String? message;

  BaseResponse({
    this.message,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      message: json['message'],
    );
  }
}

class CurrentUserDataResponse extends BaseResponse
{
  String? uid;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  String? image;
  double? rating;
  int? trips;
  double? earnings;
  List<ReviewResponse>? review;
  VehicleResponse? vehicle;

  CurrentUserDataResponse({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.image,
    required this.rating,
    required this.trips,
    required this.earnings,
    required this.review,
    required this.vehicle,
  });

  CurrentUserDataResponse.fromJson(DataSnapshot dataSnapshot) {
    uid = dataSnapshot.key;
    name = (dataSnapshot.value as dynamic)['name'];
    email = (dataSnapshot.value as dynamic)['email'];
    phoneNumber = (dataSnapshot.value as dynamic)['phone'];
    address = (dataSnapshot.value as dynamic)['address'];
    image = (dataSnapshot.value as dynamic)['image'];
    rating = double.parse((dataSnapshot.value as dynamic)['rating'].toString());
    trips = int.parse((dataSnapshot.value as dynamic)['trips'].toString());
    earnings = double.parse((dataSnapshot.value as dynamic)['earnings'].toString());
    review = (dataSnapshot.value as dynamic)['review'] != null ? (dataSnapshot.value as dynamic)['review'].map<ReviewResponse>((e) => ReviewResponse.fromJson(e)).toList() : [];
    vehicle = VehicleResponse.fromJson((dataSnapshot.value as dynamic)['vehicle']);
  }
}

class VehicleResponse {
  String? name;
  String? model;
  String? color;
  String? plateNumber;
  String? type;

  VehicleResponse({
    required this.name,
    required this.model,
    required this.color,
    required this.plateNumber,
    required this.type,
  });

  factory VehicleResponse.fromJson(Map<Object?, Object?> data) {
    Map<String, dynamic> json = data.cast<String, dynamic>();
    return VehicleResponse(
      name: json['name'],
      model: json['model'],
      color: json['color'],
      plateNumber: json['plate_number'],
      type: json['type'],
    );
  }
}

class ReviewResponse {
  String id;
  String name;
  String image;
  int rate;
  String comment;

  ReviewResponse({
    required this.id,
    required this.name,
    required this.image,
    required this.rate,
    required this.comment,
  });

  factory ReviewResponse.fromJson(Map<Object?, Object?> data) {
    Map<String, dynamic> json = data.cast<String, dynamic>();
    return ReviewResponse(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      rate: int.parse(json['rate'].toString()),
      comment: json['comment'],
    );
  }
}