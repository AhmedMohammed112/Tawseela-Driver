import 'dart:convert';
import 'package:http/http.dart' as http;

import 'formated_address_response.dart';

class DirectionDetailsInfoResponse extends BaseApiResponse
{
  List<dynamic> originAddress;
  List<dynamic> destinationAddress;
  String distanceText;
  int distanceValue;
  String durationText;
  int durationValue;

  DirectionDetailsInfoResponse({
    required this.originAddress,
    required this.destinationAddress,
    required this.distanceText,
    required this.distanceValue,
    required this.durationText,
    required this.durationValue,
  });

  factory DirectionDetailsInfoResponse.fromJson(String lol) {
    final data = json.decode(lol).cast<String, dynamic>();
    return DirectionDetailsInfoResponse(
      originAddress: data['origin_addresses'],
      destinationAddress: data['destination_addresses'],
      distanceText: data['rows'][0]['elements'][0]['distance']['text'],
      distanceValue: data['rows'][0]['elements'][0]['distance']['value'],
      durationText: data['rows'][0]['elements'][0]['duration']['text'],
      durationValue: data['rows'][0]['elements'][0]['duration']['value'],
    );
  }
}