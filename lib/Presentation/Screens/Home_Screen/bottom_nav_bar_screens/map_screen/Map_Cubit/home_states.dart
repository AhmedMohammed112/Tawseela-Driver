import 'package:twseela_driver/Data/Network/failure.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class AddMarkerState extends HomeStates {}

class GetAddressState extends HomeStates {}

class UpdatePickUpLocationState extends HomeStates {}

class GetPredictionsSuccessState extends HomeStates {}

class UpdateDropOffLocationState extends HomeStates {}

class FlipIsSearchingState extends HomeStates {}

class ChangeDriverOnlineStatusState extends HomeStates {}

class GetRouteSuccessState extends HomeStates {} 

class ChangeBottomNavState extends HomeStates {}

class SetDestinationLocationState extends HomeStates {}

class GoToDestinationState extends HomeStates {}

class GetCurrentUserDataSuccessState extends HomeStates {}
class ErrorState extends HomeStates {
  final Failure failure;
  ErrorState(this.failure);
}



class GetCurrentUserDataErrorState extends HomeStates {}

class GetDriverUpdatesAtRealTimeState extends HomeStates {}

class UpdateDurationAndDistanceState extends HomeStates {}

class AcceptRequestState extends HomeStates {}

class CancelTripState extends HomeStates {}

class DriverIsOnlineState extends HomeStates {}

class DriverIsOfflineState extends HomeStates {}
class GetUserDataErrorState extends HomeStates {}
class GetUserDataSuccessState extends HomeStates {}

