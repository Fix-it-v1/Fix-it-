
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/model/message_model.dart';
import 'package:project/model/request_model.dart';
import 'package:project/select_t_or_c.dart';
import 'package:project/technical/login.dart';
import 'package:project/model/create_user_model.dart';
import 'package:project/shared/constant.dart';
import 'package:project/shared/shared_preferneces.dart';
import 'package:project/user/login_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  DataUserModel dataUserModel = DataUserModel(
    uId: '',
    firstName: '',
    lastName: '',
    email: '',
    birthDate: '',
    gender: '',
    image: '',
    city: '',
    phone: '',
  );

  Future<DataUserModel> getUserProfile() async {
    emit(GetProfileDataLoadingState());
    try {
      final response = await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get()
          .then((value) {
        return DataUserModel.fromJson(value.data()!);
      });
      dataUserModel = response ;
      emit(GetProfileDataSuccessState());
      return response;
    } catch (error) {
      emit(GetProfileDataErrorState(error.toString()));
      rethrow;
    }
  }
Future signOut(context)async
{
  final response = await FirebaseAuth.instance.signOut().then((value)
  {
    PreferenceUtils.removeData(
        SharedKeys.uId).then((value) {
      if (value)
      {
        //ToDo: navigate to login Screen
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => SelectUserOrTechnical()), (
            route) => false);
      }
      });
    emit(SignOutDataSuccessState());
  }).catchError((error)
  {
    emit(SignOutDataErrorState(error.toString()));

  });

}

  Future updateProfilePicture({
    required String profileImage,
  }) async
  {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uId).update(
          {
            'image': profileImage,
          });
      emit(UpdateUserProfilePictureSuccessState());
    } catch (error) {
      emit(UpdateUserProfilePictureErrorState(error.toString()));
    }
  }
  void uploadProfileImage(profileImage) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) async {
      updateProfilePicture(profileImage: await value.ref.getDownloadURL());
    }).catchError((error) {
      emit(UploadUserProfileImageErrorState());
      print(error.toString());
    });
  }

  Future sendMessage({
    required String receiverId,
    required String message,
    required String timeCreating,
  }) async {
    MessageModel model = MessageModel(
      senderId: uId,
      receiverId:receiverId,
      message: message,
      timeCreating: timeCreating,

    );
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .add(model.toMap());

      FirebaseFirestore.instance
          .collection('providers')
          .doc(receiverId)
          .collection('chats')
          .doc(uId)
          .collection('messages')
          .add(model.toMap());
      emit(SendUserMessageSuccessState());
    } catch (error)
    {
      emit(SendUserMessageErrorState(error.toString()));
    }
  }


  Future sendRequest({
    required String receiverId,
    required String technicalName,
    required String timeCreating,
    required String technicalPhone,
    required String userName,
    required String requestType,
    required String  location,
  }) async {
    RequestModel requestModel = RequestModel(
      senderId: uId,
      receiverId:receiverId,
      timeCreating: timeCreating,
      userName: userName,
      requestType: requestType,
      location: location,
      technicalPhone: technicalPhone,
      technicalName: technicalName,
      rate: 0,

    );
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('requests')
          .add(requestModel.toMap());

      FirebaseFirestore.instance
          .collection('providers')
          .doc(receiverId)
          .collection('requests')
          .add(requestModel.toMap());
      emit(SendUserRequestSuccessState());
    } catch (error)
    {
      emit(SendUserRequestErrorState(error.toString()));
    }
  }

  Future addAndUpdateRate({
    required String orderId,
    required String technicalId,
    required double rateValue,
  }) async
  {
    FirebaseFirestore.instance.collection('users').doc(uId).collection('ordersList').doc(orderId).update(
        {
          'rate': rateValue,
        }
    );

    FirebaseFirestore.instance.collection('providers').doc(technicalId).collection('services').doc(orderId).update(
        {
          'rate': rateValue,
        }
    );

    FirebaseFirestore.instance.collection('providers').doc(technicalId).update({
      'rate':FieldValue.arrayUnion([rateValue]),
    });




  }
  Future updateProfileBirthDate({
    required String birthDate,
  }) async
  {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uId).update(
          {
            'birthdate': birthDate,
          });
      getUserProfile();
      emit(UpdateProfileBirthDateSuccessState());
    } catch (error) {
      emit(UpdateProfileBirthDateErrorState(error.toString()));
    }
  }

  Future updateProfileGender({
    required String gender,
  }) async
  {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uId).update(
          {
            'gender': gender,
          });
      getUserProfile();

      emit(UpdateProfileGenderSuccessState());
    } catch (error) {
      emit(UpdateProfileGenderErrorState(error.toString()));
    }
  }



  Future updateProfileEmail({
    required String email,
  }) async
  {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uId).update(
          {
            'email': email,
          });
    await   FirebaseAuth.instance.currentUser!.updateEmail(email);
      getUserProfile();

      emit(UpdateProfileGenderSuccessState());
    } catch (error) {
      emit(UpdateProfileGenderErrorState(error.toString()));
    }
  }


}
