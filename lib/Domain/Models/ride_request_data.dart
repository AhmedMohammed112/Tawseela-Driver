class RideRequestData {
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

  RideRequestData({
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

}
