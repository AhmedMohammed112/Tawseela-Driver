class DirectionDetailsInfo {
  List<dynamic> originAddress;
  List<dynamic> destinationAddress;
  String distanceText;
  int distanceValue;
  String durationText;
  int durationValue;

  DirectionDetailsInfo({
    required this.originAddress,
    required this.destinationAddress,
    required this.distanceText,
    required this.distanceValue,
    required this.durationText,
    required this.durationValue,
  });
}