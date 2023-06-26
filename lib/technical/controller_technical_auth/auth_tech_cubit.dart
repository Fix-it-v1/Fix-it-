import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project/model/create_tech_model.dart';
import 'package:project/shared/constant.dart';

part 'auth_tech_state.dart';

class AuthTechCubit extends Cubit<AuthTechState> {
  AuthTechCubit() : super(AuthTechInitial());

  static AuthTechCubit get(context) => BlocProvider.of(context);


  Future technicalSignUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String birthDate,
    required String gender,
    required String? image,
    required String city,
    required String phone,
    required String provideType,
  }) async
  {
    emit(RegisterTechLoadingState());
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      createTechnical(firstName: firstName, lastName: lastName, email: email, birthDate: birthDate, gender: gender, image: image, city: city, phone: phone, provideType: provideType);
      print(
          'cubit register success******************************************************');
      print(response);
      uId = FirebaseAuth.instance.currentUser!.uid;
      print(uId);
      emit(RegisterTechSuccessState());
    } catch (e) {
      print(
          'cubit Register Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr   *********************************************');
      emit(RegisterTechErrorState(e.toString()));
    }
  }

  Future createTechnical({
    required String firstName,
    required String lastName,
    required String email,
    required String birthDate,
    required String gender,
    required String? image,
    required String city,
    required String phone,
    required String provideType,
  }) async
  {
    try {
      DataTechnicalModel dataTechnicalModel = DataTechnicalModel(
        startFrom: '100',
        uId: FirebaseAuth.instance.currentUser!.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        birthDate: birthDate,
        gender: gender,
        image: image??defaultProfileImagePathInFirebase,
        city: city,
        phone: phone,
        provideType: provideType,
        rate: [],
      );
      emit(CreateTechnicalLoadingState());
      print(uId);
      await FirebaseFirestore.instance.collection('providers').doc(
          FirebaseAuth.instance.currentUser!.uid).set(dataTechnicalModel.toMap());
    }
    catch (error) {
      emit(CreateTechnicalErrorState());
    }
  }


  Future technicalSignIn({
    required String email,
    required String password,
  })async
  {
    emit(LoginTechLoadingState());
    try{
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('cubit success******************************************************');
      print(response);
      uId = FirebaseAuth.instance.currentUser!.uid;
      print(uId);
      emit(LoginTechSuccessState());
    }catch(e)
    {
      print('cubit Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr   *********************************************');
      emit(LoginTechErrorState(e.toString()));
    }
  }
}
