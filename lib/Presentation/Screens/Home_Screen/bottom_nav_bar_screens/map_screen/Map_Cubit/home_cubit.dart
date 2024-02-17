import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:twseela_driver/App/Push_Notification/notifications.dart';
import 'package:twseela_driver/App/shared.dart';
import 'package:twseela_driver/Domain/Models/direction_details_info.dart';
import 'package:twseela_driver/Domain/Models/user_data.dart';
import 'package:twseela_driver/Domain/Models/user_model.dart';
import 'package:twseela_driver/Domain/Usecases/cancel_trip_usecase.dart';
import 'package:twseela_driver/Domain/Usecases/get_driver_id_usecase.dart';
import 'package:twseela_driver/Domain/Usecases/get_ride_request_reference_usecase.dart';
import 'package:twseela_driver/Domain/Usecases/get_user_data_usecase.dart';
import 'package:twseela_driver/Domain/Usecases/update_driver_location_usecase.dart';
import 'package:twseela_driver/Domain/Usecases/update_driver_status_usecase.dart';
import 'package:twseela_driver/Domain/Usecases/update_driver_trips_count_usecase.dart';
import 'package:twseela_driver/Domain/Usecases/update_trip_history.dart';
import 'package:twseela_driver/Presentation/Resources/values_manager.dart';
import 'package:twseela_driver/Presentation/Widgets/fare_amount_dialog.dart';
import 'package:twseela_driver/Presentation/Widgets/user_cancelled_request_dialog.dart';
import '../../../../../../App/Constants/constants.dart';
import '../../../../../../App/di.dart';
import '../../../../../../Domain/Models/ride_request_data.dart';
import '../../../../../../Domain/Usecases/get_direction_info_usecase.dart';
import '../../../../../../Domain/Usecases/get_driver_status_usecase.dart';
import '../../../../../../Domain/Usecases/get_formatted-address_usecase.dart';
import '../../../../../../Domain/Usecases/get_driver_data_usecase.dart';
import '../../../../../../Domain/Usecases/get_ride-request_data.dart';
import '../../../../../../Domain/Usecases/save_driver_earnings_usecase.dart';
import '../../../../../Widgets/acceptance_error_dialog.dart';
import '../../../../../Widgets/error_dialog.dart';
import '../../../../../Widgets/no_longer_aailable_dialog.dart';
import '../../driver_trips_history_screen.dart';
import '../../earning_screen.dart';
import '../../driver_profile_screen.dart';
import '../map_screen.dart';
import 'home_states.dart';
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());


  static HomeCubit get(context) => BlocProvider.of(context);

  final GetFormattedAddressUsecase getFormattedAddressUsecase = sl<GetFormattedAddressUsecase>();
  final GetDirectionDetailsInfoUsecase getDirectionDetailsInfoUsecase = sl<GetDirectionDetailsInfoUsecase>();
  final GetCurrentDriverInfoUsecase getCurrentUserInfoUsecase = sl<GetCurrentDriverInfoUsecase>();
  final CancelTripUsecase cancelTripUsecase = sl<CancelTripUsecase>();
  final UpdateDriverStatusUsecase updateDriverStatusUsecase = sl<UpdateDriverStatusUsecase>();
  final UpdateTripStatusUsecase updateTripStatusUsecase = sl<UpdateTripStatusUsecase>();
  final UpdateDriverTripsCountUsecase updateDriverTripsCountUsecase = sl<UpdateDriverTripsCountUsecase>();
  final SaveDriverEarningsUsecase saveDriverEarningsUsecase = sl<SaveDriverEarningsUsecase>();
  final UpdateDriverLocationUsecase updateDriverLocationUsecase = sl<UpdateDriverLocationUsecase>();
  final GetUserDataUsecase getUserDataUsecase = sl<GetUserDataUsecase>();
  final GetRideRequestReferenceUsecase getRideRequestReferenceUsecase = sl<GetRideRequestReferenceUsecase>();
  final GetRideRequestDataUsecase getRideRequestDataUsecase = sl<GetRideRequestDataUsecase>();
  final GetDriverStatusUsecase getDriverStatusUsecase = sl<GetDriverStatusUsecase>();
  final GetRequestDriverIdUsecase getRequestDriverIdUsecase = sl<GetRequestDriverIdUsecase>();


  List<Widget> screens = [
    const MapScreen(),
    const DriverTripsHistory(),
    const EarningScreen(),
    const UserProfileScreen(),
  ];

  List<String> titles = [
    "Home",
    "History",
    "Earning",
    "Profile",
  ];

  int selectedIndex = 0;

  UserModel? currentUserData;

  double bottomPadding = 0;
  String trip = "Not assigned";

  LatLng? pickUpLocation = LatLng(currentLocationData!.latitude!, currentLocationData!.longitude!);
  LatLng? dropOffLocation;
  LatLng? currentLocation;
  LatLng? destinationLocation;
  Set<Marker> markers = {};
  Set<Circle> circles = {};
  Set<Polyline> polyLines = {};
  String? address;


  Completer<GoogleMapController> mapController = Completer();
  GoogleMapController? controller;

  DirectionDetailsInfo? directionDetailsInfo;

  RideRequestData? rideRequestData;

  bool isDriverOnline = false;

  StreamSubscription<DatabaseEvent>? allRideRequestsSubscription; // All Ride Requests Subscription

  void getCurrentUserData() async {
    final result = await getCurrentUserInfoUsecase.execute(FirebaseAuth.instance.currentUser!.uid);
    result.fold(
          (failure) {
        emit(ErrorState(failure));
      },
          (data) {
        currentUserData = data;
        emit(GetCurrentUserDataSuccessState());
      },
    );
  }

  void changeRequestStatus(String status) {
    trip = status;
    bottomPadding = 280;
    emit(AcceptRequestState());
  }


  void onItemTapped(int index) {
    selectedIndex = index;
    emit(ChangeBottomNavState());
  }

  endTripWithCalculateFare(context) async {
    SharedPref.removeTripData();
    trip = "Not assigned";
    bottomPadding = 0;
    calculateFares(context); 
    pickUpLocation = LatLng(currentLocationData!.latitude!,currentLocationData!.longitude!);
    dropOffLocation = null;
    destinationLocation = null;
    rideRequestData = null;
    await updateDriverStatusUsecase.execute("idle");
    markers.clear();
    circles.clear();
    polyLines.clear();
    addPickUpMarker(pickUpLocation!);
    savedRideRequestId = null;
    tempRideRequestData = null;
    directionDetailsInfo = null;
    allRideRequestsSubscription!.cancel();
    rideRequestRef = null;
    emit(GetPredictionsSuccessState());
  }

  endTripWithoutCalculateFare() async {
    SharedPref.removeTripData();
    trip = "Not assigned";
    bottomPadding = 0;
    pickUpLocation = LatLng(currentLocationData!.latitude!,currentLocationData!.longitude!);
    dropOffLocation = null;
    destinationLocation = null;
    await updateDriverStatusUsecase.execute("idle");
    markers.clear();
    circles.clear();
    polyLines.clear();
    addPickUpMarker(LatLng(currentLocationData!.latitude!, currentLocationData!.longitude!));
    tempRideRequestData = null;
    rideRequestData = null;
    directionDetailsInfo = null;
    allRideRequestsSubscription!.cancel();
    rideRequestRef = null;
    emit(GetPredictionsSuccessState());
  }

  void cancelTripByDriver() async {
    endTripWithoutCalculateFare();
    await cancelTripUsecase.execute(savedRideRequestId!);
    savedRideRequestId = null;
    emit(CancelTripState());
  }

  void cancelTripByUser() async {
      endTripWithoutCalculateFare();
      savedRideRequestId = null;
      emit(CancelTripState());
      }

      UserData? userData;
      Future<void> getUserData() async {
        final result = await getUserDataUsecase.execute(rideRequestData!.userId);
        result.fold(
          (failure) {
            emit(ErrorState(failure));
          },
          (data) {
            userData = data;
            emit(GetUserDataSuccessState());
          },
        );
      }

  String? currentDriverStatus;
  Future<void> getDriverCurrentStatus() async {
    (await getDriverStatusUsecase.execute(null)).fold((l) {
      emit(ErrorState(l));
    }, (r) {
      currentDriverStatus = r;
    });
  }

  String? currentRequestDriverId;
  Future<void> getRequestDriverId(String rideRequestId) async {
    (await getRideRequestDataUsecase.execute(rideRequestId)).fold((l) {
      emit(ErrorState(l));
    }, (r) {
      currentRequestDriverId = r.tripStatus;
    });
  }

  RideRequestData? tempRideRequestData;
  Future<void> getRideRequestData(String rideRequestId) async {
      (await getRideRequestDataUsecase.execute(rideRequestId)).fold((l) {
        emit(ErrorState(l));
      }, (r) {
        tempRideRequestData = r;
      });
    }


  void acceptRideRequest(String rideRequestId,BuildContext context, UserModel userModel,RideRequestData rideRequestData) async {
          getRideRequestData(rideRequestId).then((value) {
            if(tempRideRequestData != null) {
              getRequestDriverId(rideRequestId).then((value)  async {
                if(currentRequestDriverId != "Waiting" && currentRequestDriverId != FirebaseAuth.instance.currentUser!.uid) {
                  acceptanceErrorDialog(context);
                }
                else {
                  await getDriverCurrentStatus().
                  then((value) {
                    if (currentDriverStatus == "idle") {
                      savedRideRequestId = rideRequestId;
                      rideRequestData = tempRideRequestData!;
                      SharedPref.saveTripData(value: rideRequestId);
                      updateDriverStatusUsecase.execute("Accepted");
                      changeTripStatus("accepted");
                      updateDriverLocationUsecase.execute(UpdateDriverLocationOnRequestUsecaseData(requestId: rideRequestId, latitude: currentLocationData!.latitude, longitude: currentLocationData!.longitude));
                      listenToTheTripStatus(context);
                      initNewTrip(rideRequestData);
                    }
                    else {
                      warningDialog(context);
                    }
                  });
                }
              });
            }
            else {
              dialogNoLongerAvailable(context);
            }
          });
  }


  DatabaseReference? rideRequestRef;
  StreamSubscription<DatabaseEvent>? rideRequestSubscription;
  Future<void> getCurrentRequestData(String requestId) async {
      (await getRideRequestReferenceUsecase.execute(requestId)).fold((l) => {
        emit(ErrorState(l))
      }, (r) => {
      rideRequestRef = r,
    });
  }

  void listenToTheTripStatus(BuildContext context) async {
    await getCurrentRequestData(savedRideRequestId!);
    allRideRequestsSubscription = rideRequestRef!.onValue.listen((event) async {
      if (event.snapshot.value != null) {
        if((event.snapshot.value as dynamic)["trip_status"] == "Cancelled by user") {
          userCancelledRequestDialog(context);
          cancelTripByUser();
          await updateDriverStatusUsecase.execute("idle");
          emit(GetPredictionsSuccessState());
        }
      } else {
        await updateDriverStatusUsecase.execute("idle");
        emit(GetPredictionsSuccessState());
      }
    });
  }

  void listenToTheCurrentTripStatus(BuildContext context) async {
    await getCurrentRequestData(currentTripData!);
    allRideRequestsSubscription = rideRequestRef!.onValue.listen((event) async {
      if (event.snapshot.value != null) {

        (await getRideRequestDataUsecase.execute(currentTripData!)).fold((l) => {
          emit(ErrorState(l))
        }, (r) {
          rideRequestData = r;
        });

        savedRideRequestId = rideRequestData!.id;
        address = rideRequestData!.originAddress;
        pickUpLocation = LatLng(currentLocationData!.latitude!, currentLocationData!.longitude!);
        dropOffLocation = LatLng(rideRequestData!.destinationLat, rideRequestData!.destinationLng);
        if(rideRequestData!.tripStatus == "accepted") {
          trip = "accepted";
          pickUpLocation = LatLng(currentLocationData!.latitude!, currentLocationData!.longitude!);
          dropOffLocation = LatLng(rideRequestData!.originLat, rideRequestData!.originLng);
          changeRequestStatus("arrived");
          getDirectionDetails();
          emit(GetPredictionsSuccessState());
        }
        else if(rideRequestData!.tripStatus == "arrived") {
            trip = "arrived";
            changeRequestStatus("onTrip");
          }
        else if(rideRequestData!.tripStatus == "onTrip") {
            trip = "onTrip";
            changeRequestStatus("show fare");
          emit(GetPredictionsSuccessState());
        }
        else if(rideRequestData!.tripStatus == "Cancelled by user") {
          userCancelledRequestDialog(context);
          cancelTripByUser();
          await updateDriverStatusUsecase.execute("idle");
          emit(GetPredictionsSuccessState());
        }
      }
      else {
        await updateDriverStatusUsecase.execute("idle");
        emit(GetPredictionsSuccessState());
      }
    });
  }


  void calculateFares(context) async {
    double totalFares = rideRequestData!.fareAmount!;
    saveDriverEarnings(totalFares);
    fareAmountDialog(context, totalFares);
  }

  void saveDriverEarnings(double totalFares) async {
    await saveDriverEarningsUsecase.execute(totalFares);
    await updateDriverTripsCountUsecase.execute(null);
  }

  // the destination of the user
  void setDestinationLocation(LatLng location) {
    destinationLocation = location;
    emit(SetDestinationLocationState());
  }

  // at first the drop off location of the driver is the user current location
  // when driver  to the user current location make the drop off value the same as destination value
  void setDestinationToDropOffLocation() {
    dropOffLocation = destinationLocation;
    emit(GoToDestinationState());
  }

  Future init(context) async {
    await PushNotificationSystem().initializeCloudMessaging(context);
  }

  void changeDriverOnlineStatus(BuildContext context) async {
    isDriverOnline = !isDriverOnline;
    if(isDriverOnline == true) {
      driverIsOnline();
    }
    else {
      driverIsOffline();
    }

    if(currentTripData != null) {
      listenToTheCurrentTripStatus(context);
    }

    emit(ChangeDriverOnlineStatusState());
  }

  StreamSubscription<Position>? driverLocationSubscription;
  StreamSubscription<Position>? driverLiveLocationSubscription;

// function to save the picked up location on firebase database when i click on a button and remove when i click on another button like a toggle button  
  Future<void> driverIsOnline() async {
    Geofire.initialize("activeDrivers");
    Geofire.setLocation(FirebaseAuth.instance.currentUser!.uid, currentLocationData!.latitude!, currentLocationData!.longitude!);
    await updateDriverStatusUsecase.execute("idle");

    emit(DriverIsOnlineState());
  } 

  Future<void> driverIsOffline() async {
    Geofire.initialize("activeDrivers");
    Geofire.removeLocation(FirebaseAuth.instance.currentUser!.uid);
    emit(DriverIsOfflineState());
  }

  void addPickUpMarker(LatLng location) {
    markers.remove(const Marker(markerId: MarkerId('pickUp')));
    markers.add(Marker(
      markerId: const MarkerId('pickUp'),
      position: location,
      infoWindow: const InfoWindow(title: 'Pick Up Here'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ));

    circles.remove(const Circle(circleId: CircleId('pickUp')));
    circles.add(Circle(
      circleId: const CircleId('pickUp'),
      fillColor: Colors.greenAccent,
      strokeColor: Colors.greenAccent,
      center: location,
      radius: 12,
    ));

    emit(AddMarkerState());
  }
  void addDropOffMarker(LatLng location) {
    markers.remove(const Marker(markerId: MarkerId('dropOff')));
    markers.add(Marker(
      markerId: const MarkerId('dropOff'),
      position: location,
      infoWindow: const InfoWindow(title: 'Drop Off Here'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ));

    circles.remove(const Circle(circleId: CircleId('dropOff')));
    circles.add(Circle(
      circleId: const CircleId('dropOff'),
      fillColor: Colors.blueAccent,
      strokeColor: Colors.blueAccent,
      center: location,
      radius: 12,
    ));

    emit(AddMarkerState());
  }

  void animateCamera(LatLng location) {
    controller!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 18,
        ),
      ),
    );
  }

  void getMyCurrentLocation() async {
      pickUpLocation = LatLng(currentLocationData!.latitude!, currentLocationData!.longitude!);
      addPickUpMarker(pickUpLocation!);
      await getFormattedAddress();
      animateCamera(pickUpLocation!);
      emit(GetAddressState());
  }

  Future<void> getFormattedAddress() async {
    (await getFormattedAddressUsecase.execute(LatLng(
      pickUpLocation!.latitude,
      pickUpLocation!.longitude,
    ))).fold((l) {
      emit(ErrorState(l));
    }, (r) {
      address = r;
      emit(GetAddressState());
    });

  }

  void updatePickUpLocation({required LatLng pickUpLocation2}) async {
    pickUpLocation = pickUpLocation2;
    addPickUpMarker(pickUpLocation2);
    await getFormattedAddress();
    animateCamera(pickUpLocation2);
    emit(UpdatePickUpLocationState());
  }

  Future<void> updateDropOffLocation({required LatLng returnedDropOffLocation}) async
  {
    dropOffLocation = returnedDropOffLocation;
    emit(UpdateDropOffLocationState());
  }

void getDriverUpdatesAtRealTime() async {
    driverLiveLocationSubscription = Geolocator.getPositionStream().listen((Position position) async {
      pickUpLocation = LatLng(position.latitude, position.longitude);
      currentLocation = LatLng(position.latitude, position.longitude);

      LatLng liveLocation = LatLng(position.latitude, position.longitude);

      if(trip != "Not assigned") {
        getDirectionDetails();
      }

      if(dropOffLocation != null) {
        getRoute();
      }
      else {
        polyLines.clear();
        emit(GetDriverUpdatesAtRealTimeState());
      }

      if(rideRequestData != null) {
        await updateDriverLocationUsecase.execute(UpdateDriverLocationOnRequestUsecaseData(requestId: rideRequestData!.id, latitude: liveLocation.latitude, longitude: liveLocation.longitude));

        Geofire.setLocation(FirebaseAuth.instance.currentUser!.uid, liveLocation.latitude, liveLocation.longitude);
      }

      addPickUpMarker(liveLocation);

      emit(GetDriverUpdatesAtRealTimeState());
    });
  }

  void getRoute() async {
    polyLines.clear();
    PolylinePoints polyLinePoints = PolylinePoints();
    List<LatLng> polyLineCoordinates = [];
    PolylineResult result = await polyLinePoints.getRouteBetweenCoordinates(
      AppConstants.apiKey,
      PointLatLng(pickUpLocation!.latitude,pickUpLocation!.longitude),
      PointLatLng(dropOffLocation!.latitude,dropOffLocation!.longitude),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    polyLines.add(Polyline(
      polylineId: const PolylineId('polyLineId'),
      color: Colors.blue,
      points: polyLineCoordinates,
      width: AppSizes.s5.toInt(),
    ));

    LatLngBounds latLngBounds;
    if(pickUpLocation!.latitude > dropOffLocation!.latitude && pickUpLocation!.longitude > dropOffLocation!.longitude)
    {
      latLngBounds = LatLngBounds(southwest: dropOffLocation!, northeast: pickUpLocation!);
    }
    else if(pickUpLocation!.longitude > dropOffLocation!.longitude)
    {
      latLngBounds = LatLngBounds(southwest: LatLng(pickUpLocation!.latitude, dropOffLocation!.longitude), northeast: LatLng(dropOffLocation!.latitude, pickUpLocation!.longitude));
    }
    else if(pickUpLocation!.latitude > dropOffLocation!.latitude)
    {
      latLngBounds = LatLngBounds(southwest: LatLng(dropOffLocation!.latitude, pickUpLocation!.longitude), northeast: LatLng(pickUpLocation!.latitude, dropOffLocation!.longitude));
    }
    else
    {
      latLngBounds = LatLngBounds(southwest: pickUpLocation!, northeast: dropOffLocation!);
    }
    controller!.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    addPickUpMarker(pickUpLocation!);
    addDropOffMarker(dropOffLocation!);

    emit(GetRouteSuccessState());
  } 

  Future getToken() async
  {
    PushNotificationSystem pushNotificationSystem = PushNotificationSystem();
    pushNotificationSystem.generateToken();
  }

  Future<void> getDirectionDetails() async {
    ( await getDirectionDetailsInfoUsecase.execute(DirectionDetailsInfoUsecaseParams(
      origin: pickUpLocation!,
      destination: dropOffLocation!,
    ))).fold((l) {
      emit(ErrorState(l));
    }, (r) {
      directionDetailsInfo = r;
    });
  }

  void initNewTrip(RideRequestData rideRequestData) {
    rideRequestData = rideRequestData;
    changeRequestStatus("arrived");
    updatePickUpLocation(pickUpLocation2: LatLng(currentLocationData!.latitude!, currentLocationData!.longitude!));
    updateDropOffLocation(returnedDropOffLocation: LatLng(rideRequestData.originLat, rideRequestData.originLng));
    setDestinationLocation(LatLng(rideRequestData.destinationLat, rideRequestData.destinationLng));
    getDirectionDetails();
    getUserData();
  }

}
