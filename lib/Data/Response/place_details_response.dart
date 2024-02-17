import 'dart:convert';

import 'formated_address_response.dart';

class PlaceDetailsResponse extends BaseApiResponse 
{
  String fullAddress; 
  double lat; 
  double lng; 

  PlaceDetailsResponse({required this.fullAddress,required this.lat,required this.lng}); 

  factory PlaceDetailsResponse.fromJson(String data)
  {
    final parsed = json.decode(data).cast<String, dynamic>();
    return PlaceDetailsResponse(
      fullAddress: parsed['result']['formatted_address'],
      lat: parsed['result']['geometry']['location']['lat'],
      lng: parsed['result']['geometry']['location']['lng']
    ) .. statusCode = parsed['status'] .. message = parsed['error_message'];
  }
}