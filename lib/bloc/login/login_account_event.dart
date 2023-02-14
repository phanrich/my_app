part of 'login_account_bloc.dart';

@immutable
abstract class LoginAccountEvent {}

class SendOtpToPhoneEvent extends LoginAccountEvent {
  final String phone;
  SendOtpToPhoneEvent({required this.phone});
}

class OnPhoneOtpSendEvent extends LoginAccountEvent {
  final String vericationId;
  final int? token;

  OnPhoneOtpSendEvent({required this.vericationId, required this.token});
}

class VerifySendOtpEvent extends LoginAccountEvent {
  final String otpCode;
  final String verificationId;

  VerifySendOtpEvent({
    required this.verificationId,
    required this.otpCode,
  });
}

class OnPhoneAuthErrorEvent extends LoginAccountEvent {
  final String error;
  OnPhoneAuthErrorEvent({required this.error});
}

class OnPhoneAuthVerifiCationCompletedEvent extends LoginAccountEvent {
  final firebase_auth.AuthCredential authCredential;

  OnPhoneAuthVerifiCationCompletedEvent({required this.authCredential});
}
