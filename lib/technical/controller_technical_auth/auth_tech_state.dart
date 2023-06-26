part of 'auth_tech_cubit.dart';

@immutable
abstract class AuthTechState {}

class AuthTechInitial extends AuthTechState {}
class RegisterTechLoadingState extends AuthTechState {}

class RegisterTechSuccessState extends AuthTechState {}

class RegisterTechErrorState extends AuthTechState
{
  final String error;

  RegisterTechErrorState(this.error);
}

class CreateTechnicalLoadingState extends AuthTechState {}

class CreateTechnicalSuccessState extends AuthTechState {}

class CreateTechnicalErrorState extends AuthTechState
{

}

class LoginTechLoadingState extends AuthTechState {}

class LoginTechSuccessState extends AuthTechState {}

class LoginTechErrorState extends AuthTechState
{
  final String error;

  LoginTechErrorState(this.error);
}