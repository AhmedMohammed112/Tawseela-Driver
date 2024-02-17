import 'package:twseela_driver/Data/Network/failure.dart';

abstract class DriverHistoryTripsStates {}

class DriverHistoryTripsInitialState extends DriverHistoryTripsStates {}

class GetDriverHistoryTripsSuccessState extends DriverHistoryTripsStates {}

class GetDriverHistoryTripsErrorState extends DriverHistoryTripsStates {
  final Failure failure;
  GetDriverHistoryTripsErrorState(this.failure);
}

class GetDriverHistoryTripsLoadingState extends DriverHistoryTripsStates {}

class ChangeSelectedFilterState extends DriverHistoryTripsStates {}