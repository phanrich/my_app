part of 'login_account_bloc.dart';

@immutable
abstract class LoginAccountState {}

class LoginAccountInitialState extends LoginAccountState {}

class LoginAccountLoadingState extends LoginAccountState {}

class LoginAccountLoadedState extends LoginAccountState {}

class LoginAccountErrorState extends LoginAccountState {
  final String error;
  LoginAccountErrorState({required this.error});
}

class PhoneAuthCodeSentSuccessState extends LoginAccountState {
  final String verificationId;
  PhoneAuthCodeSentSuccessState({required this.verificationId});
}

class SignUpScreenOtpSuccessState extends LoginAccountState {}
