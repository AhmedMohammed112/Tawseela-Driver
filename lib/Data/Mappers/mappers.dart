import 'package:twseela_driver/Data/Response/ride_request_data_response.dart';
import 'package:twseela_driver/Domain/Models/ride_request_data.dart';

import '../../Domain/Models/autocomplete_prediction_model.dart';
import '../../Domain/Models/direction_details_info.dart';
import '../../Domain/Models/place_autocomplete_response_model.dart';
import '../../Domain/Models/place_details_model.dart';
import '../../Domain/Models/user_data.dart';
import '../../Domain/Models/user_model.dart';
import '../Response/current_user_info-response.dart';
import '../Response/direction_details_info_response.dart';
import '../Response/place_autocomplete_response.dart';
import '../Response/place_details_response.dart';
import '../Response/prediction_response.dart';
import '../../App/extensions.dart';
import '../Response/user_data_response.dart';

extension UserModelExtention on CurrentUserDataResponse {
  UserModel toDomain() {
    return UserModel(
      id: uid.orNull(),
      name: name.orNull(),
      email: email.orNull(),
      phone: phoneNumber.orNull(),
      address: address.orNull(),
      image: image.orNull(),
      rating: rating.orZero(),
      trips: trips.orZero(),
      earnings: earnings.orZero(),
      review: review!.map((e) => e.toDomain()).toList(),
      vehicle: vehicle?.toDomain(),
    );
  }
}

extension VehicleModelMapper on VehicleResponse {
    Vehicle toDomain() {
      return Vehicle(
        name: name.orNull(),
        model: model.orNull(),
        color: color.orNull(),
        plateNumber: plateNumber.orNull(),
        type: type.orNull(),
      );
    }
}

extension ReviewModelMapper on ReviewResponse {
  Review toDomain() {
    return Review(
      id: id.orNull(),
      name: name.orNull(),
      image: image.orNull(),
      rate: rate.orZero(),
      comment: comment.orNull(),
    );
  }
}





extension PlaceAutocompleteRespons on PlaceAutocompleteResponse {
  PlaceAutocomplete toDomain() {
    return PlaceAutocomplete(
      predictions: predictions?.map((e) => e!.toDomain()).toList(),
    );
  }
}




extension AutocompletePredictionExtention on AutocompletePredictionResponse {
  AutocompletePrediction toDomain() {
    return AutocompletePrediction(
      placeId: placeId.orNull(),
      description: description.orNull(),
      structuredFormatting: StructuredFormatting().toDomain(),
      reference: reference.orNull(),
    );
  }
}

extension StructuredFormattingResponse on StructuredFormatting {
  StructuredFormatting toDomain() {
    return StructuredFormatting(
      mainText: mainText.orNull(),
      secondaryText: secondaryText.orNull(),
    );
  }
} 

extension PlaceDetailsMapper on PlaceDetailsResponse {
  PlaceDetails toDomain() {
    return PlaceDetails(
      fullAddress: fullAddress.orNull(), 
      lat: lat.orZero(), 
      lng: lng.orZero(),
    );
  }
}

extension DirectionDetailsInfoMapper on DirectionDetailsInfoResponse {
  DirectionDetailsInfo toDomain() {
    return DirectionDetailsInfo(
      originAddress: originAddress,
      destinationAddress: destinationAddress,
      distanceText: distanceText.orNull(),
      distanceValue: distanceValue.orZero(),
      durationText: durationText.orNull(),
      durationValue: durationValue.orZero(),
    );
  }
}

extension RideRequestsDataResponseMapper on RideRequestDataResponse {
  RideRequestData toDomain() {
    return RideRequestData(
      id: id.orNull(),
      userId: userId.orNull(),
      driverId: driverId.orNull(),
      userName: userName.orNull(),
      userPhone: userPhone.orNull(),
      originAddress: originAddress.orNull(),
      originLat: originLat.orZero(),
      originLng: originLng.orZero(),
      destinationAddress: destinationAddress.orNull(),
      destinationLat: destinationLat.orZero(),
      destinationLng: destinationLng.orZero(),
      date: date.orNull(),
      fareAmount: fareAmount.orZero(),
      tripStatus: tripStatus.orNull(),
      rating: rating.orZero(),
    );
  }
}

extension UserDataExtention on UserDataResponse {
  UserData toDomain() {
    return UserData(
      id: uid.orNull(),
      name: name.orNull(),
      email: email.orNull(),
      phone: phoneNumber.orNull(),
      address: address.orNull(),
      image: image.orNull(),
      trips: trips.orZero(),
      freeTrips: freeTrips.orZero(),
      discounts: discounts ?? [],
    );
  }
}
