import 'package:twseela_driver/App/Constants/constants.dart';

extension NonNullString on String?{
  String orNull()
  {
    if(this == null) {
      return AppConstants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInt on int?{
  int orZero()
  {
    if(this == null) {
      return AppConstants.zero;
    } else {
      return this!;
    }
  }
} 

extension NonNullDouble on double?{
  double orZero()
  {
    if(this == null) {
      return AppConstants.zeroDouble;
    } else {
      return this!;
    }
  }
}