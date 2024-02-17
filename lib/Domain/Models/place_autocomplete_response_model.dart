import 'dart:convert';
import 'autocomplete_prediction_model.dart';

class PlaceAutocomplete

{
  final List<AutocompletePrediction>? predictions;
  
  PlaceAutocomplete({
    this.predictions
  }); 

  // factory PlaceAutocompleteResponse.fromJson(Map<String, dynamic> json)
  // {
  //   return PlaceAutocompleteResponse(
  //     status: json['status'] as String?,
  //     predictions: json['predictions'] != null ? (json['predictions'] as List).map((i) => AutocompletePrediction.fromJson(i)).toList() : null
  //   );
  // }
  //
  // static PlaceAutocompleteResponse? parseAutocompleteResponse(String responseBody)
  // {
  //   final parsed = json.decode(responseBody).cast<String, dynamic>();
  //   return PlaceAutocompleteResponse.fromJson(parsed);
  // }
}