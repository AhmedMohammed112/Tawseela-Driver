import 'package:firebase_database/firebase_database.dart';

class UserModel
{
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? image;
  double rating = 0.0;
  int? trips = 0;
  double earnings = 0.0;
  List<Review> review = [];
  Vehicle? vehicle;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.image,
    required this.vehicle,
    required this.rating,
    required this.trips,
    required this.earnings,
    required this.review,
  });
}

class Vehicle
{
  String? name;
  String? model;
  String? color;
  String? plateNumber;
  String? type;

  Vehicle({
    required this.name,
    required this.model,
    required this.color,
    required this.plateNumber,
    required this.type,
  });
}

class Review
{
  String id;
  String name;
  String image;
  int rate;
  String comment;

  Review({
    required this.id,
    required this.name,
    required this.image,
    required this.rate,
    required this.comment,
  });
}