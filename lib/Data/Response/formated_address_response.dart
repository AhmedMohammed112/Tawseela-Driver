import 'dart:convert';
import 'package:http/http.dart' as http;


class BaseApiResponse {
  int? statusCode;
  String? message;

  BaseApiResponse({
    this.statusCode,
    this.message,
  });

  factory BaseApiResponse.fromJson(Map<String, dynamic> json) {
    return BaseApiResponse(
      statusCode: json['status_code'],
      message: json['message'],
    );
  }

  //to map
  Map<String, dynamic> toJson() {
    return {
      'status_code': statusCode,
      'message': message,
    };
  }

}




class FormattedAddressResponse extends BaseApiResponse
{
  String formattedAddress;

  FormattedAddressResponse({
    required this.formattedAddress,
  });

  factory FormattedAddressResponse.fromJson(http.Response response) {
    final decodedResponse = json.decode(response.body);
    return FormattedAddressResponse(
      formattedAddress: decodedResponse['results'][0]['formatted_address'],
    )..statusCode = response.statusCode.. message = response.reasonPhrase;
  }
}