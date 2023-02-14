import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:meta/meta.dart';

import '../../repository/auth_repository.dart';

part 'login_account_event.dart';
part 'login_account_state.dart';

class LoginAccountBloc extends Bloc<LoginAccountEvent, LoginAccountState> {
  final AuthRepository _authRepository = AuthRepository();

  LoginAccountBloc(LoginAccountInitialState loginAccountInitialState)
      : super(LoginAccountInitialState()) {
    on<SendOtpToPhoneEvent>(_onSendOtpToPhone);
    on<OnPhoneOtpSendEvent>(_onPhoneOtpSend);
    on<VerifySendOtpEvent>(_onVerifySendOtpEvent);
    on<OnPhoneAuthErrorEvent>(_onPhoneAuthError);
    on<OnPhoneAuthVerifiCationCompletedEvent>(
        _onPhoneAuthVerifiCationCompleted);
  }

  FutureOr<void> _onSendOtpToPhone(
      SendOtpToPhoneEvent event, Emitter<LoginAccountState> emit) {
    emit(LoginAccountLoadingState());
    try {
      _authRepository.loginWithPhone(
          phoneNumber: event.phone,
          verificationCompleted:
              (firebase_auth.PhoneAuthCredential authCredential) {
            add(OnPhoneAuthVerifiCationCompletedEvent(
                authCredential: authCredential));
          },
          verificationFailed: (firebase_auth.FirebaseAuthException e) {
            add(OnPhoneAuthErrorEvent(error: e.toString()));
          },
          codeSent: (String vericationId, int? refreshToken) {
            add(OnPhoneOtpSendEvent(
                vericationId: vericationId, token: refreshToken));
          },
          codeAutoRetrievalTimeout: (String timeOut) {});
    } catch (error) {
      emit(LoginAccountErrorState(error: error.toString()));
    }
  }

  FutureOr<void> _onPhoneOtpSend(
      OnPhoneOtpSendEvent event, Emitter<LoginAccountState> emit) {
    emit(PhoneAuthCodeSentSuccessState(verificationId: event.vericationId));
  }

  FutureOr<void> _onVerifySendOtpEvent(
      VerifySendOtpEvent event, Emitter<LoginAccountState> emit) {
    try {
      firebase_auth.PhoneAuthCredential credential =
          firebase_auth.PhoneAuthProvider.credential(
              verificationId: event.verificationId, smsCode: event.otpCode);
      add(OnPhoneAuthVerifiCationCompletedEvent(authCredential: credential));
    } catch (error) {
      emit(LoginAccountErrorState(error: error.toString()));
    }
  }

  FutureOr<void> _onPhoneAuthError(
      OnPhoneAuthErrorEvent event, Emitter<LoginAccountState> emit) {
    emit(LoginAccountErrorState(error: event.error.toString()));
  }

  FutureOr<void> _onPhoneAuthVerifiCationCompleted(
      OnPhoneAuthVerifiCationCompletedEvent event,
      Emitter<LoginAccountState> emit) async {
    try {
      await _authRepository.signInWithCredential(
          credential: event.authCredential);
      emit(SignUpScreenOtpSuccessState());
      emit(LoginAccountLoadedState());
    } catch (error) {
      emit(LoginAccountErrorState(error: error.toString()));
    }
  }
}
