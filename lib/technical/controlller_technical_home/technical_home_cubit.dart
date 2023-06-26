import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/model/create_tech_model.dart';
import 'package:project/model/message_model.dart';
import 'package:project/model/request_model.dart';
import 'package:project/select_t_or_c.dart';
import 'package:project/shared/constant.dart';
import 'package:project/shared/shared_preferneces.dart';
import 'package:project/technical/login.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';
part 'technical_home_state.dart';

class TechnicalHomeCubit extends Cubit<TechnicalHomeState> {
  TechnicalHomeCubit() : super(TechnicalHomeInitial());

  static TechnicalHomeCubit get(context) => BlocProvider.of(context);

  DataTechnicalModel dataTechnicalModel = DataTechnicalModel(
    startFrom: '',
    uId: '',
    firstName: '',
    lastName: '',
    email: '',
    birthDate: '',
    gender: '',
    image: '',
    city: '',
    phone: '',
    provideType: '',
    rate: [],
  );

  Future<DataTechnicalModel> getTechnicalProfile() async {
    emit(GetTechnicalDataLoadingState());
    try {
      final response = await FirebaseFirestore.instance
          .collection('providers')
          .doc(uId)
          .get()
          .then((value) {
        return DataTechnicalModel.fromJson(value.data()!);
      });
      dataTechnicalModel = response ;
      emit(GetTechnicalDataSuccessState());
      return response;
    } catch (error) {
      emit(GetTechnicalDataErrorState(error.toString()));
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
      emit(SignOutTechnicalSuccessState());
    }).catchError((error)
    {
      emit(SignOutTechnicalErrorState(error.toString()));

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
          .collection('providers')
          .doc(uId)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .add(model.toMap());

      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(uId)
          .collection('messages')
          .add(model.toMap());
      emit(SendMessageSuccessState());
    } catch (error)
    {
      emit(SendMessageErrorState(error.toString()));
    }
  }


  Future updateProfilePicture({
    required String profileImage,
}) async
  {
    try {
      await FirebaseFirestore.instance.collection('providers').doc(uId).update(
          {
            'image': profileImage,
          });
      emit(UpdateProfilePictureSuccessState());
    } catch (error) {
      emit(UpdateProfilePictureErrorState(error.toString()));
    }
  }
  void uploadProfileImage(profileImage) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) async {
      updateProfilePicture(profileImage: await value.ref.getDownloadURL());
      getTechnicalProfile();
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
      print(error.toString());
    });
  }


  Future acceptRequest({
    required String receiverId,
    required String technicalName,
    required String timeCreating,
    required String technicalPhone,
    required String userName,
    required String requestType,
    required String  location,
    required String  requestId,

  }) async {
    String servicesId = Uuid().v4();
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
          .collection('providers')
          .doc(uId)
          .collection('services').doc(servicesId)
          .set(requestModel.toMap());

      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('ordersList').doc(servicesId)
          .set(requestModel.toMap());
      deleteRequestWhenAcceptOrReject(requestId: requestId);
      emit(AcceptRequestSuccessState());
    } catch (error)
    {
      emit(AcceptRequestErrorState(error.toString()));
    }
  }

  Future deleteRequestWhenAcceptOrReject({required String requestId })async
  {
    FirebaseFirestore.instance
        .collection('providers')
        .doc(uId)
        .collection('requests').doc(requestId).delete();
  }


  Future updateProfileStartFrom({
    required String startFrom,
  }) async
  {
    try {
      await FirebaseFirestore.instance.collection('providers').doc(uId).update(
          {
            'startFrom': startFrom,
          });
      getTechnicalProfile();
      emit(UpdateProfileStartFromSuccessState());
    } catch (error) {
      emit(UpdateProfileStartFromErrorState(error.toString()));
    }
  }

  Future updateProfilePhone({
    required String phone,
  }) async
  {
    try {
      await FirebaseFirestore.instance.collection('providers').doc(uId).update(
          {
            'phone': phone,
          });
      emit(UpdateProfilePhoneSuccessState());
    } catch (error) {
      emit(UpdateProfilePhoneErrorState(error.toString()));
    }
    getTechnicalProfile();

  }

  Future updateProfileAbout({
    required String about,
  }) async
  {
    try {
      await FirebaseFirestore.instance.collection('providers').doc(uId).update(
          {
            'aboutMe': about,
          });
      getTechnicalProfile();
      emit(UpdateProfilePhoneSuccessState());
    } catch (error) {
      emit(UpdateProfilePhoneErrorState(error.toString()));
    }
  }


}
