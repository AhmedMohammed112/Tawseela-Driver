
import '../../Domain/Models/autocomplete_prediction_model.dart';
import 'formated_address_response.dart';

class AutocompletePredictionResponse extends BaseApiResponse
{
  final String? description;
  final StructuredFormatting? structuredFormatting;
  final String? placeId;
  final String? reference;

  AutocompletePredictionResponse({
    this.description,
    this.structuredFormatting,
    this.placeId,
    this.reference
  });

  factory AutocompletePredictionResponse.fromJson(Map<String, dynamic> json)
  {
    return AutocompletePredictionResponse(
        description: json['description'],
        structuredFormatting: json['structured_formatting'] != null ? StructuredFormatting.fromJson(json['structured_formatting']) : null,
        placeId: json['place_id'],
        reference: json['reference']
    );
  }
}