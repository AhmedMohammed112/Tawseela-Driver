import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twseela_driver/Domain/Usecases/update_driver_data_usecase.dart';
import 'package:twseela_driver/Presentation/Screens/Profile_Screen/Profile_Cubit/profile_stetes.dart';
import '../../../../App/di.dart';
import '../../../../Domain/Models/user_model.dart';
import '../../../../Domain/Usecases/get_driver_data_usecase.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  GetCurrentDriverInfoUsecase getCurrentUserInfoUsecase = sl<GetCurrentDriverInfoUsecase>();
  UpdateUserDataUsecase updateCurrentUserInfoUsecase = sl<UpdateUserDataUsecase>();

  final imagePicker = ImagePicker();
  File? imageFile;

  ImageProvider userImage() {
    if(imageFile == null && myData!.image!.substring(0,4) == "http") {
      return NetworkImage(myData!.image!);
    } else if(imageFile != null) {
      return Image.file(imageFile!).image;
    } else {
      File imageFile = File(myData!.image!);
      return Image.file(imageFile).image;
    }
  }


  void getUserImage() {
    try {
      ImagePicker.platform.getImageFromSource(source: ImageSource.gallery).then((value) {
        if (value != null) {
          imageFile = File(value.path);
          emit(UploadUserImageSuccessState());
        } else {
          emit(UploadUserImageErrorState());
        }
      });
      if (imageFile != null) {
        imageFile = File(imageFile!.path);
        emit(UploadUserImageSuccessState());
      } else {
        emit(UploadUserImageErrorState());
      }
    } catch(e) {
      print(e.toString());
    }
  }

  Future<void>? updateUserImage({
    required UpdateUserDataUseCaseInput data,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('drivers/${Uri.file(imageFile!.path).pathSegments.last}')
        .putFile(imageFile!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        updateProfileInfo(
          data: UpdateUserDataUseCaseInput(
            name: data.name,
            email: data.email,
            phone: data.phone,
            image: value,
            address: data.address,
            vehicle: data.vehicle,
          ),
        );
        emit(ProfileGetDataSuccessState());
      }).catchError((e) {
        emit(ProfileGetDataErrorState(e));
      }).catchError((e) {
        emit(ProfileGetDataErrorState(e));
      });
    });
    return null;
  }


  UserModel? myData;
  void getUserData() async {

    final result = await getCurrentUserInfoUsecase.execute(FirebaseAuth.instance.currentUser!.uid);
    result.fold((error) {
      emit(ProfileGetDataErrorState(error));
    }, (data) {
      print(data.name);
      myData = data;
      emit(ProfileGetDataSuccessState());
    });
  }

  void updateProfileInfo({required UpdateUserDataUseCaseInput data}) async {
    emit(ProfileUpdateLoadingState());
    final result = await updateCurrentUserInfoUsecase.execute(data);
    result.fold((error) {
      emit(ProfileUpdateErrorState());
    }, (data) {
      emit(ProfileUpdateSuccessState());
    });
  }




}