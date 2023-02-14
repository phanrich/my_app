import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/account.dart';
import '../../repository/auth_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  StreamSubscription<Account>? _accountStreamSubscription;

  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(authRepository.currentAccount.isNotEmptyAccount
            ? AppState.authenticated(authRepository.currentAccount)
            : const AppState.unauthenticated()) {
    on<AppAccountChanged>(_onAccountChanged);

    on<AppLogoutRequested>(_onLogoutRequested);
  }

  FutureOr<void> _onAccountChanged(
      AppAccountChanged event, Emitter<AppState> emit) {
    emit(event.account.isNotEmptyAccount
        ? AppState.authenticated(event.account)
        : const AppState.unauthenticated());
  }

  FutureOr<void> _onLogoutRequested(
      AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authRepository.logout());
  }
}
