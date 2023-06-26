part of 'technical_home_cubit.dart';

@immutable
abstract class TechnicalHomeState {}

class TechnicalHomeInitial extends TechnicalHomeState {}

class GetTechnicalDataLoadingState extends TechnicalHomeState{}

class GetTechnicalDataSuccessState extends TechnicalHomeState{}

class GetTechnicalDataErrorState extends TechnicalHomeState
{
  final String error;

  GetTechnicalDataErrorState(this.error);
}


class SignOutTechnicalSuccessState extends TechnicalHomeState{}

class SignOutTechnicalErrorState extends TechnicalHomeState
{
  final String error;

  SignOutTechnicalErrorState(this.error);
}

class SendMessageSuccessState extends TechnicalHomeState {}

class SendMessageErrorState extends TechnicalHomeState {
  final String error;

  SendMessageErrorState(this.error);
}

class UpdateProfilePictureSuccessState extends TechnicalHomeState{}

class UpdateProfilePictureErrorState extends TechnicalHomeState
{
  final String error;

  UpdateProfilePictureErrorState(this.error);
}


class UploadProfileImageErrorState extends TechnicalHomeState{}



class AcceptRequestSuccessState extends TechnicalHomeState {}

class AcceptRequestErrorState extends TechnicalHomeState {
  final String error;

  AcceptRequestErrorState(this.error);
}

class UpdateProfileStartFromSuccessState extends TechnicalHomeState{}

class UpdateProfileStartFromErrorState extends TechnicalHomeState
{
  final String error;

  UpdateProfileStartFromErrorState(this.error);
}


class UpdateProfilePhoneSuccessState extends TechnicalHomeState{}

class UpdateProfilePhoneErrorState extends TechnicalHomeState
{
  final String error;

  UpdateProfilePhoneErrorState(this.error);
}