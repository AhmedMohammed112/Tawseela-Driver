import '../../../../Data/Network/failure.dart';

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileGetDataLoadingState extends ProfileStates {}

class ProfileGetDataSuccessState extends ProfileStates {}

class ProfileGetDataErrorState extends ProfileStates {
    final Failure failure; 
    ProfileGetDataErrorState(this.failure);
}

class ProfileUpdateDataLoadingState extends ProfileStates {}

class ProfileUpdateDataSuccessState extends ProfileStates {}

class ProfileUpdateDataErrorState extends ProfileStates {}
class ProfileUpdateLoadingState extends ProfileStates {}
class ProfileUpdateSuccessState extends ProfileStates {}
class ProfileUpdateErrorState extends ProfileStates {}
class UploadUserImageSuccessState extends ProfileStates {}
class UploadUserImageErrorState extends ProfileStates {}
class UploadUserImageLoadingState extends ProfileStates {}