import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela_driver/Domain/Models/ride_request_data.dart';
import 'package:twseela_driver/Domain/Usecases/get_driver_trips_history_usecase.dart';

import '../../../../../../App/di.dart';
import 'driver_history_trips_states.dart';

class DriverHistoryTripsCubit extends Cubit<DriverHistoryTripsStates> {
  DriverHistoryTripsCubit() : super(DriverHistoryTripsInitialState());

  static DriverHistoryTripsCubit get(context) => BlocProvider.of(context);

  List<RideRequestData> driverHistoryTrips = [];

  GetDriverTripsHistoryUsecase getDriverTripsHistoryUsecase =
      sl<GetDriverTripsHistoryUsecase>();

  Future<void> getDriverTripsHistory() async {
    emit(GetDriverHistoryTripsLoadingState());
    final response = await getDriverTripsHistoryUsecase.execute(null);
    response.fold(
      (error) {
        emit(GetDriverHistoryTripsErrorState(error));
      },
      (data) {
        driverHistoryTrips = data;
        initDefaultFilter();
        emit(GetDriverHistoryTripsSuccessState());
      },
    );
  }

  double getDriverTripsHistoryTotalPrice() {
    double totalPrice = 0;
    for (int i = 0; i < driverHistoryTrips.length; i++) {
      totalPrice += driverHistoryTrips[i].fareAmount!;
    }
    return totalPrice;
  }

  double getDriverTripsHistoryTotalRating() {
    double totalRating = 0;
    for (int i = 0; i < driverHistoryTrips.length; i++) {
      totalRating += driverHistoryTrips[i].rating!;
    }
    return totalRating / driverHistoryTrips.length;
  }

  Map<String, int> getDriverTripsHistoryTotalRatingCount() {
    int fiveStars = 0;
    int fourStars = 0;
    int threeStars = 0;
    int twoStars = 0;
    int oneStars = 0;
    for (int i = 0; i < driverHistoryTrips.length; i++) {
      if (driverHistoryTrips[i].rating == 5) {
        fiveStars++;
      } else if (driverHistoryTrips[i].rating == 4) {
        fourStars++;
      } else if (driverHistoryTrips[i].rating == 3) {
        threeStars++;
      } else if (driverHistoryTrips[i].rating == 2) {
        twoStars++;
      } else if (driverHistoryTrips[i].rating == 1) {
        oneStars++;
      }
    }
    return {
      "fiveStars": fiveStars,
      "fourStars": fourStars,
      "threeStars": threeStars,
      "twoStars": twoStars,
      "oneStars": oneStars,
    };
  }


  Map<String, List<RideRequestData>> getDriverTripsHistoryByDate() {
    Map<String, List<RideRequestData>> tripsByDate = {};
    for (int i = 0; i < driverHistoryTrips.length; i++) {
      if (tripsByDate.containsKey(
          driverHistoryTrips[i].date.substring(0, 10))) {
        tripsByDate[driverHistoryTrips[i].date.substring(0, 10)]!.add(
            driverHistoryTrips[i]);
      } else {
        tripsByDate[driverHistoryTrips[i].date.substring(0, 10)] = [];
        tripsByDate[driverHistoryTrips[i].date.substring(0, 10)]!.add(
            driverHistoryTrips[i]);
      }
    }
      dates = tripsByDate.keys.toList();
      dates!.sort((a, b) => b.compareTo(a));
      return tripsByDate;
    }

   List<String>? dates;

    List<RideRequestData> getDriverTripsHistoryByDateList(String date) {
      List<RideRequestData> tripsByDate = [];
      for (int i = 0; i < driverHistoryTrips.length; i++) {
        if (driverHistoryTrips[i].date.substring(0, 10) == date) {
          tripsByDate.add(driverHistoryTrips[i]);
        }
      }
      return tripsByDate;
    }

  Map<String, List<RideRequestData>> getDriverTripsHistoryByRate() {
    Map<String, List<RideRequestData>> tripsByRate = {};
    for (int i = 0; i < driverHistoryTrips.length; i++) {
      if (tripsByRate.containsKey(driverHistoryTrips[i].rating.toString())) {
        tripsByRate[driverHistoryTrips[i].rating.toString()]!.add(
            driverHistoryTrips[i]);
      } else {
        tripsByRate[driverHistoryTrips[i].rating.toString()] =
        [driverHistoryTrips[i]];
      }
    }

    rates = tripsByRate.keys.toList();
    rates!.sort((a, b) => b.compareTo(a));
    return tripsByRate;
  }

  List<String>? rates;



  List<RideRequestData> getDriverTripsHistoryByRateList(String rate) {
    List<RideRequestData> tripsByRate = [];
    for (int i = 0; i < driverHistoryTrips.length; i++) {
      if (driverHistoryTrips[i].rating.toString() == rate) {
        tripsByRate.add(driverHistoryTrips[i]);
      }
    }
    return tripsByRate;
  }

  Map<String, List<RideRequestData>> getDriverTripsHistoryByStatus() {
    Map<String, List<RideRequestData>> tripsByStatus = {};
    for (int i = 0; i < driverHistoryTrips.length; i++) {
      if (tripsByStatus.containsKey(driverHistoryTrips[i].tripStatus)) {
        tripsByStatus[driverHistoryTrips[i].tripStatus]!.add(
            driverHistoryTrips[i]);
      } else {
        tripsByStatus[driverHistoryTrips[i].tripStatus!] =
        [driverHistoryTrips[i]];
      }
    }
    status = tripsByStatus.keys.toList();
    status!.sort((a, b) => b.compareTo(a));
    return tripsByStatus;
  }

  List<String>? status;




  List<RideRequestData> getDriverTripsHistoryByStatusList(String status) {
    List<RideRequestData> tripsByStatus = [];
    for (int i = 0; i < driverHistoryTrips.length; i++) {
      if (driverHistoryTrips[i].tripStatus == status) {
        tripsByStatus.add(driverHistoryTrips[i]);
      }
    }
    return tripsByStatus;
  }

  List<String>? defaultFilter;
  Map<String,List<RideRequestData>> defaultFilterMap = {};

  void initDefaultFilter() {
    getDriverTripsHistoryByDate();
    defaultFilter = dates;
    defaultFilterMap = getDriverTripsHistoryByDate();
  }


  String selectedFilter = "Date";

  void changeSelectedFilter(String filter) {
    selectedFilter = filter;
    switch (filter) {
      case "Date":
        defaultFilter = dates;
        defaultFilterMap = getDriverTripsHistoryByDate();
        break;
      case "Rate":
        getDriverTripsHistoryByRate();
        defaultFilter = rates;
        defaultFilterMap = getDriverTripsHistoryByRate();
        break;
      case "Status":
        getDriverTripsHistoryByStatus();
        defaultFilter = status;
        defaultFilterMap = getDriverTripsHistoryByStatus();
        break;
    }
    emit(ChangeSelectedFilterState());
    emit(GetDriverHistoryTripsSuccessState());
  }

  List<String> filters = [
    "Date",
    "Rate",
    "Status",
  ];

}