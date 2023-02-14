part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AppEvent {}

class AppAccountChanged extends AppEvent {
  final Account account;
  const AppAccountChanged(this.account);

  @override
  List<Object> get props => [account];
}
