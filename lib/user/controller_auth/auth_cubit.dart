import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:project/model/create_user_model.dart';
import 'package:project/shared/constant.dart';
import 'package:project/shared/shared_preferneces.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);


  Future userSignUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String birthDate,
    required String gender,
    required String? image,
    required String city,
    required String phone,
  }) async
  {
    emit(RegisterLoadingState());
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      createUser(firstName: firstName,
        lastName: lastName,
        email: email,
        birthDate: birthDate,
        gender: gender,
        image: image,
        city: city,
        phone: phone,);
      print(
          'cubit register success******************************************************');
      print(response);
      uId = FirebaseAuth.instance.currentUser!.uid;
      print(uId);
      emit(RegisterSuccessState());
    } catch (e) {
      print(
          'cubit Register Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr   *********************************************');
      emit(RegisterErrorState(e.toString()));
    }
  }

  Future createUser({
    required String firstName,
    required String lastName,
    required String email,
    required String birthDate,
    required String gender,
    required String? image,
    required String city,
    required String phone,
    String? userId,
  }) async
  {
    try {
      DataUserModel userDataModel = DataUserModel(
        uId: userId ?? FirebaseAuth.instance.currentUser!.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        birthDate: birthDate,
        gender: gender,
        image: image ?? defaultProfileImagePathInFirebase,
        city: city,
        phone: phone,
      );
      emit(CreateUserSuccessState());
      print(uId);
      await FirebaseFirestore.instance.collection('users').doc(
          FirebaseAuth.instance.currentUser!.uid).set(userDataModel.toMap());
    }
    catch (error) {
      emit(CreateUserErrorState());
    }
  }


  Future userSignIn({
    required String email,
    required String password,
  }) async
  {
    emit(LoginLoadingState());
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(
          'cubit success******************************************************');
      print(response);
      uId = FirebaseAuth.instance.currentUser!.uid;
      print(uId);
      emit(LoginSuccessState());
    } catch (e) {
      print(
          'cubit Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr   *********************************************');
      emit(LoginErrorState(e.toString()));
    }
  }


  Future<UserCredential> signInWithGoogle() async {
    try
    {
      emit(LoginLoadingState());

      // Trigger the authentication flow
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      GoogleSignInAuthentication? googleAuth = await googleUser
          ?.authentication;
      // ignore: unrelated_type_equality_checks


      // Create a new credential
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,

      );

      await FirebaseAuth.instance.signInWithCredential(credential).then((value)
      {
        if (GoogleSignIn().isSignedIn() !=  true) {
          createUser(
              userId: FirebaseAuth.instance.currentUser!.uid,
              firstName: googleUser!.displayName.toString(),
              lastName: '',
              email: googleUser.email,
              birthDate: '',
              gender: '',
              image: googleUser.photoUrl,
              city: '',
              phone: '');
        }

      });
      uId = FirebaseAuth.instance.currentUser!.uid;


      // Once signed in, return the UserCredential
      emit(LoginSuccessState());
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }catch(error)
    {
      emit(LoginErrorState(error.toString()));
      throw Exception('error in sign in with google');


    }

  }


  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

}
