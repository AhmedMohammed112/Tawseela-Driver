import 'dart:convert';

import 'package:twseela_driver/Data/Response/prediction_response.dart';

import 'formated_address_response.dart';


class PlaceAutocompleteResponse extends BaseApiResponse
{
  List<AutocompletePredictionResponse>? predictions;

  PlaceAutocompleteResponse({this.predictions});

  factory PlaceAutocompleteResponse.fromJson(Map<String, dynamic> json)
  {
    return PlaceAutocompleteResponse(
        predictions: json['predictions'] != null ? (json['predictions'] as List).map((i) => AutocompletePredictionResponse.fromJson(i)).toList() : null
    ) ..statusCode = json['status'] .. message = json['error_message'];
  }

  static PlaceAutocompleteResponse parseAutocompleteResponse(String responseBody)
  {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return PlaceAutocompleteResponse.fromJson(parsed);
  }
}