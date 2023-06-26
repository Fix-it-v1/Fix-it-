part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}


class GetProfileDataLoadingState extends HomeState{}

class GetProfileDataSuccessState extends HomeState{}

class GetProfileDataErrorState extends HomeState
{
  final String error;

  GetProfileDataErrorState(this.error);
}


class SignOutDataSuccessState extends HomeState{}

class SignOutDataErrorState extends HomeState
{
  final String error;

  SignOutDataErrorState(this.error);
}
class UpdateUserProfilePictureSuccessState extends HomeState{}

class UpdateUserProfilePictureErrorState extends HomeState
{
  final String error;

  UpdateUserProfilePictureErrorState(this.error);
}


class UploadUserProfileImageErrorState extends HomeState{}


class SendUserMessageSuccessState extends HomeState {}

class SendUserMessageErrorState extends HomeState {
  final String error;

  SendUserMessageErrorState(this.error);
}


class SendUserRequestSuccessState extends HomeState {}

class SendUserRequestErrorState extends HomeState {
  final String error;

  SendUserRequestErrorState(this.error);
}

class UpdateProfileGenderSuccessState extends HomeState {}

class UpdateProfileGenderErrorState extends HomeState {
  final String error;

  UpdateProfileGenderErrorState(this.error);
}

class UpdateProfileBirthDateSuccessState extends HomeState {}

class UpdateProfileBirthDateErrorState extends HomeState {
  final String error;

  UpdateProfileBirthDateErrorState(this.error);
}

class UpdateProfileEmailSuccessState extends HomeState {}

class UpdateProfileEmailErrorState extends HomeState {
  final String error;

  UpdateProfileEmailErrorState(this.error);
}