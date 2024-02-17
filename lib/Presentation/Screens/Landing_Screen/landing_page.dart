import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import '../../../App/di.dart';
import '../Home_Screen/home_screen.dart';
import '../Login_Screen/login_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              initLogin();
              return LoginScreen();
            }
            else
              {
                initGetUserInfo();
                initUpdateUserInfo();
                initGetFormattedAddress();
                initGetDirectionDetailsInfo();
                initGetUserInfo();
                initGetDriverTripsHistory();
                initCancelTrip();
                initUpdateDriverTripsCount();
                initUpdateDriverStatus();
                initSaveDriverEarnings();
                initUpdateTripStatus();
                initSaveDeviceToken();
                initUpdateDriverLocation();
                initGetUserData();
                initGetRequestDriverId();
                initLogout();
                initGetRideRequestData();
                initGetDriverStatus();
                initGetRideRequestReference();
                return const HomeScreen();
              }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
    );
  }
}
