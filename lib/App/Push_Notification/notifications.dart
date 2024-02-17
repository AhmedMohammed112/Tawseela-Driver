import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/Material.dart';
import 'package:twseela_driver/App/Constants/constants.dart';
import 'package:twseela_driver/Domain/Usecases/get_ride-request_data.dart';
import 'package:twseela_driver/Domain/Usecases/save_device-token_usecase.dart';
import 'package:twseela_driver/Domain/Usecases/update_trip_history.dart';
import '../../Domain/Usecases/get_driver_id_usecase.dart';
import '../../Presentation/Widgets/no_longer_aailable_dialog.dart';
import '../../Presentation/Widgets/request_dialoge.dart';
import '../di.dart';

class PushNotificationSystem
{
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging(BuildContext context) async
  {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        readUserRideRequestInformation(message.data["rideRequestId"],context);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      readUserRideRequestInformation(message!.data["rideRequestId"],context);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      readUserRideRequestInformation(message!.data["rideRequestId"],context);
    });

    FirebaseMessaging.onBackgroundMessage((message) {
      return readUserRideRequestInformation(message.data["rideRequestId"],context);
    });
  }

  Future generateToken() async {
    final SaveDeviceTokenUsecase saveDeviceTokenUsecase = sl<SaveDeviceTokenUsecase>();
    String? token = await firebaseMessaging.getToken();
    await saveDeviceTokenUsecase.execute(token!);


    firebaseMessaging.subscribeToTopic("allDrivers");
    firebaseMessaging.subscribeToTopic("allUsers");
  }

  readUserRideRequestInformation(String rideRequestId, BuildContext context) async {
    final GetRideRequestDataUsecase getRideRequestDataUsecase =
    sl<GetRideRequestDataUsecase>();
    final GetRequestDriverIdUsecase getRequestDriverIdUsecase =
    sl<GetRequestDriverIdUsecase>();

    (await getRequestDriverIdUsecase.execute(rideRequestId)).fold((l) {}, (r) async {
      r.onValue.listen((event) async {
        if ((event.snapshot.value as dynamic)["driver_id"] == "Waiting") {
          (await getRideRequestDataUsecase.execute(rideRequestId)).fold((l) {
            dialogNoLongerAvailable(context);
          }, (r) {
            requestDialog(context, r, rideRequestId);
          });
        }
      });
    });
  }
}



void changeTripStatus(String newStatus) {
  final UpdateTripStatusUsecase updateTripStatusUsecase = sl<UpdateTripStatusUsecase>();
  updateTripStatusUsecase.execute(UpdateTripStatusUsecasedata(rideRequestId: savedRideRequestId!, status: newStatus));
}
